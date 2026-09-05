import 'package:autoverpod/autoverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:riverpod_mutation_utils/riverpod_mutation_utils.dart';
import 'schema.supabase.dart';

part 'schema_provider.g.dart';

@stateWidget
@generateMutation
@riverpod
class ProfileEditor extends _$ProfileEditorMutation
    with StateFormMixin<Profile, Profile> {
  @override
  Profile build() => Profile(id: ProfileId.fromValue(1), name: 'Schema');

  Future<Profile> save() => submit((tx, form) async => form);
}
