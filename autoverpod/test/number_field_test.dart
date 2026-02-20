import 'package:autoverpod/autoverpod.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('NumberFieldRef', () {
    test('holds controller and update function', () {
      final controller = TextEditingController();
      int? capturedValue;

      final ref = NumberFieldRef<int>(
        controller: controller,
        update: (value) => capturedValue = value,
      );

      expect(ref.controller, same(controller));
      ref.update(123);
      expect(capturedValue, 123);

      controller.dispose();
    });
  });

  group('NumberField', () {
    group('initialization', () {
      testWidgets('creates internal controller when none provided',
          (tester) async {
        TextEditingController? capturedController;

        await tester.pumpWidget(
          Directionality(
            textDirection: TextDirection.ltr,
            child: NumberField<int>(
              value: 42,
              onChanged: (_) {},
              builder: (context, ref) {
                capturedController = ref.controller;
                return const SizedBox();
              },
            ),
          ),
        );

        expect(capturedController, isNotNull);
        expect(capturedController!.text, '42');
      });

      testWidgets('uses external controller when provided', (tester) async {
        final externalController = TextEditingController(text: '99');
        TextEditingController? capturedController;

        await tester.pumpWidget(
          Directionality(
            textDirection: TextDirection.ltr,
            child: NumberField<int>(
              value: 42,
              controller: externalController,
              onChanged: (_) {},
              builder: (context, ref) {
                capturedController = ref.controller;
                return const SizedBox();
              },
            ),
          ),
        );

        expect(capturedController, same(externalController));
        expect(capturedController!.text, '99');
        externalController.dispose();
      });

      testWidgets('syncs initial value to empty external controller',
          (tester) async {
        final externalController = TextEditingController();

        await tester.pumpWidget(
          Directionality(
            textDirection: TextDirection.ltr,
            child: NumberField<int>(
              value: 7,
              controller: externalController,
              onChanged: (_) {},
              builder: (context, ref) => const SizedBox(),
            ),
          ),
        );

        expect(externalController.text, '7');
        externalController.dispose();
      });
    });

    group('two-way synchronization', () {
      testWidgets('calls onChanged when controller text changes',
          (tester) async {
        int? changedValue;
        TextEditingController? capturedController;

        await tester.pumpWidget(
          Directionality(
            textDirection: TextDirection.ltr,
            child: NumberField<int>(
              value: null,
              onChanged: (value) => changedValue = value,
              builder: (context, ref) {
                capturedController = ref.controller;
                return const SizedBox();
              },
            ),
          ),
        );

        capturedController!.text = '123';
        await tester.pump();

        expect(changedValue, 123);
      });

      testWidgets('passes null when text cannot be parsed', (tester) async {
        int? changedValue = 1;
        TextEditingController? capturedController;

        await tester.pumpWidget(
          Directionality(
            textDirection: TextDirection.ltr,
            child: NumberField<int>(
              value: 1,
              onChanged: (value) => changedValue = value,
              builder: (context, ref) {
                capturedController = ref.controller;
                return const SizedBox();
              },
            ),
          ),
        );

        capturedController!.text = 'not-a-number';
        await tester.pump();

        expect(changedValue, isNull);
      });

      testWidgets('updates controller when value prop changes', (tester) async {
        TextEditingController? capturedController;

        await tester.pumpWidget(
          Directionality(
            textDirection: TextDirection.ltr,
            child: NumberField<int>(
              value: 1,
              onChanged: (_) {},
              builder: (context, ref) {
                capturedController = ref.controller;
                return const SizedBox();
              },
            ),
          ),
        );

        expect(capturedController!.text, '1');

        await tester.pumpWidget(
          Directionality(
            textDirection: TextDirection.ltr,
            child: NumberField<int>(
              value: 2,
              onChanged: (_) {},
              builder: (context, ref) {
                capturedController = ref.controller;
                return const SizedBox();
              },
            ),
          ),
        );

        expect(capturedController!.text, '2');
      });
    });

    group('debounce', () {
      testWidgets('cancels pending debounced onChanged when value prop changes',
          (tester) async {
        final changes = <int?>[];
        TextEditingController? capturedController;

        await tester.pumpWidget(
          Directionality(
            textDirection: TextDirection.ltr,
            child: NumberField<int>(
              value: null,
              debounceDuration: const Duration(milliseconds: 100),
              onChanged: changes.add,
              builder: (context, ref) {
                capturedController = ref.controller;
                return const SizedBox();
              },
            ),
          ),
        );

        capturedController!.text = '10';
        await tester.pump();

        // Parent-driven update arrives before the debounce fires.
        await tester.pumpWidget(
          Directionality(
            textDirection: TextDirection.ltr,
            child: NumberField<int>(
              value: 999,
              debounceDuration: const Duration(milliseconds: 100),
              onChanged: changes.add,
              builder: (context, ref) {
                capturedController = ref.controller;
                return const SizedBox();
              },
            ),
          ),
        );

        expect(capturedController!.text, '999');
        await tester.pump(const Duration(milliseconds: 150));
        expect(changes, isEmpty);
      });

      testWidgets(
          'cancels pending debounced onChanged when controller prop changes',
          (tester) async {
        final changes = <int?>[];
        final controller1 = TextEditingController();
        final controller2 = TextEditingController();

        await tester.pumpWidget(
          Directionality(
            textDirection: TextDirection.ltr,
            child: NumberField<int>(
              value: null,
              controller: controller1,
              debounceDuration: const Duration(milliseconds: 100),
              onChanged: changes.add,
              builder: (context, ref) => const SizedBox(),
            ),
          ),
        );

        controller1.text = '1';
        await tester.pump();

        // Swap controllers before debounce fires.
        await tester.pumpWidget(
          Directionality(
            textDirection: TextDirection.ltr,
            child: NumberField<int>(
              value: 2,
              controller: controller2,
              debounceDuration: const Duration(milliseconds: 100),
              onChanged: changes.add,
              builder: (context, ref) => const SizedBox(),
            ),
          ),
        );

        await tester.pump(const Duration(milliseconds: 150));
        expect(changes, isEmpty);

        controller1.dispose();
        controller2.dispose();
      });
    });
  });
}
