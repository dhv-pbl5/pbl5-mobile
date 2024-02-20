import 'package:flutter_bloc/flutter_bloc.dart';

mixin UpdateState<S> on Cubit<S> {
  void updateState(S Function(S s) onUpdate) => emit(onUpdate(state));
}
