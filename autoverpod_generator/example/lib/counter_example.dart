import 'package:autoverpod/autoverpod.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'counter_example.freezed.dart';
part 'counter_example.g.dart';

@freezed
sealed class CounterState with _$CounterState {
  const CounterState._();

  const factory CounterState({
    @Default(0) int count,
    @Default('') String name,
  }) = _CounterState;
}

@formWidget
@riverpod
class CounterForm extends _$CounterFormWidget {
  @override
  CounterState build() {
    return const CounterState();
  }

  @override
  Future<String> submit(MutationTransaction tsx, CounterState state) async {
    // Simulate API call
    await Future.delayed(const Duration(seconds: 1));
    return 'Saved: ${state.name} with count ${state.count}';
  }

  @override
  void onSuccess(String result) {
    print('Form submitted successfully: $result');
  }
}