// AUTOVERPOD EXAMPLE PROVIDERS
//
// - Source: userProfileProvider → UserProfileState
//   Widgets: UserProfileWidget, UserProfileSelect
//   Scope: UserProfileScope
//
// - Source: secondUserProfileProvider → UserProfileState
//   Widgets: SecondUserProfileWidget, SecondUserProfileSelect
//   Scope: SecondUserProfileScope

import 'package:autoverpod/autoverpod.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'user_profile.freezed.dart';
part 'user_profile.g.dart';

/// Example state class using Freezed
@freezed
sealed class UserProfileState with _$UserProfileState {
  const factory UserProfileState({
    @Default('') String name,
    @Default('') String email,
    @Default(0) int age,
    String? bio,
    String? bio2,
  }) = _UserProfileState;
}

@stateWidget
@riverpod
class AsyncUserProfile extends _$AsyncUserProfile {
  @override
  Future<UserProfileState> build(int id) async =>
      const UserProfileState(name: 'Second');
}

@stateWidget
@riverpod
class UserProfile extends _$UserProfile {
  @override
  UserProfileState build(int id) => const UserProfileState();
}

@stateWidget
@riverpod
class SecondUserProfile extends _$SecondUserProfile {
  @override
  UserProfileState build() => const UserProfileState(
        name: 'Second',
      );
}
