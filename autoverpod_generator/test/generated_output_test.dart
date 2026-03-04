import 'dart:io';

import 'package:test/test.dart';

void main() {
  test('example generation produces expected output', () async {
    final result = await Process.run(
      'dart',
      const [
        'run',
        'lean_builder',
        'build',
      ],
      workingDirectory: '../example',
    );

    if (result.exitCode != 0) {
      fail(
        'lean_builder build failed (exitCode=${result.exitCode})\n'
        'stdout:\n${result.stdout}\n'
        'stderr:\n${result.stderr}',
      );
    }

    final generatedFile = File('../example/lib/user_profile.widget.dart');
    expect(generatedFile.existsSync(), isTrue);

    final content = generatedFile.readAsStringSync();

    expect(content, contains('ParamsBuilder'));
    expect(content, contains('/// **Usage:**'));

    expect(content, isNot(contains('file://')));
    expect(content, isNot(contains('valueOrNull')));

    // Single-family-param optimization should not use record types.
    expect(content, isNot(contains('({int id})')));
    expect(content, contains('int get _params'));
    expect(content, contains('WidgetRef get widgetRef => _ref;'));
    expect(content, contains('final bool skipLoadingOnRefresh;'));
    expect(content, contains('final bool skipLoadingOnReload;'));
    expect(content, contains('final bool skipError;'));
    expect(
      content,
      contains(
        'skipLoadingOnRefresh: scopeConfig?.skipLoadingOnRefresh ?? true,',
      ),
    );
    expect(
      content,
      contains(
        'skipLoadingOnReload: scopeConfig?.skipLoadingOnReload ?? false,',
      ),
    );
    expect(content, contains('skipError: scopeConfig?.skipError ?? false,'));
  });
}
