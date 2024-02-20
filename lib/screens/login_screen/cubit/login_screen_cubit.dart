import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import '/models/user/user.dart';
import '/public_providers/config/bloc_base_state.dart';
import '/public_providers/config/update_bloc_base_state.dart';
import '/shared_customization/data/screen_value.dart';
import '/shared_customization/helpers/dialogs/dialog_helper.dart';
import '/shared_customization/helpers/utilizations/dio_parse_error.dart';

part 'login_screen_state.dart';
part 'login_screen_cubit.freezed.dart';

class LoginScreenCubit extends Cubit<LoginScreenState>
    with UpdateBlocBaseState<LoginScreenState> {
  LoginScreenCubit() : super(const LoginScreenState.initial());

  Future<void> login() async {
    final cancel = showLoading();
    try {
      cancel();
    } catch (e) {
      cancel();
      emit(state.copyWith(errorMessage: parseError(e)));
    }
  }

  @override
  void resetErrorMessage() => emit(state.copyWith(errorMessage: null));

  @override
  void resetStatus() => emit(state.copyWith(status: null));
}
