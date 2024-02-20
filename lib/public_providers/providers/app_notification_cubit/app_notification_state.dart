part of 'app_notification_cubit.dart';

@freezed
class AppNotificationState with _$AppNotificationState {
  const factory AppNotificationState.initial({
    @Default(0) int unreadNotificationCount,
    InAppNotification? inAppNotification,
  }) = _Initial;
}
