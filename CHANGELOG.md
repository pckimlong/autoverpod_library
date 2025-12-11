# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## 0.1.0 - 2025-12-11

### ⚠️ COMPLETE REWRITE - BREAKING CHANGES

This version is a **complete rewrite** of the autoverpod package. The previous complex form-focused architecture has been replaced with a simpler, more maintainable state widget approach.

#### Migration Notes

- **All previous APIs have been removed** - This is not a backwards-compatible update
- **Generator changed from `build_runner` to `lean_builder`** - Run `dart run lean_builder` instead of `dart run build_runner`
- **Form submission handling removed** - Users now handle form submission logic themselves
- **Simpler annotation** - Use `@stateWidget` instead of `@FormWidget`

#### Why This Change?

The previous version tried to be "too magic" with automatic form handling, mutations, and complex provider generation. This led to:
- High maintenance burden (30+ generator files)
- Difficult to debug generated code
- Tight coupling to specific patterns

The new version is:
- **Simpler** - Only 5 generator files
- **More flexible** - Users control form submission
- **Easier to maintain** - Uses lean_builder for cleaner code generation
- **Future-proof** - Generates scope widgets even for non-family providers

### New Features

- **`@stateWidget` annotation** - Simple annotation for generating state field widgets
- **Auto text controller sync** - StringField helper handles TextEditingController synchronization
- **Scope widgets** - InheritedWidget-based scoping for family parameters
- **Field widgets** - Generated field widgets with update methods
- **Select widgets** - Optimized widgets that only rebuild on selected value changes

### What's Generated

For a provider annotated with `@stateWidget`:
- Field updater extension methods
- Scope widget (for family parameter passing)
- State widget (rebuilds on any state change)
- Select widget (rebuilds on selected value only)
- Individual field widgets with auto text controller sync (for String fields)

### Dependencies

- Uses `lean_builder` instead of `build_runner`
- Requires `flutter_riverpod: >=3.0.0 <4.0.0`
- Dart SDK: `^3.6.0`

---

## Previous Versions (Deprecated)

All versions before 0.1.0 used a different architecture and are no longer supported. Please migrate to 0.1.0.
