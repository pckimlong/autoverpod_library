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

# AutoVerpod Generator

A code generator for the [autoverpod](https://pub.dev/packages/autoverpod) package that automatically generates Riverpod-integrated widgets based on annotations.

## Features

- Generates stateless widgets with Riverpod integration from `@stateWidget` annotations
- Generates form widgets with Riverpod integration from `@formWidget` annotations
- Generates form update widgets with Riverpod integration from `@formUpdateWidget` annotations
- Provides an extensible architecture for adding custom generators

## Installation

Add the following to your `pubspec.yaml`:

```yaml
dependencies:
  autoverpod: ^0.0.3
  hooks_riverpod: <latest-version> # state management
  flutter_hooks: <latest-version> # required for handle generated form field

dev_dependencies:
  autoverpod_generator: ^0.0.1
  build_runner: ^2.4.0
```

## Usage

The autoverpod_generator works in conjunction with the autoverpod package to generate Riverpod-integrated widgets from annotated classes. It processes annotations like `@stateWidget`, `@formWidget`, and `@formUpdateWidget` to create the necessary boilerplate code for your Flutter application.

After adding the appropriate annotations to your classes, run the build_runner to generate the widgets:

```bash
flutter pub run build_runner build
```

## Additional Information

For more detailed information about how to use the generated widgets and the full capabilities of the autoverpod ecosystem, please refer to the [autoverpod package documentation](https://pub.dev/packages/autoverpod).

## License

This project is licensed under the MIT License - see the LICENSE file for details.
