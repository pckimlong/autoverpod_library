import 'package:autoverpod/autoverpod.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'simple_product_form.freezed.dart';
part 'simple_product_form.g.dart';

@freezed
sealed class SimpleProductState with _$SimpleProductState {
  const SimpleProductState._();

  const factory SimpleProductState({
    @Default('') String name,
    @Default('') String description,
    @Default(0.0) double price,
    @Default('') String category,
    @Default('') String sku,
    @Default(0) int stockQuantity,
    @Default(false) bool isActive,
    @Default(false) bool isFeatured,
    @Default([]) List<String> tags,
  }) = _SimpleProductState;
}

@formWidget
@riverpod
class SimpleProductForm extends _$SimpleProductFormWidget {
  @override
  SimpleProductState build() {
    return const SimpleProductState();
  }

  @override
  Future<String> submit(MutationTransaction tsx, SimpleProductState state) async {
    // Validation
    if (state.name.trim().isEmpty) {
      throw Exception('Product name is required');
    }
    if (state.price <= 0) {
      throw Exception('Price must be greater than 0');
    }
    if (state.category.trim().isEmpty) {
      throw Exception('Category is required');
    }
    if (state.sku.trim().isEmpty) {
      throw Exception('SKU is required');
    }
    if (state.stockQuantity < 0) {
      throw Exception('Stock quantity cannot be negative');
    }

    // Simulate API call
    print('Creating product: ${state.name}');
    print('Price: \$${state.price}');
    print('Category: ${state.category}');
    print('Stock: ${state.stockQuantity}');

    await Future.delayed(const Duration(seconds: 1));

    // Generate product ID
    final productId = 'PRD-${DateTime.now().millisecondsSinceEpoch}';

    return productId;
  }

  @override
  void onSuccess(String productId) {
    print('Product created successfully: $productId');
  }
}