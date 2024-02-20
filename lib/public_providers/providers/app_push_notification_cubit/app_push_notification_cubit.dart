import 'package:bloc/bloc.dart';
import '/public_providers/config/update_state.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'app_push_notification_state.dart';
part 'app_push_notification_cubit.freezed.dart';

class AppPushNotificationCubit extends Cubit<AppPushNotificationState>
    with UpdateState<AppPushNotificationState> {
  AppPushNotificationCubit() : super(const AppPushNotificationState.initial());
}
