import 'package:autoverpod/autoverpod.dart';
import 'package:autoverpod_example/user_profile.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'function_provider.g.dart';

@riverpod
@stateWidget
UserProfileState text(Ref ref) {
  return const UserProfileState();
}
