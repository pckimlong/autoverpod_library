# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Project Overview

AutoVerpod Generator is a Dart code generator package that creates Riverpod-integrated widgets from annotations. It processes `@stateWidget`, `@formWidget`, and `@formUpdateWidget` annotations to generate boilerplate Flutter widgets with state management.

## Common Development Commands

### Build and Code Generation
```bash
# Run code generation for the package itself
dart pub get && dart pub run build_runner build

# Clean and rebuild
dart pub run build_runner clean && dart pub run build_runner build

# Watch mode for continuous generation
dart pub run build_runner watch
```

### Testing and Quality
```bash
# Run linting (uses package:lints/recommended.yaml)
dart analyze

# Format code
dart format .

# Pub publish dry run (for release preparation)
dart pub publish --dry-run
```

### Example Development
```bash
# Work with example project
cd example
dart pub get
dart pub run build_runner build
```

## Architecture

### Core Components

- **Generator Registry**: (`lib/src/core/generator_registry.dart`) - Singleton registry that manages all widget generators and coordinates code generation
- **Base Generator**: (`lib/src/core/base_generator.dart`) - Abstract base class for all generators
- **Unified Widget Builder**: (`lib/src/core/unified_widget_builder.dart`) - Main build entry point that orchestrates generation

### Generator Types

1. **StateWidgetGenerator**: Creates stateless widgets with Riverpod integration from `@stateWidget` annotations
2. **FormWidgetGenerator**: Generates form widgets with Riverpod integration from `@formWidget` annotations  
3. **FormProviderGenerator**: Creates provider extensions for form handling

### Build Configuration

- **build.yaml**: Defines two builders:
  - `autoverpod_generator`: Generates `.widget.dart` files for main widgets
  - `form_provider_generator`: Generates `.form.g.part` files for form providers
- Both builders require `.freezed.dart` files as input dependencies

### Generated File Structure

- Main widgets: `*.widget.dart` (source generation)
- Form providers: `*.form.g.part` (cached generation)
- Depends on freezed-generated classes for data models

### Key Dependencies

- `source_gen` and `build` for code generation infrastructure
- `analyzer` for AST parsing and element analysis
- `autoverpod` package for annotation definitions
- `riverpod` ecosystem for state management integration
- `code_builder` and `dart_style` for code generation and formatting

## Important Notes

- Generated files (`.widget.dart`, `.g.dart`, `.freezed.dart`) should not be manually edited
- The package uses a workspace resolution strategy (`resolution: workspace`)
- Linting includes additional rules: `require_trailing_commas`, `prefer_final_fields`, `prefer_final_in_for_each`, `prefer_final_locals`
- The generator expects freezed classes as input and generates widgets that integrate with Riverpod providers