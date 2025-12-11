// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_profile.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(UserProfile)
@stateWidget
const userProfileProvider = UserProfileFamily._();

@stateWidget
final class UserProfileProvider
    extends $NotifierProvider<UserProfile, UserProfileState> {
  const UserProfileProvider._(
      {required UserProfileFamily super.from, required int super.argument})
      : super(
          retry: null,
          name: r'userProfileProvider',
          isAutoDispose: true,
          dependencies: null,
          $allTransitiveDependencies: null,
        );

  @override
  String debugGetCreateSourceHash() => _$userProfileHash();

  @override
  String toString() {
    return r'userProfileProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  UserProfile create() => UserProfile();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(UserProfileState value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<UserProfileState>(value),
    );
  }

  @override
  bool operator ==(Object other) {
    return other is UserProfileProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$userProfileHash() => r'e851175700d2f25bc8861453a5a98b9375d1f8db';

@stateWidget
final class UserProfileFamily extends $Family
    with
        $ClassFamilyOverride<UserProfile, UserProfileState, UserProfileState,
            UserProfileState, int> {
  const UserProfileFamily._()
      : super(
          retry: null,
          name: r'userProfileProvider',
          dependencies: null,
          $allTransitiveDependencies: null,
          isAutoDispose: true,
        );

  @stateWidget
  UserProfileProvider call(
    int id,
  ) =>
      UserProfileProvider._(argument: id, from: this);

  @override
  String toString() => r'userProfileProvider';
}

@stateWidget
abstract class _$UserProfile extends $Notifier<UserProfileState> {
  late final _$args = ref.$arg as int;
  int get id => _$args;

  UserProfileState build(
    int id,
  );
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build(
      _$args,
    );
    final ref = this.ref as $Ref<UserProfileState, UserProfileState>;
    final element = ref.element as $ClassProviderElement<
        AnyNotifier<UserProfileState, UserProfileState>,
        UserProfileState,
        Object?,
        Object?>;
    element.handleValue(ref, created);
  }
}

@ProviderFor(SecondUserProfile)
@stateWidget
const secondUserProfileProvider = SecondUserProfileFamily._();

@stateWidget
final class SecondUserProfileProvider
    extends $NotifierProvider<SecondUserProfile, UserProfileState> {
  const SecondUserProfileProvider._(
      {required SecondUserProfileFamily super.from,
      required int super.argument})
      : super(
          retry: null,
          name: r'secondUserProfileProvider',
          isAutoDispose: true,
          dependencies: null,
          $allTransitiveDependencies: null,
        );

  @override
  String debugGetCreateSourceHash() => _$secondUserProfileHash();

  @override
  String toString() {
    return r'secondUserProfileProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  SecondUserProfile create() => SecondUserProfile();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(UserProfileState value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<UserProfileState>(value),
    );
  }

  @override
  bool operator ==(Object other) {
    return other is SecondUserProfileProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$secondUserProfileHash() => r'00b4a590abdb59212ed4f509e5400868a77b9def';

@stateWidget
final class SecondUserProfileFamily extends $Family
    with
        $ClassFamilyOverride<SecondUserProfile, UserProfileState,
            UserProfileState, UserProfileState, int> {
  const SecondUserProfileFamily._()
      : super(
          retry: null,
          name: r'secondUserProfileProvider',
          dependencies: null,
          $allTransitiveDependencies: null,
          isAutoDispose: true,
        );

  @stateWidget
  SecondUserProfileProvider call(
    int id,
  ) =>
      SecondUserProfileProvider._(argument: id, from: this);

  @override
  String toString() => r'secondUserProfileProvider';
}

@stateWidget
abstract class _$SecondUserProfile extends $Notifier<UserProfileState> {
  late final _$args = ref.$arg as int;
  int get id => _$args;

  UserProfileState build(
    int id,
  );
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build(
      _$args,
    );
    final ref = this.ref as $Ref<UserProfileState, UserProfileState>;
    final element = ref.element as $ClassProviderElement<
        AnyNotifier<UserProfileState, UserProfileState>,
        UserProfileState,
        Object?,
        Object?>;
    element.handleValue(ref, created);
  }
}
