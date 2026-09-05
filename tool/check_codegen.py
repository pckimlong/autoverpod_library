#!/usr/bin/env python3
"""Verify clean, incremental, unchanged-input and watch generation in a fresh workspace.

Optional --schema-root and --mutation-root point to migrated upstream checkouts.
No dependency overrides are used: all local packages participate in a Pub workspace.
"""
import argparse
import hashlib
import json
import os
import re
from pathlib import Path
import shutil
import subprocess
import tempfile
import time

ROOT = Path(__file__).resolve().parents[1]
parser = argparse.ArgumentParser(description=__doc__)
parser.add_argument('--analyzer', default='>=13.3.0 <15.0.0')
parser.add_argument('--schema-root', type=Path)
parser.add_argument('--mutation-root', type=Path)
parser.add_argument('--build')
parser.add_argument('--build-runner')
parser.add_argument('--freezed')
parser.add_argument('--keep', action='store_true')
args = parser.parse_args()
if bool(args.schema_root) != bool(args.mutation_root):
    parser.error('Supply both upstream roots to run the combined integration.')


def run(cwd, *command, **kwargs):
    print('+', ' '.join(command), flush=True)
    subprocess.run(command, cwd=cwd, check=True, **kwargs)


def outputs(consumer):
    return {str(p.relative_to(consumer)): hashlib.sha256(p.read_bytes()).hexdigest()
            for p in (consumer / 'lib').glob('*.dart')
            if p.name.endswith(('.g.dart', '.freezed.dart', '.widget.dart', '.supabase.dart'))}


