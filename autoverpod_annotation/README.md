# Autoverpod Annotation

`autoverpod_annotation` defines the `StateWidget` / `stateWidget` annotation used by the Autoverpod ecosystem.

The annotation is published separately so it can be shared between the `autoverpod` runtime package, the `autoverpod_generator` package, and any other tools that need to understand the annotation.

## Usage

In an application or feature package that uses Autoverpod:

```dart
import 'package:autoverpod/autoverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

@stateWidget
@riverpod
class UserProfile extends _$UserProfile {
  @override
  UserProfileState build(int id) => const UserProfileState();
}
```

The `autoverpod_generator` package reads this annotation to generate scope widgets, state/select widgets, field widgets, and field updater extensions. The `autoverpod` runtime package then provides the base types used by those generated widgets.

For more extensive examples and migration notes, see the `autoverpod` package documentation.
