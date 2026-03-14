## 0.1.8 - 2026-03-15

### Bug Fixes

- **Freezed field parsing** - Restrict generated field updaters to the primary Freezed state fields so helper APIs such as `initial(...)` and `fromDetail(...)` do not leak extra update methods like `updateNow` or `updateSale`.

---

## 0.1.7 - 2026-03-04

### Bug Fixes

- **Propagate async skip config through scope** - Generated scope inherited data now carries `skipLoadingOnRefresh`, `skipLoadingOnReload`, and `skipError`, allowing generated async select/field widgets to reuse scope-level skip behavior automatically.

---

## 0.1.6 - 2026-03-04

### Improvements

- **Async scope skip flags** - Generated `*Scope` widgets for async providers now expose `skipLoadingOnRefresh`, `skipLoadingOnReload`, and `skipError` and pass them through to `AsyncValue.when(...)`.
- **Better scope constructor ergonomics** - Generated async `*Scope` constructors no longer require nullable `loading`/`error` arguments; they remain validated by assertion when no custom `builder` is provided.

---

## 0.1.5 - 2026-02-26

### Improvements

- **Expose raw `WidgetRef` in proxy refs** - Generated `*ProxyWidgetRef` classes now include `widgetRef`, enabling direct `WidgetRef` access for extension methods and advanced Riverpod APIs when needed.

---

## 0.1.4 - 2026-02-22

### Bug Fixes

- **Import resolution with prefixes/combinators** - Prevent skipped type imports when source imports use `as`, `show`, or `hide`, avoiding generated `.widget.dart` compile failures for unqualified type references.
- **Stale type-index cache in watch builds** - Clear type import caches on each generation run so moved/renamed/new files are resolved correctly without restarting the build process.

### Improvements

- **Safer type extraction** - Centralize guarded type/import access via `TypeUtils` so generator model parsing tolerates analyzer edge cases and falls back gracefully.

---

## 0.1.2 - 2025-12-13

### Improvements

- **Generated header fields** - Include `ref.textController` for number fields in generated header field summaries.
- **Field widget support** - Update generation to better support numeric field widgets backed by `NumberField`.

---

## 0.1.1 - 2025-12-12

### New Features

- **ParamsBuilder widget** - New widget for family providers that exposes family parameters in a builder callback with full `select`/`notifier` access via `ProxyWidgetRef`
- **Usage examples in doc comments** - All generated widgets now include `/// **Usage:**` code examples for better AI/IDE assistance

### Bug Fixes

- **Fixed `valueOrNull` compile error** - Changed to `value` for riverpod 3.x compatibility
- **Fixed `getters` compile error** - Use `accessors.any((a) => a.isGetter)` for lean_builder compatibility
- **Fixed duplicate header comments** - Removed duplicate header since lean_builder adds its own
- **Fixed `file://` URI imports** - Use `shortUri` instead of `uri` to get proper `package://` imports

### Improvements

- **Single param optimization** - Family providers with single parameter now use simple type (`int`) instead of record (`({int id})`) for cleaner generated code
- **Cleaner generated output** - Reduced boilerplate in generated widgets

---

## 0.1.0 - 2025-12-11

### ⚠️ COMPLETE REWRITE - BREAKING CHANGES

This release completely replaces the previous form-focused generator
architecture. It is **not** backwards compatible with the 0.0.x series.

- All `@FormWidget` / form update generators have been removed
- The generator now targets the `@stateWidget` annotation only
- Generator implementation migrated from `build_runner` to `lean_builder`
- Significantly reduced generator surface area and complexity

### New Features

- `StateWidgetGenerator` for generating:
  - Field updater extension methods on the provider notifier
  - Scope widget (InheritedWidget) for family parameters
  - State widget (`*Widget`) that rebuilds on any state change
  - Select widget (`*Select`) that rebuilds on selected value changes
  - Field widgets with auto `TextEditingController` sync for `String` fields
- Improved import handling for:
  - Source libraries
  - Field types
  - Family parameter types
- Always generates a scope widget, even for non-family providers, to keep
  future changes (e.g. adding parameters) migration-friendly

### Migration Notes

- Replace previous form-based annotations and generators with `@stateWidget`
- Switch code generation from `build_runner` to `lean_builder`:
  ```bash
  dart run lean_builder
  ```
- Update dependencies in your consuming package:
  ```yaml
  dev_dependencies:
    autoverpod_generator: ^0.1.0
    lean_builder: ^0.1.2
  ```

### Requirements

- **Dart SDK**: `^3.6.0`
- **autoverpod**: `^0.1.0`
- **autoverpod_annotation**: `^0.1.0`

---

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
