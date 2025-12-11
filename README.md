# Autoverpod

A code generator that creates field widgets from Riverpod providers with automatic `TextEditingController` synchronization.

## Features

- 📝 **Auto TextEditingController Sync** - String fields get automatic bidirectional sync between state and controller
- 🔄 **Field Update Extensions** - Generated extension methods for updating individual fields
- 🎯 **Scope Widget** - `InheritedWidget` for family provider parameters (always generated for future-proofing)
- ⚡ **State/Select Widgets** - Reactive UI widgets for consuming provider state

## Packages

| Package | Description |
|---------|-------------|
| `autoverpod_annotation` | Annotations only (pure Dart, no Flutter) |
| `autoverpod` | Flutter widgets + re-exports annotations |
| `autoverpod_generator` | Code generator (uses lean_builder) |

## Installation

Add to your `pubspec.yaml`:

```yaml
dependencies:
  autoverpod: ^0.1.0
  flutter_riverpod: ^3.0.0

dev_dependencies:
  autoverpod_generator: ^0.1.0
  lean_builder: ^0.1.2
```

## Usage

### 1. Define your state class

```dart
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:autoverpod/autoverpod.dart';

part 'user_profile.freezed.dart';
part 'user_profile.g.dart';

@freezed
sealed class UserProfileState with _$UserProfileState {
  const factory UserProfileState({
    @Default('') String name,
    @Default('') String email,
    @Default(0) int age,
    String? bio,
  }) = _UserProfileState;
}
```

### 2. Create an annotated provider

```dart
@stateWidget
@riverpod
class UserProfile extends _$UserProfile {
  @override
  UserProfileState build() => const UserProfileState();
}
```

### 3. Run the generator

```bash
dart run lean_builder watch
```

### 4. Use generated widgets

```dart
// Generated field widget with auto controller sync
UserProfileNameField(
  builder: (context, ref) => TextField(
    controller: ref.controller,
  ),
)

// Update field value
ref.read(userProfileProvider.notifier).updateName('John');
```

## Generated Code

For a provider annotated with `@stateWidget`, the generator creates:

- **Field Updater Extension** - `update{FieldName}()` methods
- **Scope Widget** - `{ProviderName}Scope` for family parameters
- **State Widget** - `{ProviderName}Widget` rebuilds on any change
- **Select Widget** - `{ProviderName}Select<T>` rebuilds only on selected value
- **Field Widgets** - `{ProviderName}{FieldName}Field` for each field

## StringField Helper

The `StringField` widget handles `TextEditingController` synchronization automatically:

```dart
StringField(
  value: currentValue,
  onChanged: (newValue) => updateState(newValue),
  builder: (context, ref) => TextField(
    controller: ref.controller,
  ),
)
```

## Why lean_builder?

This package uses `lean_builder` instead of `build_runner` for:
- Faster generation
- Simpler configuration
- Cleaner generated code

## License

MIT License - see [LICENSE](LICENSE) for details.
