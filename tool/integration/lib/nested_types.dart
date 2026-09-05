import 'package:autoverpod/autoverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'import_resolution_types.dart';
import 'nested_model.dart';

part 'nested_types.g.dart';

@stateWidget
@riverpod
class NestedTypes extends _$NestedTypes {
  @override
  NestedState build(OrgId owner, {required PaymentChannel channel}) =>
      NestedState([channel], (channel, owner: owner));
}
