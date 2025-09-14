import 'package:autoverpod/autoverpod.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'state_widget_example.g.dart';

@riverpod
@stateWidget
String myName(Ref ref) {
  return 'Kim';
}

@riverpod
@stateWidget
class MyNameAsync extends _$MyNameAsync {
  @override
  FutureOr<String> build() {
    return 'Kim';
  }
}
