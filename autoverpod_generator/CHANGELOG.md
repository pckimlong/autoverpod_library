## 0.0.7

- Update repository links to `pckimlong/autoverpod_library`
- Update dependency to `autoverpod ^0.0.6`
- Prepare for automated publishing via GitHub Actions (OIDC)

## 0.0.6

- **FIX**: Stabilize import generation to prevent random git commits
  - Remove self-imports that caused generated files to import themselves
  - Filter out unnecessary dart:core imports while preserving required ones like dart:typed_data
  - Add deterministic import sorting for consistent output
  - Improve source import filtering to avoid generator package imports
  - This eliminates random import changes that caused unnecessary git commits on every build_runner execution

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
