import 'package:autoverpod_example/user_profile.dart';
import 'package:autoverpod_example/user_profile.widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('sync family and non-family field updates preserve other fields', () {
    final container = ProviderContainer();
    addTearDown(container.dispose);
    final family = container.listen(userProfileProvider(7), (_, _) {});
    final plain = container.listen(secondUserProfileProvider, (_, _) {});
    container.read(userProfileProvider(7).notifier).updateName('Family');
    container.read(secondUserProfileProvider.notifier).updateAge(42);
    expect(family.read().name, 'Family');
    expect(family.read().age, 0);
    container.read(userProfileProvider(7).notifier).resetName();
    expect(family.read().name, '');
    expect(plain.read().age, 42);
    expect(plain.read().name, 'Second');
  });

  test('async family and non-family field updates preserve AsyncData',
      () async {
    final container = ProviderContainer();
    addTearDown(container.dispose);
    container.listen(asyncUserProfileProvider(7), (_, _) {});
    container.listen(asyncPlainProvider, (_, _) {});
    await container.read(asyncUserProfileProvider(7).future);
    await container.read(asyncPlainProvider.future);
    container.read(asyncUserProfileProvider(7).notifier).updateName('Async');
    container.read(asyncPlainProvider.notifier).updateAge(12);
    expect(
        container.read(asyncUserProfileProvider(7)).requireValue.name, 'Async');
    expect(container.read(asyncPlainProvider).requireValue.age, 12);
  });

  testWidgets('generated text field uses external controller and updates state',
      (tester) async {
    final container = ProviderContainer();
    final controller = TextEditingController();
    addTearDown(container.dispose);
    addTearDown(controller.dispose);
    await tester.pumpWidget(UncontrolledProviderScope(
      container: container,
      child: MaterialApp(
          home: SecondUserProfileNameField(
        controller: controller,
        builder: (context, ref) =>
            Material(child: TextField(controller: ref.textController)),
      )),
    ));
    expect(controller.text, 'Second');
    await tester.enterText(find.byType(TextField), 'Edited');
    await tester.pump(const Duration(seconds: 1));
    expect(container.read(secondUserProfileProvider).name, 'Edited');
    container.read(secondUserProfileProvider.notifier).updateName('Server');
    await tester.pump();
    expect(controller.text, 'Server');
    await tester.pumpWidget(const SizedBox());
    controller.text = 'Still usable';
  });
}
