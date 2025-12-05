import 'package:autoverpod/autoverpod.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'main.freezed.dart';
part 'main.g.dart';

@freezed
sealed class ShopCreateState with _$ShopCreateState {
  const ShopCreateState._();

  const factory ShopCreateState({required String name, required String phone}) = _ShopCreateState;
}

@formWidget
@riverpod
class ShopCreate extends _$ShopCreateWidget {
  @override
  ShopCreateState build() {
    return ShopCreateState(name: 'Testing', phone: '');
  }

  @override
  Future<int> submit(MutationTransaction tsx, ShopCreateState state) async {
    throw UnimplementedError();
  }

  @override
  void onSuccess(int result) {}
}
