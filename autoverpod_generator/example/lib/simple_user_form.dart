import 'package:autoverpod/autoverpod.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'simple_user_form.freezed.dart';
part 'simple_user_form.g.dart';

@freezed
sealed class SimpleUserState with _$SimpleUserState {
  const SimpleUserState._();

  const factory SimpleUserState({
    @Default('') String firstName,
    @Default('') String lastName,
    @Default('') String email,
    @Default('') String phone,
    @Default('') String company,
    @Default('') String jobTitle,
    @Default(false) bool isActive,
    @Default(false) bool acceptsMarketing,
  }) = _SimpleUserState;
}

@formWidget
@riverpod
class SimpleUserForm extends _$SimpleUserFormWidget {
  @override
  SimpleUserState build() {
    return const SimpleUserState();
  }

  @override
  Future<int> submit(MutationTransaction tsx, SimpleUserState state) async {
    // Basic validation
    if (state.firstName.trim().isEmpty) {
      throw Exception('First name is required');
    }
    if (state.lastName.trim().isEmpty) {
      throw Exception('Last name is required');
    }
    if (state.email.trim().isEmpty) {
      throw Exception('Email is required');
    }

    // Simulate API call
    await Future.delayed(const Duration(milliseconds: 800));

    // Return user ID
    return DateTime.now().millisecondsSinceEpoch % 100000;
  }

  @override
  void onSuccess(int userId) {
    print('User created successfully with ID: $userId');
  }
}