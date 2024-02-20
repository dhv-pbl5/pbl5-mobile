import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '/app_common_data/common_data/in_app_notification.dart';
import '/public_providers/providers/app_notification_cubit/app_notification_cubit.dart';

class InAppNotiListener
    extends BlocListener<AppNotificationCubit, AppNotificationState> {
  InAppNotiListener({
    super.key,
    super.child,
    required void Function(BuildContext context, AppNotificationState state,
            InAppNotification inAppNoti)
        listener,
  }) : super(
          listenWhen: (previous, current) =>
              previous.inAppNotification != current.inAppNotification &&
              current.inAppNotification != null,
          listener: (context, state) {
            listener.call(context, state, state.inAppNotification!);
          },
        );
}
