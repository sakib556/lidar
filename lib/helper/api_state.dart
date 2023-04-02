import 'package:freezed_annotation/freezed_annotation.dart';
part 'api_state.freezed.dart';

@freezed
abstract class ApiState<T> with _$ApiState<T> {
  const factory ApiState.initial() = _ApiStateinitial;
  const factory ApiState.loading() = _ApiStateloading;
  const factory ApiState.loaded({required T data}) = _ApiStateloaded<T>;
  const factory ApiState.error({required String error}) = _ApiStateerror;
}
