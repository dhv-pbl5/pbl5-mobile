// ignore_for_file: use_build_context_synchronously

import 'package:bloc/bloc.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import '/app_common_data/common_data/global_key_variable.dart';
import '/app_common_data/common_data/global_variable.dart';
import '/app_common_data/routes/app_routes.dart';
import '/generated/translations.g.dart';
import '/public_providers/config/update_state.dart';
import '/services/service_repositories/authentication_repository.dart';
import '/shared_customization/extensions/build_context.ext.dart';
import '/shared_customization/extensions/string_ext.dart';
import '/shared_customization/helpers/dialogs/dialog_helper.dart';
import '/shared_customization/helpers/utilizations/dio_parse_error.dart';

part 'dynamic_link_state.dart';
part 'dynamic_link_cubit.freezed.dart';

class DynamicLinkCubit extends Cubit<DynamicLinkState>
    with UpdateState<DynamicLinkState> {
  DynamicLinkCubit() : super(const DynamicLinkState.initial()) {
    _initDynamicLinks();
  }

  final _authRepo = AuthenticationRepositoty(apis: apis);

  void _initDynamicLinks() async {
    // Foreground
    FirebaseDynamicLinks.instance.onLink.listen((pendingDynamicLinkData) {
      debugPrint("DYNAMIC LINK ${pendingDynamicLinkData.link}".debug);
      _handleDynamicLink(pendingDynamicLinkData.link);
    });

    // Background
    final PendingDynamicLinkData? data =
        await FirebaseDynamicLinks.instance.getInitialLink();
    if (data != null) _handleDynamicLink(data.link);
  }

  Future<void> _handleDynamicLink(Uri uri) async {
    if (uri.path.trim().isEmpty) return;
    await Future.doWhile(() async {
      await Future.delayed(const Duration(milliseconds: 500));
      return GlobalKeyVariable.navigatorState.currentContext == null;
    });
    var context = GlobalKeyVariable.navigatorState.currentContext!;
    try {
      // active account
      if (uri.path.contains("register/confirm") &&
          !uri.path.contains("password/reset")) {
        // String? confirmToken = uri.queryParameters['token'];
        // bool isConfirm = await confirmAccount(confirmToken ?? "");
        // if (isConfirm == true) {
        //   showSuccessDialog(context,
        //           title: tr(LocaleKeys.Login_ActiveAccountSuccessTitle),
        //           content: tr(LocaleKeys.Login_ActiveAccountSuccessContent))
        //       .then((_) async {
        //     if (sp.accessToken.isNotEmptyOrNull) {
        //       await _authenticationRepository.logOut().then((_) {
        //         context.read<AppUserCubit>().cleanUserData();
        //         // context.read<AppNotificationCubit>()
        //         //   ..clearNotification()
        //         //   ..logoutOnesignal();
        //         context.pushNamed(Routes.loginScreen);
        //       });
        //     } else {
        //       context.pushNamed(Routes.loginScreen);
        //     }
        //   });
        // }
      } else if (uri.path.contains("password/reset") &&
          !uri.path.contains("register/confirm")) {
        String? token = uri.queryParameters["token"];
        if (token != null && token.isNotEmpty) {
          emit(state.copyWith(currentResetPasswordToken: token));
        }
      } else {
        showErrorDialog(context,
                title: tr(LocaleKeys.CommonData_Error),
                content: tr(LocaleKeys.Error_UnexpectedError))
            .then((_) async {
          if (sp.accessToken.isNotEmptyOrNull) {
            await _authRepo.logOut().then((_) {
              // context.read<AppUserCubit>().cleanUserData();
              // context.read<AppNotificationCubit>()
              //   ..clearNotification()
              //   ..logoutOnesignal();
              context.pushNamed(Routes.loginScreen);
            });
          } else {
            context.pushNamed(Routes.loginScreen);
          }
        });
      }
    } catch (err) {
      showErrorDialog(context,
          title: tr(LocaleKeys.CommonData_Error), content: parseError(err));
    }
  }
}
