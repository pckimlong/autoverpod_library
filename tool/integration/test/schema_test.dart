import 'package:autoverpod_example/schema.supabase.dart';
import 'package:autoverpod_example/schema_provider.dart';
import 'package:autoverpod_example/schema_provider.widget.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('schema JSON, copyWith, widget updates and mutation wiring compose',
      () async {
    final container = ProviderContainer();
    addTearDown(container.dispose);
    container.listen(profileEditorProvider, (_, _) {});
    final notifier = container.read(profileEditorProvider.notifier);
    notifier.updateName('Updated');
    final state = container.read(profileEditorProvider);
    expect(Profile.fromJson(state.toJson()).name, 'Updated');
    expect(await notifier.save(), state);
    expect(profileEditorMutation(), isNotNull);
  });
}
