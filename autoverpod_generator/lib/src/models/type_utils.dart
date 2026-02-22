/// Shared utilities for type resolution across model classes.
class TypeUtils {
  /// Safely resolves the import path for a type, returning null for dart: types.
  static String? resolveImportPath(dynamic type) {
    try {
      if (type == null) return null;
      final element = type.element;
      if (element == null) return null;
      final uri = element.librarySrc.shortUri.toString();
      return uri.startsWith('dart:') ? null : uri;
    } catch (_) {
      return null;
    }
  }

  /// Safely reads a type, returning null if an exception occurs.
  static dynamic safeReadType(dynamic Function() readType) {
    try {
      return readType();
    } catch (_) {
      return null;
    }
  }
}
