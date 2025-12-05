# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## 0.0.6 - 2025-12-05

### BREAKING CHANGES

- **Removed StateWidget annotation** - The StateWidget annotation and related generators have been removed. Use the new FormWidget annotation instead for form state management.
- **Updated Riverpod exports** - Replaced `StateProvider` export with `Mutation` and `MutationTransaction` from `riverpod/experimental/mutation.dart`. This aligns with Riverpod 3.0.3's experimental mutation API.
- **Generator architecture refactoring** - Internal generator architecture has been significantly refactored for better maintainability and performance.

### Features

- **New FormWidget annotation** - Introducing the `@FormWidget` annotation for simplified form state management with automatic provider generation
- **Enhanced form validation** - Built-in form validation with automatic error handling and state management
- **onStatusChanged callback** - Forms now support an `onStatusChanged` callback to react to form status changes (loading, success, error)
- **Automatic form providers** - Generated form providers include:
  - Form state provider
  - Form mutation provider for submit operations
  - Call status provider for tracking submission state
- **Improved example applications** - Complete rewrite of example apps showcasing the new FormWidget system with:
  - Counter example with mutation support
  - Simple user form with validation
  - Simple product form with validation
  - Comprehensive test verification suite

### Improvements

- **Updated dependencies** - All dependencies updated to latest stable versions:
  - Riverpod 3.0.3
  - Flutter SDK requirements updated
  - Build and analyzer packages updated
- **Better code generation** - Improved generator performance with better handling of:
  - Generated file exclusion (.g.dart, .freezed.dart, .widget.dart)
  - Import resolution and dependency management
  - Error handling and validation
- **Enhanced debugging** - Better error messages and debugging information during code generation
- **Code cleanup** - Removed deprecated workflow files and cleaned up unused code
- **Improved linting** - Added lint ignore directives and improved code formatting

### Examples

- **Complete form examples** - New comprehensive examples showing:
  - Form creation with `@FormWidget`
  - Field validation and error handling
  - Submit operations with loading states
  - Status callbacks and reactive UI updates
- **Test verification** - Added automated test verification suite to ensure generated code works correctly

## 0.0.5 - Previous Version

- Initial release with basic StateWidget functionality
- Basic provider generation for state management
