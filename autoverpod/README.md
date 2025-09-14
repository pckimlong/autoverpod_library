<!-- 
This README describes the package. If you publish this package to pub.dev,
this README's contents appear on the landing page for your package.

For information about how to write a good package README, see the guide for
[writing package pages](https://dart.dev/tools/pub/writing-package-pages). 

For general information about developing packages, see the Dart guide for
[creating packages](https://dart.dev/guides/libraries/create-packages)
and the Flutter guide for
[developing packages and plugins](https://flutter.dev/to/develop-packages). 
-->

# Autoverpod

A package providing annotations for creating Riverpod-powered widgets with automated code generation.

## Features

- Simplifies the creation of Riverpod widgets through code generation
- Provides type-safe annotations that integrate with Riverpod's ecosystem
- Supports form widgets via the `@formWidget` annotation for both create and update forms
- Supports state management widgets via the `@stateWidget` annotation
- Reduces boilerplate code and enforces best practices

## Installation

To use autoverpod in your project, you need both the annotation package and the generator:

```yaml
dependencies:
  autoverpod: ^0.0.3
  # riverpod generation dependancies

dev_dependencies:
  autoverpod_generator: ^0.0.1
  build_runner: ^2.4.0  # Required for code generation
```

## Configuration

To prevent lint errors related to Riverpod's `notifier_extends` rule, add the following to your `analysis_options.yaml` file:

```yaml
analyzer:
  plugins:
    - custom_lint
  errors:
    invalid_annotation_target: ignore

custom_lint:
  rules:
    - notifier_extends: false  # Allows providers to extend custom classes instead of generated ones
```

This configuration disables the lint rule that requires providers to extend the generated Riverpod provider classes, which is necessary when using Autoverpod's custom widget extensions.

## Usage

Autoverpod works together with Riverpod annotations. You must apply both a Riverpod annotation 
(like `@riverpod`) and an autoverpod annotation (like `@formWidget` or `@stateWidget`) 
to the same class or function.

### Form Widget Example

The `@formWidget` annotation is used to create form widgets with built-in state management:

```dart
import 'dart:typed_data';

import 'package:autoverpod/autoverpod.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'example.freezed.dart';
part 'example.g.dart';

// Define your form model (using Freezed is recommended)
@freezed
class UpdateUserModel with _$UpdateUserModel {
  const UpdateUserModel._();

  const factory UpdateUserModel({
    @Default('') String name,
    int? age,
    String? email,
  }) = _UpdateUserModel;

  factory UpdateUserModel.fromJson(Map<String, dynamic> json) => 
      _$UpdateUserModelFromJson(json);
}

// Create your form widget with @formWidget and @riverpod annotations
@formWidget
@riverpod
class UpdateUser extends _$UpdateUserWidget {
  @override
  Future<UpdateUserModel> build(int id) async {
    // For editing existing users: fetch and return initial form data
    // For new users: return empty model
    return const UpdateUserModel(
      name: 'John Doe',
      age: 30,
    );
  }

  @override
  Future<bool> submit(
    UpdateUserModel state, {
    Uint8List? photoBytes,
  }) async {
    // Validate and submit form data
    if (state.name.isEmpty) throw 'Name is required';
    
    // Call your repository/API
    return await ref.read(userRepositoryProvider).updateUser(id, state);
  }

  @override
  void onSuccess(bool result) {
    // Handle successful submission
    invalidateSelf();
  }
}

// Usage in UI
void main() {
  runApp(
    ProviderScope(
      child: MaterialApp(
        home: Scaffold(
          body: UpdateUserFormScope(
            id: 1,
            builder: (context, ref, _) {
              return Column(
                children: [
                  // Field widgets are auto-generated
                  UpdateUserNameField(builder: (context, ref) {
                    return TextFormField(controller: ref.textController);
                  }),
                  
                  UpdateUserAgeField(builder: (context, ref) {
                    return TextFormField(
                      onChanged: (value) {
                        ref.updateAge(int.tryParse(value));
                      },
                    );
                  }),
                  
                  // Form submission status and button
                  UpdateUserFormStatus(
                    builder: (context, ref, status) {
                      return TextButton(
                        onPressed: () async {
                          final result = await ref.submit();
                          // Handle result
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
```

### State Widget Examples

The `@stateWidget` annotation is used to create widgets that consume Riverpod state:

```dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:autoverpod/autoverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'example.g.dart';

// Class-based provider with parameters
@stateWidget
@riverpod
class ProductDetail extends _$ProductDetail {
  @override
  FutureOr<String> build(int productId) {
    return 'Product Detail $productId';
  }
}

// Function-based provider
@riverpod
@stateWidget
int counter(Ref ref) {
  return 1;
}

// Class-based provider with multiple parameters
@riverpod
@stateWidget
class StringFuture extends _$StringFuture {
  @override
  Future<String> build({
    required String family,
    required String second,
  }) async {
    return 'string';
  }
}

// Provider with optional parameters
@riverpod
@stateWidget
class StringFutureOptional extends _$StringFutureOptional {
  @override
  Future<String> build(
    int a, {
    required String family,
    String? second,
  }) async {
    return 'string';
  }
}

// Async provider with Stream
@riverpod
@stateWidget
Stream<int> counterStream(Ref ref, {required int initialValue}) async* {
  yield initialValue;
}
```

## Code Generation

After annotating your classes or functions, run the generator:

```bash
flutter pub run build_runner build
```

The generator will create:
- Provider implementations
- Widget components for form fields
- Helper methods for state management
- Type-safe interfaces for your widgets

## Error Handling

Autoverpod enforces that widget annotations must be used together with Riverpod annotations. If you use an autoverpod annotation without a corresponding Riverpod annotation, you'll receive a compile-time error.

## Additional Information

This package is designed to work seamlessly with the Riverpod ecosystem. It's part of the kimapp project, which aims to simplify Flutter development with Riverpod.

## License

This package is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.
