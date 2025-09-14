# Autoverpod Example

This is a simple example demonstrating how to use the `autoverpod` package.

## Usage

The example shows how to use the annotations provided by the package:

```dart
import 'package:autoverpod/autoverpod.dart';

// Using the form widget annotation
@formWidget
class UserForm {
  // Implementation
}

// Using the state widget annotation
@stateWidget
class UserProfile {
  // Implementation
}
```

In a real application, these annotations would be processed by a code generator to create the necessary boilerplate code for Riverpod widgets. 