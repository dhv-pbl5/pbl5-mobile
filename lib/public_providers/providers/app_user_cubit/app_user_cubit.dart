import 'package:bloc/bloc.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import '/app_common_data/themes/app_theme_data_factory.dart';
import '/app_common_data/themes/app_theme_data_version.dart';
import '/app_common_data/themes/versions/app_theme_data_v1.dart';
import '/app_common_data/common_data/global_variable.dart';
import '/app_common_data/themes/app_theme_data.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import '/app_common_data/enums/app_language.dart';
import '/models/user/user.dart';
import '/public_providers/config/update_state.dart';

part 'app_user_state.dart';
part 'app_user_cubit.freezed.dart';

class AppUserCubit extends Cubit<AppUserState> with UpdateState<AppUserState> {
  AppUserCubit({
    required AppLanguage initialLanguage,
  }) : super(AppUserState.initial(
            language: initialLanguage, appThemeData: AppThemeDataV1()));

  Future<void> changeLanguage(BuildContext context, AppLanguage language) =>
      context.setLocale(language.locale).then((value) {
        emit(state.copyWith(language: language));
      });

  Future<void> changeTheme(AppThemeDataVersion version) async {
    var theme = AppThemeDataFactory.getAppThemeData(version);
    await sp.prefs.setString("theme", theme.version_label);
    emit(state.copyWith(appThemeData: theme));
  }

  void cleanUserData() => emit(state.copyWith(user: null));
}
