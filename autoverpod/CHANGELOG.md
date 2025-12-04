## 0.0.6 - 2025-12-05

### BREAKING CHANGES

- **Removed StateWidget annotation** - The StateWidget annotation has been removed. Use the new FormWidget annotation instead for form state management.
- **Updated Riverpod exports** - Replaced `StateProvider` export with `Mutation` and `MutationTransaction` from `riverpod/experimental/mutation.dart`. This aligns with Riverpod 3.0.3's experimental mutation API.

### Features

- **New FormWidget annotation** - Introducing the `@FormWidget` annotation for simplified form state management
- **Enhanced form validation** - Built-in form validation support with automatic error handling
- **onStatusChanged callback** - Forms now support an `onStatusChanged` callback to react to form status changes

### Migration Guide

#### From StateWidget to FormWidget

**Before (v0.0.5):**
```dart
@StateWidget()
class CounterForm {
  final int count;
  
  const CounterForm({required this.count});
}
```

**After (v0.0.6):**
```dart
@FormWidget()
class CounterForm {
  final int count;
  
  const CounterForm({required this.count});
}
```

#### From StateProvider to Mutation API

**Before (v0.0.5):**
```dart
import 'package:autoverpod/autoverpod.dart';
// Used StateProvider internally
```

**After (v0.0.6):**
```dart
import 'package:autoverpod/autoverpod.dart';
// Now exports Mutation and MutationTransaction from riverpod/experimental/mutation.dart
```

The generated providers are now more powerful and include:
- Form state provider (`counterFormProvider`)
- Form mutation provider (`counterFormMutationProvider`) 
- Call status provider (`counterFormCallStatusProvider`)

### Upgrade Steps

1. Update dependencies in `pubspec.yaml`:
   ```yaml
   dependencies:
     autoverpod: ^0.0.6
     autoverpod_generator: ^0.0.6
     riverpod: ^3.0.3
   ```

2. Replace `@StateWidget()` with `@FormWidget()` in your code

3. Regenerate code:
   ```bash
   dart run build_runner build --delete-conflicting-outputs
   ```

4. Update your provider usage to use the new generated providers (form state, mutation, and call status providers)

### Requirements

- **Dart SDK**: ^3.9.2
- **Riverpod**: ^3.0.3
- **Flutter**: SDK requirement automatically handled by workspace

## 0.0.5

- Version bump for release
- Improved stability and bug fixes

## 0.0.4+1

 - **REFACTOR**: improve form widget generation and debug handling. ([68f4f173](https://github.com/pckimlong/kimapp/commit/68f4f173c56e42fbd96d596bef6601a0af354035))

## 0.0.4

- Fix bugs

## 0.0.3

- Added annotations for form and state widgets
- Improved documentation

## 0.0.2

- Package structure improvements

## 0.0.1

- Initial version with basic annotations.
