# AutoVerpod Generator

`autoverpod_generator` powers Autoverpod's code generation using [`lean_builder`](https://pub.dev/packages/lean_builder). It scans for classes annotated with `@stateWidget` and `@riverpod` and generates the widgets and helpers consumed by the `autoverpod` runtime package.

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
  lean_builder: ^<latest>
```

In a package that uses the generated widgets, dependencies typically include:

```yaml
dependencies:
  autoverpod: ^<latest>
  flutter_riverpod: ^<latest>

dev_dependencies:
  riverpod_annotation: ^<latest>
  freezed_annotation: ^<latest>
```

Alternatively, the same dependencies can be added with:

```bash
dart pub add autoverpod
dart pub add flutter_riverpod
dart pub add --dev autoverpod_generator
dart pub add --dev lean_builder
dart pub add --dev riverpod_annotation
dart pub add --dev freezed_annotation
```

## Running the generator

From the root of the package that contains the annotated providers:

```bash
dart run lean_builder watch
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
