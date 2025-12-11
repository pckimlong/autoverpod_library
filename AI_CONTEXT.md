# Autoverpod - AI Context Guide

Code generation for Riverpod-powered state field widgets. Generates field widgets with auto TextEditingController sync, update extensions, and scope widgets from annotated providers.

---

## Core Pattern

```dart
import 'package:autoverpod/autoverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'user_profile.freezed.dart';
part 'user_profile.g.dart';
part 'user_profile.widget.dart';

// State model - Freezed recommended for copyWith
@freezed
sealed class UserProfileState with _$UserProfileState {
  const factory UserProfileState({
    @Default('') String name,
    @Default('') String email,
    @Default(0) int age,
    String? bio,
  }) = _UserProfileState;
}

@stateWidget
@riverpod
class UserProfile extends _$UserProfile {
  @override
  UserProfileState build() => const UserProfileState();
}
```

---

## Generated Code

For `UserProfile` provider, generates:

| Widget | Purpose |
|--------|---------|
| `UserProfileScope` | InheritedWidget for family params |
| `UserProfileWidget` | Rebuilds on any state change |
| `UserProfileSelect<T>` | Rebuilds only on selected value |
| `UserProfile{FieldName}Field` | Per-field widget |

Plus extension methods:
- `userProfileProvider.notifier.updateName(value)`
- `userProfileProvider.notifier.updateEmail(value)`
- etc.

---

## Widget Usage

### State Widget - Full State Access

```dart
UserProfileWidget(
  builder: (context, ref, state) {
    return Column(
      children: [
        Text('Name: ${state.name}'),
        Text('Email: ${state.email}'),
      ],
    );
  },
)
```

### Select Widget - Optimized Rebuilds

```dart
UserProfileSelect<String>(
  selector: (state) => state.name,
  builder: (context, ref, name) {
    return Text('Name: $name');
  },
)
```

### Field Widgets - Auto Controller Sync (String fields)

```dart
UserProfileNameField(
  builder: (context, ref) => TextField(
    controller: ref.controller,  // Auto-synced with state
    decoration: InputDecoration(labelText: 'Name'),
  ),
)

// Manual update
ref.read(userProfileProvider.notifier).updateName('John');
```

### Non-String Field Widgets

```dart
UserProfileAgeField(
  builder: (context, ref) => Slider(
    value: ref.age.toDouble(),
    onChanged: (v) => ref.updateAge(v.toInt()),
  ),
)
```

---

## Family Provider Pattern

For providers with parameters:

```dart
@stateWidget
@riverpod
class UserProfile extends _$UserProfile {
  @override
  UserProfileState build(int userId) => const UserProfileState();
}
```

Use `Scope` to provide params to descendants:

```dart
UserProfileScope(
  userId: 123,
  child: Column(
    children: [
      // These inherit userId from scope
      UserProfileNameField(builder: ...),
      UserProfileEmailField(builder: ...),
    ],
  ),
)
```

Or pass directly:

```dart
UserProfileNameField(
  userId: 123,
  builder: (context, ref) => TextField(
    controller: ref.controller,
  ),
)
```

---

## ProxyWidgetRef API

Available in builder callbacks:

```dart
// In StateWidget/SelectWidget builders:
ref.notifier         // Provider notifier
ref.select(...)      // Type-safe state selector
ref.watch(...)       // Watch other providers
ref.read(...)        // Read other providers
ref.invalidate(...)  // Invalidate providers
ref.context          // BuildContext

// In String field builders (StringFieldRef):
ref.controller       // Auto-managed TextEditingController
ref.update           // Update function

// In other field builders:
ref.{fieldName}      // Direct field value
ref.update{FieldName}// Update method
```

---

## Key Points

1. **Use `@stateWidget` annotation** - Along with `@riverpod`
2. **Uses lean_builder** - Run `dart run lean_builder watch`
3. **Scope widget always generated** - For future-proofing
4. **String fields get auto controller** - Bidirectional sync with state
5. **User handles form submission** - No magic, more control

---

## Quick Template

```dart
@stateWidget
@riverpod
class MyForm extends _$MyForm {
  @override
  MyState build() => const MyState();
  
  // Add your own submit method
  Future<void> submit() async {
    final currentState = state;
    // Validate and submit...
  }
}
```

---

## Generator Command

```bash
# Watch mode
dart run lean_builder watch

# One-time build
dart run lean_builder
```
