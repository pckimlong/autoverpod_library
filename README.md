# Autoverpod

Autoverpod is a set of packages that generate widgets and helpers from class-based Riverpod providers annotated with `@stateWidget`.

## What it does

For each class-based `@riverpod` provider annotated with `@stateWidget`, the `autoverpod_generator` package creates:

- `Scope` widget: `{ProviderName}Scope` to pass family parameters down the tree
- `State` widget: `{ProviderName}Widget` that rebuilds when any part of the state changes
- `Select` widget: `{ProviderName}Select<T>` that rebuilds only when a selected value changes
- Field widgets: `{ProviderName}{FieldName}Field` for building per-field UI
- Field updater extensions: methods like `updateName()` on the provider notifier

String fields can use an optional helper that manages a `TextEditingController` and keeps it in sync with the field value.

## Typical use cases

- Riverpod applications that model state as Freezed (or similar) data classes with multiple fields
- Screens that share one provider and contain several widgets that read or update individual fields
- Form or profile/edit screens that perform per-field updates without separate `ConsumerWidget` classes
- Family providers that pass a parameter through a scope widget instead of through each widget constructor

One common case is a profile or form screen with several text fields bound to a single provider. In that situation a generated field widget can be paired with a Flutter `TextField`:

```dart
UserProfileNameField(
  builder: (context, ref) {
    return TextField(
      controller: ref.textController,
      decoration: const InputDecoration(labelText: 'Name'),
    );
  },
);
```

The field widget keeps the `TextEditingController` and the `name` value on the provider in sync, while other widgets on the screen may read the same provider through the generated `UserProfileWidget` or `UserProfileSelect`.

## How to use

### 1. Add dependencies

`pubspec.yaml` typically contains:

```yaml
dependencies:
  autoverpod: ^<latest>
  flutter_riverpod: ^<latest>

dev_dependencies:
  autoverpod_generator: ^<latest>
  lean_builder: ^<latest>
```

Alternatively, the same dependencies can be added with:

```bash
dart pub add autoverpod
dart pub add flutter_riverpod
dart pub add --dev autoverpod_generator
dart pub add --dev lean_builder
```

### 2. Define state and provider

```dart
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:autoverpod/autoverpod.dart';

part 'user_profile.freezed.dart';
part 'user_profile.g.dart';

@freezed
class UserProfileState with _$UserProfileState {
  const factory UserProfileState({
    @Default('') String name,
    @Default('') String email,
  }) = _UserProfileState;
}

@stateWidget
@riverpod
class UserProfile extends _$UserProfile {
  @override
  UserProfileState build(int id) => const UserProfileState();
}
```

### 3. Run the generator

From the package that contains the providers:

```bash
dart run lean_builder watch
```

### 4. Use generated widgets

```dart
// Rebuilds when any field in UserProfileState changes
UserProfileWidget(
  builder: (context, ref, state) {
    return Column(
      children: [
        Text('Name: ${state.name}'),
        // Only rebuilds when the selected value (email) changes
        UserProfileSelect(
          selector: (state) => state.email,
          builder: (context, ref, email) => Text(email),
        ),
      ],
    );
  },
);
```

The generator also produces `UserProfileNameField`, `UserProfileEmailField`, and an extension with `updateName`, `updateEmail`, and similar methods for per-field widgets and updates.

### Family providers and scope

For providers with parameters, a scope widget can be used to pass the parameter to descendants:

```dart
@stateWidget
@riverpod
class UserProfile extends _$UserProfile {
  @override
  UserProfileState build(int userId) => const UserProfileState();
}

UserProfileScope(
  userId: 123,
  child: Column(
    children: [
      UserProfileNameField(builder: ...),
      UserProfileEmailField(builder: ...),
    ],
  ),
);
```

The parameter can also be passed directly to an individual field widget instead of via a scope.

### Builder ref API

In the generated widget builders, the `ref` argument is a proxy object that exposes a subset of the usual Riverpod APIs together with some field-specific helpers. For example:

```dart
UserProfileSelect(
  selector: (state) => state.name,
  builder: (context, ref, name) {
    // ref.notifier  - provider notifier
    // ref.select()  - derived values from state
    // ref.watch()   - watch other providers
    // ref.read()    - read other providers
    return Text(name);
  },
);
```

In string field builders, a `StringFieldRef` is provided, which includes a `TextEditingController` and an `update` function corresponding to the field.

## Packages

| Package | Description |
|---------|-------------|
| `autoverpod_annotation` | Annotations only (pure Dart, no Flutter) |
| `autoverpod` | Flutter widgets + re-exports annotations |
| `autoverpod_generator` | Code generator (uses lean_builder) |

## License

MIT License - see [LICENSE](LICENSE) for details.
