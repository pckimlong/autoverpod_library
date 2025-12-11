# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## 0.1.0 - 2025-12-11

### Initial release

- First standalone release of `autoverpod_annotation`
- Provides the `StateWidget` / `stateWidget` annotation used by
  `autoverpod` and `autoverpod_generator`
- Targets class-based Riverpod providers annotated with `@riverpod`
- Designed to generate:
  - Field updater extension methods
  - Scope widgets for family parameters
  - State and select widgets for reactive UI
  - Field widgets with auto `TextEditingController` sync for `String` fields

