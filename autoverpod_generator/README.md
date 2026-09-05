# AutoVerpod Generator

`autoverpod_generator` powers Autoverpod's code generation using [`build_runner`](https://pub.dev/packages/build_runner). It scans for classes annotated with `@stateWidget` and `@riverpod` and generates the widgets and helpers consumed by the `autoverpod` runtime package.

> 0.1.0 is a complete rewrite. All previous form-based generators (`@FormWidget`, `@FormUpdateWidget`, etc.) have been removed. See `CHANGELOG.md` for details.

## What it does

When it finds a class-based `@riverpod` provider annotated with `@stateWidget`, the generator emits:

- Field updater extensions for the provider notifier
- Scope widgets for family parameters
- `*Widget` and `*Select` widgets for consuming provider state
- Field widgets for each state field

For string fields, the generated widgets can use the `StringField` helper from `autoverpod` to keep a `TextEditingController` in sync with the string value, but that helper is optional and not required by the generator itself.

## Typical use cases

- Application packages that declare Riverpod providers with `@stateWidget` and want generated widgets instead of hand-written `ConsumerWidget` classes
- Shared UI or feature packages that expose generated widgets to multiple applications

## Installation

Add the generator to a package that declares annotated providers:

```yaml
dev_dependencies:
  autoverpod_generator: ^<latest>
  build_runner: ^2.15.0
  riverpod_generator: ^4.0.3
  freezed: ^4.0.0
```

In a package that uses the generated widgets, dependencies typically include:

```yaml
dependencies:
  autoverpod: ^<latest>
  flutter_riverpod: ^3.0.3
  riverpod_annotation: ^4.0.2
  freezed_annotation: ^3.1.0

```

Alternatively, the same dependencies can be added with:

```bash
dart pub add autoverpod
dart pub add flutter_riverpod
dart pub add --dev autoverpod_generator
dart pub add --dev build_runner riverpod_generator freezed
dart pub add riverpod_annotation
dart pub add freezed_annotation
```

## Running the generator

From the root of the package that contains the annotated providers:

```bash
dart run build_runner build
# Or continuously regenerate after edits:
dart run build_runner watch
```

This generates `*.widget.dart` files next to the source files.

## Example

Given a provider:

```dart
@stateWidget
@riverpod
class UserProfile extends _$UserProfile {
  @override
  UserProfileState build(int id) => const UserProfileState();
}
```

`autoverpod_generator` creates `user_profile.widget.dart` with the widgets and helpers described in the `autoverpod` README.

## Compatibility and ordering

The generator requires Dart 3.11 or later and analyzer `>=13.3.0 <15.0.0`.
The Freezed 4 example and combined integration require Dart 3.13 (Flutter 3.47).
Runtime and annotation package SDK requirements are unchanged. Compatible older
versions remain eligible for Pub resolution; source_gen 4.2.4 is needed with
analyzer 13.3.0, while newer compatible solves can use source_gen 4.3.x.

One build/watch command runs every installed builder. Autoverpod declares
`.supabase.dart`, `.freezed.dart`, and `.g.dart` as required inputs:

1. Schema generators emit standalone `.supabase.dart` libraries.
2. Freezed emits `.freezed.dart`; JSON Serializable, Riverpod, and mutation
   generators emit shared parts, combined by source_gen into `.g.dart`.
3. Autoverpod resolves the completed model/provider libraries and emits
   standalone `.widget.dart` libraries. Import these files; do not add them as parts.

Autoverpod does not produce shared `.g.dart` parts, so there is no reverse edge
from the combining builder to widget generation. No consumer build.yaml or
manual two-pass generation is needed. A custom upstream generator must not depend
on `.widget.dart` outputs; that would introduce a generation cycle.

Remove the previous generator runner from your dev dependencies and scripts.
Annotations, `.widget.dart` names, public widget APIs, and controller semantics
are unchanged. Existing generated files may be replaced on the first migration
build; if build_runner reports conflicting outputs, use its
`--delete-conflicting-outputs` option once.

## Verification

Run `flutter pub get`, then `python3 tool/check_codegen.py` from the repository root. The harness creates
an empty temporary consumer with no generated files, lockfile, or build cache,
then checks clean generation, compilation, runtime field updates, controller
behavior, incremental edits, unchanged outputs, and watch regeneration.
CI runs this against analyzer 13.3.0, 14.0.0, and the newest compatible solve.

For schema and mutation integration against migrated upstream checkouts:

```bash
python3 tool/check_codegen.py --analyzer 13.3.0 \
  --schema-root /path/to/supabase_schema_library \
  --mutation-root /path/to/riverpod_mutation_utils
```

The upstream paths are copied into the temporary Pub workspace. Version
constraints are respected without overrides. The mutation generator checkout
must support analyzer 13.3–14.x; an older published generator with incompatible
constraints cannot be made compatible by Autoverpod's builder ordering.

See [the verification report](../tool/README.md) for exact tested versions and upstream limitations.
