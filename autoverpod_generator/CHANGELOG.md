## 0.0.6 - 2025-12-05

### BREAKING CHANGES

- **Removed StateWidget generators** - The StateWidget generators have been completely removed. Use the new FormWidget generators instead.
- **Generator architecture refactoring** - Significant internal refactoring of the generator system for better performance and maintainability.

### Features

- **New FormWidget generators** - Complete rewrite of form widget generation with enhanced capabilities:
  - `FormWidgetGenerator` for main form widget generation
  - `FormProviderGenerator` for automatic provider generation
  - Enhanced form validation and error handling
  - Automatic mutation provider generation for submit operations
- **Improved example applications** - New comprehensive examples showcasing:
  - Counter example with mutation support
  - Simple user form with validation
  - Simple product form with validation
  - Automated test verification suite

### Improvements

- **Better generated file handling** - Improved filtering of generated files (.g.dart, .freezed.dart, .widget.dart) to prevent circular dependencies
- **Enhanced import resolution** - Better handling of imports with improved dependency management
- **Updated dependencies** - All dependencies updated to latest versions:
  - Riverpod 3.0.3 with experimental mutation support
  - Analyzer ^7.4.0
  - Build tools updated
- **Performance optimizations** - Improved generator performance with better caching and reduced redundant processing
- **Enhanced error handling** - Better error messages and debugging information during code generation
- **Code cleanup** - Removed deprecated workflow files and unused generators

### Upgrade Steps

1. Update dependencies in `pubspec.yaml`:
   ```yaml
   dependencies:
     autoverpod: ^0.0.6
     autoverpod_generator: ^0.0.6
     riverpod: ^3.0.3
   dev_dependencies:
     build_runner: ^4.0.2
   ```

2. Replace `@StateWidget()` with `@FormWidget()` in your code

3. Regenerate code (required due to generator architecture changes):
   ```bash
   dart run build_runner build --delete-conflicting-outputs
   ```

4. Update your provider usage to use the new generated providers

### Requirements

- **Dart SDK**: ^3.9.2
- **Flutter**: SDK requirement automatically handled by workspace
- **autoverpod**: ^0.0.6
- **build_runner**: ^4.0.2

## 0.0.5

- Version bump for release
- Updated autoverpod dependency to 0.0.5
- Improved stability and bug fixes

## 0.0.4+1

 - **REFACTOR**: improve form widget generation and debug handling. ([68f4f173](https://github.com/pckimlong/kimapp/commit/68f4f173c56e42fbd96d596bef6601a0af354035))
 - **FIX**: prepare autoverpod_generator 0.0.3 for publishing. ([9083e34a](https://github.com/pckimlong/kimapp/commit/9083e34a7d0ad5a3c2a323dc18fa7992e4240969))
 - **FIX**: Add support for custom field type imports in form widget generator. ([d3366d55](https://github.com/pckimlong/kimapp/commit/d3366d559f0c53437f06585148e10b1baf42232f))

## 0.0.1

- Initial release of autoverpod_generator
- Support for generating Riverpod-integrated widgets from annotations
- Includes generators for state widgets, form widgets, and form update widgets
- Compatible with autoverpod ^0.0.3

## 0.0.2

- Fix generation issue on FormWidget

## 0.0.3

- Fix missing imports for custom field types in generated form widgets
- Add support for proper import path resolution in generated code
- Improve import handling in UnifiedWidgetBuilder

## 0.0.4

- Fix bugs