fixture = Path(tempfile.mkdtemp(prefix='autoverpod-codegen-'))
print('Fixture:', fixture, flush=True)
try:
    packages = {name: ROOT / name for name in
                ('autoverpod', 'autoverpod_annotation', 'autoverpod_generator')}
    if args.schema_root:
        packages.update({name: args.schema_root / name for name in
                         ('supabase_schema', 'supabase_schema_generator')})
        packages.update({name: args.mutation_root / 'packages' / name for name in
                         ('riverpod_mutation_utils', 'riverpod_mutation_utils_generator')})
    for name, source in packages.items():
        destination = fixture / name
        destination.mkdir()
        for filename in ('pubspec.yaml', 'build.yaml', 'analysis_options.yaml'):
            if (source / filename).exists():
                shutil.copy(source / filename, destination / filename)
        # A consumer does not inherit dependency packages' development tools.
        manifest = destination / 'pubspec.yaml'
        manifest.write_text(re.sub(r'(?ms)^dev_dependencies:.*?(?=^\S|\Z)', '', manifest.read_text()))
        shutil.copytree(source / 'lib', destination / 'lib')
    (fixture / 'pubspec.yaml').write_text(
        'name: codegen_compatibility\npublish_to: none\nenvironment:\n  sdk: ^3.13.0\nworkspace:\n' +
        ''.join(f'  - {name}\n' for name in packages) + '  - consumer\n')
    consumer = fixture / 'consumer'
    (consumer / 'lib').mkdir(parents=True)
    (consumer / 'test').mkdir()
    for source in (ROOT / 'example/lib').glob('*.dart'):
        if not source.name.endswith(('.g.dart', '.freezed.dart', '.widget.dart')):
            shutil.copy(source, consumer / 'lib' / source.name)
    for source in (ROOT / 'tool/integration/lib').glob('nested_*.dart'):
        shutil.copy(source, consumer / 'lib' / source.name)
    pubspec = (ROOT / 'example/pubspec.yaml').read_text()
    pubspec = pubspec.split('# Use the local annotation')[0]
    pubspec = pubspec.replace('publish_to:', 'resolution: workspace\npublish_to:')
    pubspec = pubspec.replace('    path: ../autoverpod\n', '    version: any\n')
    pubspec = pubspec.replace('    path: ../autoverpod_generator\n', '    version: any\n')
    pubspec = pubspec.replace('dev_dependencies:\n',
                              f'dev_dependencies:\n  lints: ^6.0.0\n  analyzer: {json.dumps(args.analyzer)}\n')
    for package, version in (('build', args.build), ('build_runner', args.build_runner), ('freezed', args.freezed)):
        if version:
            pubspec = re.sub(rf'(?m)^  {package}:.*\n', '', pubspec)
            pubspec = pubspec.replace('dev_dependencies:\n', f'dev_dependencies:\n  {package}: {json.dumps(version)}\n')
    if args.schema_root:
        pubspec = pubspec.replace('\ndependencies:\n', '\ndependencies:\n  supabase_schema: any\n  riverpod_mutation_utils: any\n  json_annotation: ^4.12.0\n')
        pubspec = pubspec.replace('dev_dependencies:\n', 'dev_dependencies:\n  supabase_schema_generator: any\n  riverpod_mutation_utils_generator: any\n  json_serializable: ^6.10.0\n')
        for source in (ROOT / 'tool/integration/lib').glob('*.dart'):
            shutil.copy(source, consumer / 'lib' / source.name)
        shutil.copy(ROOT / 'tool/integration/test/schema_test.dart', consumer / 'test')
    (consumer / 'pubspec.yaml').write_text(pubspec)
    shutil.copy(ROOT / 'example/build.yaml', consumer / 'build.yaml')
    shutil.copy(ROOT / 'tool/integration/test/consumer_test.dart', consumer / 'test')
    provider = consumer / 'lib/user_profile.dart'
    provider.write_text(provider.read_text().replace("part 'user_profile.freezed.dart';", "import 'user_profile.widget.dart';\n\npart 'user_profile.freezed.dart';").replace("class UserProfile extends _$UserProfile {", "class UserProfile extends _$UserProfile {\n  void resetName() => updateName('');") + '''
@stateWidget
@riverpod
class AsyncPlain extends _$AsyncPlain {
  @override
  Future<UserProfileState> build() async => const UserProfileState();
}
''')
    run(consumer, 'flutter', 'pub', 'get')
    run(fixture, 'dart', 'analyze', 'autoverpod_generator/lib', 'autoverpod_annotation/lib')
    run(consumer, 'dart', 'run', 'build_runner', 'build')
    expected = ['user_profile.widget.dart', 'user_profile.g.dart', 'user_profile.freezed.dart',
                'import_resolution_provider.widget.dart', 'nested_types.widget.dart']
    if args.schema_root:
        expected += ['schema.supabase.dart', 'schema.supabase.freezed.dart',
                     'schema.supabase.g.dart', 'schema_provider.g.dart', 'schema_provider.widget.dart']
    for name in expected:
        assert (consumer / 'lib' / name).is_file(), f'Missing {name}'
    run(consumer, 'dart', 'analyze', 'lib', 'test')
    run(consumer, 'flutter', 'test')
    # Exercise the existing public output regression assertions on fresh output.
    run(ROOT / 'autoverpod_generator', 'dart', 'test', env={**os.environ, 'AUTOVERPOD_CONSUMER': str(consumer)})
    provider.write_text(provider.read_text().replace("@Default('') String email,", "@Default('') String email,\n    @Default('') String nickname,"))
    run(consumer, 'dart', 'run', 'build_runner', 'build')
    assert 'updateNickname' in (consumer / 'lib/user_profile.widget.dart').read_text()
    if args.schema_root:
        schema = consumer / 'lib/schema.dart'
        schema.write_text(schema.read_text().replace("  final name =", "  final note = Field<String?>('note');\n  final name ="))
        schema_provider = consumer / 'lib/schema_provider.dart'
        schema_provider.write_text(schema_provider.read_text().replace("name: 'Schema'", "name: 'Schema', note: null"))
        run(consumer, 'dart', 'run', 'build_runner', 'build')
        assert 'updateNote' in (consumer / 'lib/schema_provider.widget.dart').read_text()
    run(consumer, 'dart', 'analyze', 'lib', 'test')
    before = outputs(consumer)
    run(consumer, 'dart', 'run', 'build_runner', 'build')
    assert outputs(consumer) == before, 'Unchanged build modified output'
    log_path = fixture / 'watch.log'
    with log_path.open('w') as log:
        watch = subprocess.Popen(['dart', 'run', 'build_runner', 'watch'], cwd=consumer,
                                 stdout=log, stderr=subprocess.STDOUT)
        try:
            def wait_for(predicate):
                deadline = time.monotonic() + 120
                while time.monotonic() < deadline:
                    if watch.poll() is not None:
                        raise AssertionError(log_path.read_text())
                    if predicate():
                        return
                    time.sleep(.2)
                raise AssertionError('Watch timeout:\n' + log_path.read_text())
            wait_for(lambda: 'Built with build_runner' in log_path.read_text())
            provider.write_text(provider.read_text().replace('String nickname,', 'String watchName,'))
            wait_for(lambda: 'updateWatchName' in (consumer / 'lib/user_profile.widget.dart').read_text())
        finally:
            watch.terminate()
            try:
                watch.wait(timeout=10)
            except subprocess.TimeoutExpired:
                watch.kill()
                watch.wait()
    run(consumer, 'dart', 'analyze', 'lib', 'test')
    run(consumer, 'flutter', 'test')
    lock = (fixture / 'pubspec.lock').read_text()
    for package in ('analyzer', 'build', 'build_runner', 'source_gen', 'freezed', 'riverpod_generator', 'riverpod_annotation', 'flutter_riverpod', 'json_serializable'):
        match = re.search(rf'(?ms)^  {package}:.*?^    version: ([^\n]+)$', lock)
        if match:
            print(f'{package}: {match.group(1)}', flush=True)
    print('PASS: clean build, compilation, runtime tests, incremental, unchanged, watch', flush=True)
finally:
    if not args.keep:
        shutil.rmtree(fixture)
