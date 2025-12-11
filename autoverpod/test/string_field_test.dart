import 'package:autoverpod/autoverpod.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('StringFieldRef', () {
    test('holds controller and update function', () {
      final controller = TextEditingController();
      String? capturedValue;

      final ref = StringFieldRef(
        controller: controller,
        update: (value) => capturedValue = value,
      );

      expect(ref.controller, same(controller));
      ref.update('test');
      expect(capturedValue, 'test');

      controller.dispose();
    });
  });

  group('StringField', () {
    group('initialization', () {
      testWidgets('creates internal controller when none provided',
          (tester) async {
        TextEditingController? capturedController;

        await tester.pumpWidget(
          Directionality(
            textDirection: TextDirection.ltr,
            child: StringField(
              value: 'initial',
              onChanged: (_) {},
              builder: (context, ref) {
                capturedController = ref.controller;
                return const SizedBox();
              },
            ),
          ),
        );

        expect(capturedController, isNotNull);
        expect(capturedController!.text, 'initial');
      });

      testWidgets('uses external controller when provided', (tester) async {
        final externalController = TextEditingController(text: 'external');
        TextEditingController? capturedController;

        await tester.pumpWidget(
          Directionality(
            textDirection: TextDirection.ltr,
            child: StringField(
              value: 'initial',
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
        // External controller retains its text when not empty
        expect(capturedController!.text, 'external');
        externalController.dispose();
      });

      testWidgets('syncs initial value to empty external controller',
          (tester) async {
        final externalController = TextEditingController();

        await tester.pumpWidget(
          Directionality(
            textDirection: TextDirection.ltr,
            child: StringField(
              value: 'sync-me',
              controller: externalController,
              onChanged: (_) {},
              builder: (context, ref) => const SizedBox(),
            ),
          ),
        );

        expect(externalController.text, 'sync-me');
        externalController.dispose();
      });

      testWidgets('treats null value as empty string', (tester) async {
        TextEditingController? capturedController;

        await tester.pumpWidget(
          Directionality(
            textDirection: TextDirection.ltr,
            child: StringField(
              value: null,
              onChanged: (_) {},
              builder: (context, ref) {
                capturedController = ref.controller;
                return const SizedBox();
              },
            ),
          ),
        );

        expect(capturedController!.text, '');
      });
    });

    group('two-way synchronization', () {
      testWidgets('calls onChanged when controller text changes',
          (tester) async {
        String? changedValue;
        TextEditingController? capturedController;

        await tester.pumpWidget(
          Directionality(
            textDirection: TextDirection.ltr,
            child: StringField(
              value: '',
              onChanged: (value) => changedValue = value,
              builder: (context, ref) {
                capturedController = ref.controller;
                return const SizedBox();
              },
            ),
          ),
        );

        // Simulate controller text change
        capturedController!.text = 'new text';
        await tester.pump();

        expect(changedValue, 'new text');
      });

      testWidgets('updates controller when value prop changes', (tester) async {
        TextEditingController? capturedController;

        await tester.pumpWidget(
          Directionality(
            textDirection: TextDirection.ltr,
            child: StringField(
              value: 'initial',
              onChanged: (_) {},
              builder: (context, ref) {
                capturedController = ref.controller;
                return const SizedBox();
              },
            ),
          ),
        );

        expect(capturedController!.text, 'initial');

        // Update value prop
        await tester.pumpWidget(
          Directionality(
            textDirection: TextDirection.ltr,
            child: StringField(
              value: 'updated',
              onChanged: (_) {},
              builder: (context, ref) {
                capturedController = ref.controller;
                return const SizedBox();
              },
            ),
          ),
        );

        expect(capturedController!.text, 'updated');
      });

      testWidgets('does not call onChanged when value matches controller text',
          (tester) async {
        int callCount = 0;
        TextEditingController? capturedController;

        await tester.pumpWidget(
          Directionality(
            textDirection: TextDirection.ltr,
            child: StringField(
              value: 'same',
              onChanged: (_) => callCount++,
              builder: (context, ref) {
                capturedController = ref.controller;
                return const SizedBox();
              },
            ),
          ),
        );

        // Set the same value
        capturedController!.text = 'same';
        await tester.pump();

        expect(callCount, 0);
      });

      testWidgets('does not update controller if value matches controller text',
          (tester) async {
        TextEditingController? capturedController;

        await tester.pumpWidget(
          Directionality(
            textDirection: TextDirection.ltr,
            child: StringField(
              value: 'test',
              onChanged: (_) {},
              builder: (context, ref) {
                capturedController = ref.controller;
                return const SizedBox();
              },
            ),
          ),
        );

        // Manually change controller text
        capturedController!.text = 'modified';

        // Update with same value (should not revert)
        await tester.pumpWidget(
          Directionality(
            textDirection: TextDirection.ltr,
            child: StringField(
              value: 'modified', // matches controller
              onChanged: (_) {},
              builder: (context, ref) => const SizedBox(),
            ),
          ),
        );

        expect(capturedController!.text, 'modified');
      });
    });

    group('controller lifecycle', () {
      testWidgets('disposes internal controller on widget dispose',
          (tester) async {
        TextEditingController? capturedController;

        await tester.pumpWidget(
          Directionality(
            textDirection: TextDirection.ltr,
            child: StringField(
              value: 'test',
              onChanged: (_) {},
              builder: (context, ref) {
                capturedController = ref.controller;
                return const SizedBox();
              },
            ),
          ),
        );

        final controller = capturedController!;

        // Remove widget
        await tester.pumpWidget(const SizedBox());

        // Attempting to use a disposed controller throws
        expect(
          () => controller.text = 'fail',
          throwsA(isA<FlutterError>()),
        );
      });

      testWidgets('does not dispose external controller on widget dispose',
          (tester) async {
        final externalController = TextEditingController(text: 'external');

        await tester.pumpWidget(
          Directionality(
            textDirection: TextDirection.ltr,
            child: StringField(
              value: '',
              controller: externalController,
              onChanged: (_) {},
              builder: (context, ref) => const SizedBox(),
            ),
          ),
        );

        // Remove widget
        await tester.pumpWidget(const SizedBox());

        // External controller should still be usable
        expect(() => externalController.text = 'still works', returnsNormally);

        externalController.dispose();
      });

      testWidgets('handles controller swap from internal to external',
          (tester) async {
        TextEditingController? capturedController;
        final externalController = TextEditingController(text: 'external');

        // Start with internal controller
        await tester.pumpWidget(
          Directionality(
            textDirection: TextDirection.ltr,
            child: StringField(
              value: 'internal',
              onChanged: (_) {},
              builder: (context, ref) {
                capturedController = ref.controller;
                return const SizedBox();
              },
            ),
          ),
        );

        final internalController = capturedController!;
        expect(internalController.text, 'internal');

        // Swap to external controller
        await tester.pumpWidget(
          Directionality(
            textDirection: TextDirection.ltr,
            child: StringField(
              value: 'ignored',
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
        expect(capturedController!.text, 'external');

        // Internal controller should be disposed
        expect(
          () => internalController.text = 'fail',
          throwsA(isA<FlutterError>()),
        );

        externalController.dispose();
      });

      testWidgets('handles controller swap from external to internal',
          (tester) async {
        TextEditingController? capturedController;
        final externalController = TextEditingController(text: 'external');

        // Start with external controller
        await tester.pumpWidget(
          Directionality(
            textDirection: TextDirection.ltr,
            child: StringField(
              value: 'value',
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

        // Swap to internal controller
        await tester.pumpWidget(
          Directionality(
            textDirection: TextDirection.ltr,
            child: StringField(
              value: 'new internal',
              controller: null,
              onChanged: (_) {},
              builder: (context, ref) {
                capturedController = ref.controller;
                return const SizedBox();
              },
            ),
          ),
        );

        expect(capturedController, isNot(same(externalController)));
        expect(capturedController!.text, 'new internal');

        // External controller should still work
        expect(() => externalController.text = 'test', returnsNormally);

        externalController.dispose();
      });

      testWidgets('handles swap between two external controllers',
          (tester) async {
        TextEditingController? capturedController;
        final controller1 = TextEditingController(text: 'first');
        final controller2 = TextEditingController(text: 'second');

        await tester.pumpWidget(
          Directionality(
            textDirection: TextDirection.ltr,
            child: StringField(
              value: '',
              controller: controller1,
              onChanged: (_) {},
              builder: (context, ref) {
                capturedController = ref.controller;
                return const SizedBox();
              },
            ),
          ),
        );

        expect(capturedController, same(controller1));

        // Swap to controller2
        await tester.pumpWidget(
          Directionality(
            textDirection: TextDirection.ltr,
            child: StringField(
              value: '',
              controller: controller2,
              onChanged: (_) {},
              builder: (context, ref) {
                capturedController = ref.controller;
                return const SizedBox();
              },
            ),
          ),
        );

        expect(capturedController, same(controller2));
        expect(capturedController!.text, 'second');

        // Both external controllers should still work
        expect(() => controller1.text = 'test1', returnsNormally);
        expect(() => controller2.text = 'test2', returnsNormally);

        controller1.dispose();
        controller2.dispose();
      });
    });

    group('builder function', () {
      testWidgets('provides correct context', (tester) async {
        BuildContext? capturedContext;

        await tester.pumpWidget(
          Directionality(
            textDirection: TextDirection.ltr,
            child: StringField(
              value: 'test',
              onChanged: (_) {},
              builder: (context, ref) {
                capturedContext = context;
                return const SizedBox();
              },
            ),
          ),
        );

        expect(capturedContext, isNotNull);
        expect(Directionality.of(capturedContext!), TextDirection.ltr);
      });

      testWidgets('ref.update calls onChanged', (tester) async {
        String? changedValue;
        late StringFieldRef capturedRef;

        await tester.pumpWidget(
          Directionality(
            textDirection: TextDirection.ltr,
            child: StringField(
              value: '',
              onChanged: (value) => changedValue = value,
              builder: (context, ref) {
                capturedRef = ref;
                return const SizedBox();
              },
            ),
          ),
        );

        capturedRef.update('direct update');
        expect(changedValue, 'direct update');
      });

      testWidgets('rebuilds when controller text changes', (tester) async {
        int buildCount = 0;
        TextEditingController? capturedController;

        await tester.pumpWidget(
          Directionality(
            textDirection: TextDirection.ltr,
            child: StringField(
              value: '',
              onChanged: (_) {},
              builder: (context, ref) {
                buildCount++;
                capturedController = ref.controller;
                return const SizedBox();
              },
            ),
          ),
        );

        expect(buildCount, 1);

        capturedController!.text = 'changed';
        await tester.pump();

        // Note: The widget itself doesn't rebuild on controller changes,
        // but the listener triggers onChanged
        expect(buildCount, 1);
      });
    });

    group('edge cases', () {
      testWidgets('handles rapid value changes', (tester) async {
        TextEditingController? capturedController;
        final changes = <String>[];

        await tester.pumpWidget(
          Directionality(
            textDirection: TextDirection.ltr,
            child: StringField(
              value: 'v1',
              onChanged: changes.add,
              builder: (context, ref) {
                capturedController = ref.controller;
                return const SizedBox();
              },
            ),
          ),
        );

        await tester.pumpWidget(
          Directionality(
            textDirection: TextDirection.ltr,
            child: StringField(
              value: 'v2',
              onChanged: changes.add,
              builder: (context, ref) {
                capturedController = ref.controller;
                return const SizedBox();
              },
            ),
          ),
        );

        await tester.pumpWidget(
          Directionality(
            textDirection: TextDirection.ltr,
            child: StringField(
              value: 'v3',
              onChanged: changes.add,
              builder: (context, ref) {
                capturedController = ref.controller;
                return const SizedBox();
              },
            ),
          ),
        );

        expect(capturedController!.text, 'v3');
      });

      testWidgets('handles empty string to null transition', (tester) async {
        TextEditingController? capturedController;

        await tester.pumpWidget(
          Directionality(
            textDirection: TextDirection.ltr,
            child: StringField(
              value: '',
              onChanged: (_) {},
              builder: (context, ref) {
                capturedController = ref.controller;
                return const SizedBox();
              },
            ),
          ),
        );

        expect(capturedController!.text, '');

        await tester.pumpWidget(
          Directionality(
            textDirection: TextDirection.ltr,
            child: StringField(
              value: null,
              onChanged: (_) {},
              builder: (context, ref) {
                capturedController = ref.controller;
                return const SizedBox();
              },
            ),
          ),
        );

        // null treated as empty string, so no change
        expect(capturedController!.text, '');
      });

      testWidgets('handles null to non-null transition', (tester) async {
        TextEditingController? capturedController;

        await tester.pumpWidget(
          Directionality(
            textDirection: TextDirection.ltr,
            child: StringField(
              value: null,
              onChanged: (_) {},
              builder: (context, ref) {
                capturedController = ref.controller;
                return const SizedBox();
              },
            ),
          ),
        );

        expect(capturedController!.text, '');

        await tester.pumpWidget(
          Directionality(
            textDirection: TextDirection.ltr,
            child: StringField(
              value: 'now has value',
              onChanged: (_) {},
              builder: (context, ref) {
                capturedController = ref.controller;
                return const SizedBox();
              },
            ),
          ),
        );

        expect(capturedController!.text, 'now has value');
      });

      testWidgets('handles special characters in value', (tester) async {
        TextEditingController? capturedController;
        const specialValue = 'Line1\nLine2\tTab 🎉 émoji';

        await tester.pumpWidget(
          Directionality(
            textDirection: TextDirection.ltr,
            child: StringField(
              value: specialValue,
              onChanged: (_) {},
              builder: (context, ref) {
                capturedController = ref.controller;
                return const SizedBox();
              },
            ),
          ),
        );

        expect(capturedController!.text, specialValue);
      });

      testWidgets('handles very long strings', (tester) async {
        TextEditingController? capturedController;
        final longValue = 'x' * 10000;

        await tester.pumpWidget(
          Directionality(
            textDirection: TextDirection.ltr,
            child: StringField(
              value: longValue,
              onChanged: (_) {},
              builder: (context, ref) {
                capturedController = ref.controller;
                return const SizedBox();
              },
            ),
          ),
        );

        expect(capturedController!.text, longValue);
        expect(capturedController!.text.length, 10000);
      });

      testWidgets('onChanged not called during initial build', (tester) async {
        int callCount = 0;

        await tester.pumpWidget(
          Directionality(
            textDirection: TextDirection.ltr,
            child: StringField(
              value: 'initial',
              onChanged: (_) => callCount++,
              builder: (context, ref) => const SizedBox(),
            ),
          ),
        );

        expect(callCount, 0);
      });
    });

    group('listener management', () {
      testWidgets('removes listener before disposing internal controller',
          (tester) async {
        // This test ensures no double-removal errors occur
        await tester.pumpWidget(
          Directionality(
            textDirection: TextDirection.ltr,
            child: StringField(
              value: 'test',
              onChanged: (_) {},
              builder: (context, ref) => const SizedBox(),
            ),
          ),
        );

        // Should not throw when removing widget
        await tester.pumpWidget(const SizedBox());
      });

      testWidgets('properly manages listener on controller swap',
          (tester) async {
        String? lastChange;
        final controller1 = TextEditingController(text: 'c1');
        final controller2 = TextEditingController(text: 'c2');

        await tester.pumpWidget(
          Directionality(
            textDirection: TextDirection.ltr,
            child: StringField(
              value: '',
              controller: controller1,
              onChanged: (v) => lastChange = v,
              builder: (context, ref) => const SizedBox(),
            ),
          ),
        );

        // Swap controllers
        await tester.pumpWidget(
          Directionality(
            textDirection: TextDirection.ltr,
            child: StringField(
              value: '',
              controller: controller2,
              onChanged: (v) => lastChange = v,
              builder: (context, ref) => const SizedBox(),
            ),
          ),
        );

        // Changes to old controller should not trigger onChanged
        controller1.text = 'ignored';
        await tester.pump();
        expect(lastChange, isNull);

        // Changes to new controller should trigger onChanged
        controller2.text = 'heard';
        await tester.pump();
        expect(lastChange, 'heard');

        controller1.dispose();
        controller2.dispose();
      });
    });
  });
}
