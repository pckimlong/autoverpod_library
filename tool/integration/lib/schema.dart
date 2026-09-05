import 'package:supabase_schema/supabase_schema.dart';

@Schema(tableName: 'profiles', baseModelName: 'Profile')
class ProfileSchema extends SupabaseSchema {
  final id = Field.intId();
  final name = Field<String>('name');
}
