# Generator compatibility verification

Verified on Flutter 3.47.0 / Dart 3.13.0 on 2026-09-05.

| Check | analyzer | build | build_runner | source_gen | Freezed |
| --- | --- | --- | --- | --- | --- |
| Supported lower analyzer | 13.3.0 | 4.0.11 | 2.16.1 | 4.2.4 | 4.0.1 |
| Analyzer 14 | 14.0.0 | 4.0.11 | 2.16.1 | 4.3.0 | 4.0.1 |
| Latest compatible solve | 14.3.0 | 4.0.11 | 2.16.1 | 4.3.0 | 4.0.1 |
| Older compatible tools | 13.3.0 | 4.0.6 | 2.15.0 | 4.2.4 | 4.0.0 |

The clean consumers selected Riverpod Generator 4.0.9, Riverpod Annotation
4.0.7, Flutter Riverpod 3.4.3, and Freezed Annotation 3.1.0. Combined schema
integration selected JSON Serializable 6.14.1 and JSON Annotation 4.12.0.
These are tested combinations, not exact dependency pins.

Every row passed a clean one-command build, static analysis of the generator and
consumer, synchronous/asynchronous family/non-family updates, generated text
controller behavior, incremental Freezed edits, an unchanged-input build, and
watch regeneration. Imported extension types, typedefs, record fields, and
multiple family parameters compile. A provider importing its own widget output
and calling a generated field updater also passes clean generation and watch.

The existing generator output regression passes against freshly generated
consumer output. All 37 runtime tests pass, including controller ownership,
synchronization, nullable values, debounce, and number-field behavior.
The checked-in example generates and analyzes cleanly; a subsequent unchanged
build writes zero outputs. Formatting and `git diff --check` pass.

## Reproduce

From the repository root:

```sh
flutter pub get
python3 tool/check_codegen.py --analyzer 13.3.0
python3 tool/check_codegen.py --analyzer 14.0.0
python3 tool/check_codegen.py
python3 tool/check_codegen.py --analyzer 13.3.0 \
  --build 4.0.6 --build-runner 2.15.0 --freezed 4.0.0
```

The CI matrix runs these four cases. Each invocation creates a new temporary Pub
workspace without generated files, a lockfile, or build cache. Local dependency
packages are copied without their development dependencies, matching normal
transitive package behavior. No dependency overrides are used. `--keep` retains
the workspace, resolved lockfile, generated outputs, and watch log for inspection.

## Schema and mutation integration

```sh
python3 tool/check_codegen.py --analyzer 14.0.0 \
  --schema-root /path/to/supabase_schema_library \
  --mutation-root /path/to/riverpod_mutation_utils
```

Combined integration passed with analyzer 13.3.0, 14.0.0, and 14.3.0 against
local migrated upstream snapshots. It verifies `.supabase.dart`, schema Freezed
and JSON outputs, mutation/provider `.g.dart`, and `.widget.dart` in the first
build; schema field edits reach widget updates in the next build. Runtime checks
exercise schema JSON round trips, generated field updates, and mutation submit.

The schema snapshot was based on commit
`24b11a7c73a31ec0e5315e857ed95b562a8b2df9`; the mutation snapshot was based on
`33a44f3bc41a39918d571eb696949d9a75ea45d2` plus local analyzer migration changes.
These upstream repositories were not modified by this migration. The combined
integration is reproducible via the optional paths but is not enabled in CI,
because the mutation compatibility changes were uncommitted upstream during
verification. Published upstream versions with incompatible constraints still
need their own migration/release. The older-tools row covers Autoverpod,
Freezed, and Riverpod without the optional upstream generators.

The generator's declared Dart floor is 3.11, required by analyzer 13.3.0;
execution was verified on Dart 3.13. Freezed 4 requires Dart 3.13. There is no
claim of testing every version within the supported constraint ranges.
