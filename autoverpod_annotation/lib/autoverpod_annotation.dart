import 'package:meta/meta.dart';
import 'package:meta/meta_meta.dart';

/// Annotation to generate state field widgets from Riverpod providers.
///
/// Apply this annotation along with `@riverpod` to a class-based provider
/// to generate:
/// - Field widgets with auto text controller sync (for String fields)
/// - Field update extension methods
/// - Optional scope widget for family parameters
/// - State/Select widgets for reactive UI
///
/// Example:
/// ```dart
/// @stateWidget
/// @riverpod
/// class UserProfile extends _$UserProfile {
///   @override
///   UserProfileState build(int userId) => UserProfileState();
/// }
/// ```
@Target({TargetKind.classType})
@sealed
class StateWidget {
  const StateWidget();
}

/// Convenience constant for the StateWidget annotation.
const stateWidget = StateWidget();
