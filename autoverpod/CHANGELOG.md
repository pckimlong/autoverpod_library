## 0.1.0 - 2025-12-11

### ⚠️ COMPLETE REWRITE - BREAKING CHANGES

This version is a **complete rewrite** of the autoverpod package. The previous
form-focused architecture has been replaced with a simpler, more maintainable
state widget approach.

#### Migration Notes

- **All previous APIs have been removed** – this is not backwards compatible
- **`@FormWidget` and form update APIs have been removed**
- **New `@stateWidget` annotation** (exported from `autoverpod_annotation`)
- **Form submission handling removed** – submission logic is now user-controlled
- **Generator moved to `lean_builder`** – use `autoverpod_generator` ^0.1.0 and
  run `dart run lean_builder` instead of `build_runner`

#### Why This Change?

The previous version tried to be "too magic" with automatic form handling,
mutations, and complex provider generation. This led to:
- High maintenance burden with many generator files
- Difficult-to-debug generated code
- Tight coupling to specific patterns

The new version is:
- **Simpler** – focused on generating state field widgets
- **More flexible** – you own submission and side-effect logic
- **Easier to maintain** – uses `lean_builder` for cleaner code generation
- **Future-proof** – generates scope widgets even for non-family providers

### New Features

For a provider annotated with `@stateWidget` and `@riverpod`, autoverpod now
provides:

- Field updater extension methods on the provider notifier
- Scope widget (InheritedWidget) for family parameters
- State widget (`*Widget`) that rebuilds on any state change
- Select widget (`*Select`) that rebuilds only on selected value changes
- Individual field widgets with auto `TextEditingController` sync (for
  `String` fields)

### Dependencies

- Uses `lean_builder` instead of `build_runner` via `autoverpod_generator`
- Requires `flutter_riverpod: >=3.0.0 <4.0.0`
- Dart SDK: `^3.6.0`

---

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
