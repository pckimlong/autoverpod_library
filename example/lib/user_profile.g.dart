// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_profile.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(AsyncUserProfile)
@stateWidget
final asyncUserProfileProvider = AsyncUserProfileFamily._();

@stateWidget
final class AsyncUserProfileProvider
    extends $AsyncNotifierProvider<AsyncUserProfile, UserProfileState> {
  AsyncUserProfileProvider._(
      {required AsyncUserProfileFamily super.from, required int super.argument})
      : super(
          retry: null,
          name: r'asyncUserProfileProvider',
          isAutoDispose: true,
          dependencies: null,
          $allTransitiveDependencies: null,
        );

  @override
  String debugGetCreateSourceHash() => _$asyncUserProfileHash();

  @override
  String toString() {
    return r'asyncUserProfileProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  AsyncUserProfile create() => AsyncUserProfile();

  @override
  bool operator ==(Object other) {
    return other is AsyncUserProfileProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$asyncUserProfileHash() => r'20a71b236dd3809644b472794a6c621ecf8534a7';

@stateWidget
final class AsyncUserProfileFamily extends $Family
    with
        $ClassFamilyOverride<AsyncUserProfile, AsyncValue<UserProfileState>,
            UserProfileState, FutureOr<UserProfileState>, int> {
  AsyncUserProfileFamily._()
      : super(
          retry: null,
          name: r'asyncUserProfileProvider',
          dependencies: null,
          $allTransitiveDependencies: null,
          isAutoDispose: true,
        );

  @stateWidget
  AsyncUserProfileProvider call(
    int id,
  ) =>
      AsyncUserProfileProvider._(argument: id, from: this);

  @override
  String toString() => r'asyncUserProfileProvider';
}

@stateWidget
abstract class _$AsyncUserProfile extends $AsyncNotifier<UserProfileState> {
  late final _$args = ref.$arg as int;
  int get id => _$args;

  FutureOr<UserProfileState> build(
    int id,
  );
  @$mustCallSuper
  @override
  void runBuild() {
    final ref =
        this.ref as $Ref<AsyncValue<UserProfileState>, UserProfileState>;
    final element = ref.element as $ClassProviderElement<
        AnyNotifier<AsyncValue<UserProfileState>, UserProfileState>,
        AsyncValue<UserProfileState>,
        Object?,
        Object?>;
    element.handleCreate(
        ref,
        () => build(
              _$args,
            ));
  }
}

@ProviderFor(UserProfile)
@stateWidget
final userProfileProvider = UserProfileFamily._();

@stateWidget
final class UserProfileProvider
    extends $NotifierProvider<UserProfile, UserProfileState> {
  UserProfileProvider._(
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
  UserProfileFamily._()
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
    final ref = this.ref as $Ref<UserProfileState, UserProfileState>;
    final element = ref.element as $ClassProviderElement<
        AnyNotifier<UserProfileState, UserProfileState>,
        UserProfileState,
        Object?,
        Object?>;
    element.handleCreate(
        ref,
        () => build(
              _$args,
            ));
  }
}

@ProviderFor(SecondUserProfile)
@stateWidget
final secondUserProfileProvider = SecondUserProfileProvider._();

@stateWidget
final class SecondUserProfileProvider
    extends $NotifierProvider<SecondUserProfile, UserProfileState> {
  SecondUserProfileProvider._()
      : super(
          from: null,
          argument: null,
          retry: null,
          name: r'secondUserProfileProvider',
          isAutoDispose: true,
          dependencies: null,
          $allTransitiveDependencies: null,
        );

  @override
  String debugGetCreateSourceHash() => _$secondUserProfileHash();

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
}

String _$secondUserProfileHash() => r'c3bd596c11653833ceb0b2d60bf09937f214ea00';

@stateWidget
abstract class _$SecondUserProfile extends $Notifier<UserProfileState> {
  UserProfileState build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref as $Ref<UserProfileState, UserProfileState>;
    final element = ref.element as $ClassProviderElement<
        AnyNotifier<UserProfileState, UserProfileState>,
        UserProfileState,
        Object?,
        Object?>;
    element.handleCreate(ref, build);
  }
}
