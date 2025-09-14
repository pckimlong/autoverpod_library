/// This example demonstrates how to create a form widget using the autoverpod_generator package.
/// The form widget pattern combines Riverpod state management with form handling capabilities.
library;

import 'dart:typed_data';

import 'package:autoverpod/autoverpod.dart';
import 'package:autoverpod_generator_example/form_widget_example.widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'form_widget_example.freezed.dart';
part 'form_widget_example.g.dart';

/// Model to update the user, can be used other class as well, but using freezed is recommended
/// since it immutability and has deep copyWith method, which essential for form state management
@freezed
sealed class UpdateUserModel with _$UpdateUserModel {
  const UpdateUserModel._();

  const factory UpdateUserModel({
    @Default('') String name,
    int? age,
    String? email,
    String? address,
    String? phone,
  }) = _UpdateUserModel;

  /// Converts JSON map to [UpdateUserModel] instance.
  /// Used for serialization/deserialization of form data.
  factory UpdateUserModel.fromJson(Map<String, dynamic> json) => _$UpdateUserModelFromJson(json);
}

@riverpod
UserRepository userRepository(Ref ref) => UserRepository();

class UserRepository {
  Future<bool> updateUser(int id, UpdateUserModel model) async {
    await Future.delayed(const Duration(seconds: 1));
    final json = model.toJson();
    debugPrint(json.toString());
    return true;
  }
}

/// Annotated with @formWidget and @riverpod
// @stateWidget
@formWidget
@riverpod
class UpdateUser extends _$UpdateUserWidget {
  @override
  Future<UpdateUserModel> build(int id) async {
    /// Initializes the form state with existing user data.
    ///
    /// For new user creation (where id isn't needed):
    /// create it as normal class
    /// ```dart
    /// return const UpdateUserModel();
    /// ```
    ///
    /// For editing existing users:
    /// - Fetch user data using [id]
    /// - Transform the data into [UpdateUserModel]
    /// - Handle loading and error states automatically
    return const UpdateUserModel(
      name: 'Kim Coding',
      age: 28,
    );
  }

  /// Internal submit implementation for form submission.
  ///
  /// ⚠️ WARNING: Do not call this method directly - use [call] instead.
  /// Direct usage bypasses:
  /// - Error handling
  /// - Loading state management
  /// - Success callback handling
  /// - Form validation
  ///
  /// This method should be overridden to implement the actual form submission logic:
  /// 1. Validate form data
  /// 2. Transform data if needed
  /// 3. Call API/repository methods
  /// 4. Return success/failure result
  @override
  Future<bool> submit(
    UpdateUserModel state, {
    Uint8List? photoBytes,
  }) async {
    if (state.name.isEmpty) throw 'Name is required';
    return await ref.read(userRepositoryProvider).updateUser(id, state);
  }

  /// Callback triggered after successful form submission.
  ///
  /// Use this method to:
  /// - Show success messages
  /// - Navigate to different screens
  /// - Update other providers
  /// - Perform any post-submission cleanup
  ///
  /// Must override this method and run "dart pub run build_runner build" to make it work. otherwise error will be thrown.
  @override
  void onSuccess(bool result) {
    /// Example:
    /// ```dart
    /// ref.read(userListProvider.notifier).refresh();
    /// ```
    /// Call this method to invalidate the form state and trigger a rebuild.
    /// Use this over ref.invalidateSelf()
    invalidateSelf();
  }
}

void main() {
  runApp(
    ProviderScope(
      child: MaterialApp(
        home: Scaffold(
          appBar: AppBar(title: const Text('Form Widget Example')),
          body: UpdateUserFormScope(
            id: 1,
            builder: (context, ref, _) {
              return Column(
                children: [
                  UpdateUserNameField(builder: (context, ref) {
                    return TextFormField(controller: ref.textController);
                  }),
                  const SizedBox(height: 16),
                  UpdateUserAgeField(builder: (context, ref) {
                    return TextFormField(
                      onChanged: (value) {
                        ref.updateAge(int.tryParse(value));
                      },
                    );
                  }),
                  const SizedBox(height: 16),
                  UpdateUserEmailField(builder: (context, ref) {
                    return TextFormField(controller: ref.textController);
                  }),
                  const SizedBox(height: 16),
                  UpdateUserAddressField(
                    builder: (context, ref) {
                      return TextFormField(controller: ref.textController);
                    },
                  ),
                  const SizedBox(height: 16),
                  UpdateUserPhoneField(builder: (context, ref) {
                    return TextFormField(controller: ref.textController);
                  }),
                  const SizedBox(height: 16),
                  UpdateUserFormStatus(
                    builder: (context, ref, status) {
                      return TextButton(
                        onPressed: () async {
                          final result = await ref.submit(photoBytes: null);
                          if (result.hasValue && context.mounted) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text('Saved'),
                              ),
                            );
                          }
                        },
                        child: Text(status!.isLoading ? 'Saving...' : 'Save'),
                      );
                    },
                  )
                ],
              );
            },
          ),
        ),
      ),
    ),
  );
}
