import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'counter_example.dart';
import 'main.dart';
import 'simple_product_form.dart';
import 'simple_user_form.dart';

void main() async {
  print('🧪 Starting verification of generated code...\n');

  final container = ProviderContainer();

  try {
    // Test 1: All providers should be accessible
    print('✅ Testing provider accessibility...');
    final counterProvider = container.read(counterFormProvider);
    final userProvider = container.read(simpleUserFormProvider);
    final productProvider = container.read(simpleProductFormProvider);
    final shopProvider = container.read(shopCreateProvider);
    print('   ✓ All providers accessible');

    // Test 2: All notifiers should be accessible
    print('✅ Testing notifier accessibility...');
    final counterNotifier = container.read(counterFormProvider.notifier);
    final userNotifier = container.read(simpleUserFormProvider.notifier);
    final productNotifier = container.read(simpleProductFormProvider.notifier);
    final shopNotifier = container.read(shopCreateProvider.notifier);
    print('   ✓ All notifiers accessible');

    // Test 3: All mutation providers should be accessible
    print('✅ Testing mutation provider accessibility...');
    final counterMutation = container.read(counterFormCallStatusProvider);
    final userMutation = container.read(simpleUserFormCallStatusProvider);
    final productMutation = container.read(simpleProductFormCallStatusProvider);
    final shopMutation = container.read(shopCreateCallStatusProvider);
    print('   ✓ All mutation providers accessible');

    // Test 4: States should have correct initial values
    print('✅ Testing initial state values...');
    final counterState = container.read(counterFormProvider);
    final userState = container.read(simpleUserFormProvider);
    final productState = container.read(simpleProductFormProvider);
    final shopState = container.read(shopCreateProvider);

    assert(counterState.count == 0, 'Counter count should be 0');
    assert(counterState.name == '', 'Counter name should be empty');
    assert(userState.firstName == '', 'User first name should be empty');
    assert(userState.lastName == '', 'User last name should be empty');
    assert(userState.email == '', 'User email should be empty');
    assert(userState.isActive == false, 'User should not be active');
    assert(productState.name == '', 'Product name should be empty');
    assert(productState.price == 0.0, 'Product price should be 0.0');
    assert(productState.category == '', 'Product category should be empty');
    assert(productState.sku == '', 'Product SKU should be empty');
    assert(productState.stockQuantity == 0, 'Product stock should be 0');
    assert(productState.isActive == false, 'Product should not be active');
    assert(productState.isFeatured == false, 'Product should not be featured');
    assert(productState.tags.isEmpty, 'Product tags should be empty');
    assert(shopState.name == 'Testing', 'Shop name should be "Testing"');
    assert(shopState.phone == '', 'Shop phone should be empty');
    print('   ✓ All initial state values correct');

    // Test 5: CounterForm should submit successfully
    print('✅ Testing CounterForm submission...');
    counterNotifier.updateState((state) => state.copyWith(count: 10, name: 'Test Submission'));

    final counterResult = await counterNotifier();
    assert(counterResult.contains('Test Submission'), 'Result should contain submission data');
    assert(counterResult.contains('10'), 'Result should contain count');
    print('   ✓ CounterForm submission successful: $counterResult');

    // Test 6: SimpleUserForm should validate correctly
    print('✅ Testing SimpleUserForm validation...');
    // Test with valid data
    userNotifier.updateState(
      (state) => state.copyWith(firstName: 'John', lastName: 'Doe', email: 'john@example.com'),
    );

    final userResult = await userNotifier();
    assert(userResult > 0, 'User result should be positive');
    print('   ✓ UserForm validation successful with result: $userResult');

    // Test with invalid data
    userNotifier.updateState(
      (state) => state.copyWith(
        firstName: '', // Empty first name
        lastName: 'Doe',
        email: 'test@example.com',
      ),
    );

    try {
      await userNotifier();
      assert(false, 'Should have thrown an exception for invalid data');
    } catch (e) {
      assert(e is Exception, 'Should throw an Exception');
      print('   ✓ UserForm correctly rejected invalid data');
    }

    // Test 7: SimpleProductForm should validate correctly
    print('✅ Testing SimpleProductForm validation...');
    // Test with valid data
    productNotifier.updateState(
      (state) => state.copyWith(
        name: 'Test Product',
        price: 19.99,
        category: 'Test Category',
        sku: 'TEST-001',
      ),
    );

    final productResult = await productNotifier();
    assert(productResult.startsWith('PRD-'), 'Product result should start with PRD-');
    print('   ✓ ProductForm validation successful with result: $productResult');

    // Test with invalid price
    productNotifier.updateState(
      (state) => state.copyWith(
        name: 'Test Product',
        price: 0.0, // Zero price
        category: 'Test Category',
        sku: 'TEST-001',
      ),
    );

    try {
      await productNotifier();
      assert(false, 'Should have thrown an exception for invalid price');
    } catch (e) {
      assert(e is Exception, 'Should throw an Exception');
      print('   ✓ ProductForm correctly rejected invalid price');
    }

    // Test 8: ShopCreate should throw UnimplementedError
    print('✅ Testing ShopCreate UnimplementedError...');
    try {
      await shopNotifier();
      assert(false, 'Should have thrown UnimplementedError');
    } catch (e) {
      assert(e is UnimplementedError, 'Should throw UnimplementedError');
      print('   ✓ ShopCreate correctly throws UnimplementedError');
    }

    // Test 9: All forms should work together
    print('✅ Testing multiple forms working together...');
    counterNotifier.updateState((state) => state.copyWith(count: 5, name: 'Counter Test'));
    userNotifier.updateState((state) => state.copyWith(firstName: 'John', lastName: 'Doe'));
    productNotifier.updateState((state) => state.copyWith(name: 'Product Test', price: 29.99));
    shopNotifier.updateState((state) => state.copyWith(name: 'Shop Test'));

    // Verify all states are updated
    final updatedCounterState = container.read(counterFormProvider);
    final updatedUserState = container.read(simpleUserFormProvider);
    final updatedProductState = container.read(simpleProductFormProvider);
    final updatedShopState = container.read(shopCreateProvider);

    assert(updatedCounterState.count == 5, 'Counter count should be 5');
    assert(updatedCounterState.name == 'Counter Test', 'Counter name should be updated');
    assert(updatedUserState.firstName == 'John', 'User first name should be updated');
    assert(updatedUserState.lastName == 'Doe', 'User last name should be updated');
    assert(updatedProductState.name == 'Product Test', 'Product name should be updated');
    assert(updatedProductState.price == 29.99, 'Product price should be updated');
    assert(updatedShopState.name == 'Shop Test', 'Shop name should be updated');
    print('   ✓ All forms work together correctly');

    // Test 10: Generated updateState methods should work
    print('✅ Testing updateState methods...');
    counterNotifier.updateState((state) => state.copyWith(count: 100));
    userNotifier.updateState((state) => state.copyWith(firstName: 'Test User'));
    productNotifier.updateState((state) => state.copyWith(price: 99.99));
    shopNotifier.updateState((state) => state.copyWith(name: 'Test Shop'));

    // Verify updates
    assert(container.read(counterFormProvider).count == 100, 'Counter count should be 100');
    assert(
      container.read(simpleUserFormProvider).firstName == 'Test User',
      'User first name should be updated',
    );
    assert(
      container.read(simpleProductFormProvider).price == 99.99,
      'Product price should be 99.99',
    );
    assert(container.read(shopCreateProvider).name == 'Test Shop', 'Shop name should be updated');
    print('   ✓ All updateState methods work correctly');

    // Test 11: States should be immutable
    print('✅ Testing state immutability...');
    final initialState = container.read(counterFormProvider);

    // State should be equal to itself
    assert(initialState == initialState, 'State should be equal to itself');

    // State should be equal to a copy with same values
    final copiedState = initialState.copyWith();
    assert(initialState == copiedState, 'State should be equal to copy');

    // After update, state should be different
    counterNotifier.updateState((state) => state.copyWith(count: 1));
    final newState = container.read(counterFormProvider);
    assert(initialState != newState, 'State should be different after update');
    print('   ✓ State immutability preserved');

    // Test 12: Multiple containers should have independent states
    print('✅ Testing container isolation...');
    final container1 = ProviderContainer();
    final container2 = ProviderContainer();

    final counterForm1 = container1.read(counterFormProvider.notifier);
    final counterForm2 = container2.read(counterFormProvider.notifier);

    // Update form in first container
    counterForm1.updateState((state) => state.copyWith(count: 1));

    // First container should have updated state
    assert(container1.read(counterFormProvider).count == 1, 'Container 1 should have count 1');

    // Second container should still have default state
    assert(container2.read(counterFormProvider).count == 0, 'Container 2 should have count 0');

    // Update form in second container
    counterForm2.updateState((state) => state.copyWith(count: 2));

    // First container should still have count 1
    assert(
      container1.read(counterFormProvider).count == 1,
      'Container 1 should still have count 1',
    );

    // Second container should now have count 2
    assert(container2.read(counterFormProvider).count == 2, 'Container 2 should have count 2');

    container1.dispose();
    container2.dispose();
    print('   ✓ Container isolation working correctly');

    // Test 13: Generated providers should have correct types
    print('✅ Testing provider types...');
    assert(
      counterProvider.runtimeType.toString().contains('CounterState'),
      'Counter provider should have correct type',
    );
    assert(
      userProvider.runtimeType.toString().contains('SimpleUserState'),
      'User provider should have correct type',
    );
    assert(
      productProvider.runtimeType.toString().contains('SimpleProductState'),
      'Product provider should have correct type',
    );
    assert(
      shopProvider.runtimeType.toString().contains('ShopCreateState'),
      'Shop provider should have correct type',
    );

    assert(
      counterNotifier.runtimeType.toString().contains('CounterForm'),
      'Counter notifier should have correct type',
    );
    assert(
      userNotifier.runtimeType.toString().contains('SimpleUserForm'),
      'User notifier should have correct type',
    );
    assert(
      productNotifier.runtimeType.toString().contains('SimpleProductForm'),
      'Product notifier should have correct type',
    );
    assert(
      shopNotifier.runtimeType.toString().contains('ShopCreate'),
      'Shop notifier should have correct type',
    );
    print('   ✓ All providers have correct types');

    // Test 14: Performance test - rapid updates
    print('✅ Testing performance with rapid updates...');
    final startTime = DateTime.now();

    // Perform 100 rapid updates
    for (int i = 0; i < 100; i++) {
      counterNotifier.updateState((state) => state.copyWith(count: i));
    }

    final endTime = DateTime.now();
    final duration = endTime.difference(startTime);

    // Should complete quickly (under 100ms)
    assert(
      duration.inMilliseconds < 100,
      'Should complete in under 100ms, took ${duration.inMilliseconds}ms',
    );

    final finalState = container.read(counterFormProvider);
    assert(finalState.count == 99, 'Final count should be 99');
    print('   ✓ Performance test passed (${duration.inMilliseconds}ms for 100 updates)');

    print('\n🎉 ALL TESTS PASSED! Generated code is working correctly.');
    print('\n📋 Verification Summary:');
    print('   ✅ Code generation was successful');
    print('   ✅ Generated providers are accessible');
    print('   ✅ Generated mutation providers are accessible');
    print('   ✅ Freezed classes are working correctly');
    print('   ✅ updateState methods are generated and working');
    print('   ✅ Form validation is working');
    print('   ✅ Multiple forms can work together');
    print('   ✅ State immutability is preserved');
    print('   ✅ Container isolation is working');
    print('   ✅ Performance is acceptable');
    print('   ✅ Provider types are correct');
  } catch (e, stackTrace) {
    print('\n❌ TEST FAILED: $e');
    print('Stack trace: $stackTrace');
  } finally {
    container.dispose();
  }
}
