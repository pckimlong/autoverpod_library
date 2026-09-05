import 'import_resolution_types.dart';
import 'nested_alias.dart';

class NestedState {
  const NestedState(this.channels, this.selection);
  final Channels channels;
  final (PaymentChannel, {OrgId owner}) selection;
}
