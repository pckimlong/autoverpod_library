import 'package:autoverpod/autoverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'import_resolution_models.dart';

part 'import_resolution_provider.g.dart';

@stateWidget
@riverpod
class ImportResolution extends _$ImportResolution {
  @override
  ImportResolutionState build() {
    return ImportResolutionState.initial();
  }
}
