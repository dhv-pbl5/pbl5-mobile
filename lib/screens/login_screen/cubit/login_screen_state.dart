part of 'login_screen_cubit.dart';

@freezed
class LoginScreenState with _$LoginScreenState, BlocBaseState {
  const factory LoginScreenState.initial({
    String? errorMessage,
    ScreenValue? status,
    String? email,
    String? pwd,
    User? user,
  }) = _Initial;
}
