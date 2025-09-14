import 'package:riverpod/riverpod.dart';

extension AsyncValueNullableExtension<T> on AsyncValue<T>? {
  /// In initial state, the value is null representing the initial state
  bool get isInitial => this == null;

  /// Indicates if the form is currently processing (submitting, saving, etc.)
  bool get isProcessing =>
      this != null &&
      (this!.isLoading || this!.isRefreshing || this!.isReloading);

  /// Alias for isProcessing to maintain backward compatibility
  bool get isLoading => isProcessing;

  /// Indicates if the form action was successful
  bool get isSuccess => this != null && this!.hasValue;

  /// Indicates if the form action resulted in an error
  bool get isError => this != null && this!.hasError;
}
