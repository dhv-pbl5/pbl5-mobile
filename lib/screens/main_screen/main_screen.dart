import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '/app_common_data/themes/app_theme_data_version.dart';
import '/shared_customization/enums/keyboard_type.dart';
import '/shared_customization/widgets/buttons/custom_button.dart';
import '/shared_customization/widgets/texts/custom_text_field.dart';
import '/shared_customization/widgets/custom_drawer.dart';
import '/shared_customization/widgets/custom_switch.dart';
import '/app_common_data/enums/app_language.dart';
import '/generated/translations.g.dart';
import '/public_providers/providers/app_user_cubit/app_user_cubit.dart';
import '/shared_customization/widgets/texts/custom_text.dart';
import '/screens/bloc_base_screen.dart';
import '/screens/main_screen/cubit/main_screen_cubit.dart';
import '/shared_customization/widgets/custom_layout.dart';
import '/shared_customization/widgets/custom_widgets/custom_dismiss_keyboard.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocBaseScreen<MainScreenCubit, MainScreenState>.multiProvider(
      providers: [
        BlocProvider<MainScreenCubit>(create: (context) => MainScreenCubit()),
      ],
      builder: (context, state) {
        return CustomDismissKeyboard(
            child: CustomLayout.buttonNextPage(
          onWillPop: () => Future.value(false),
          title: "Main Screen",
          onButtonTap: () {},
          drawer: CustomDrawer(
            items: [DrawerModel(label: "abc")],
          ),
          child: Column(
            children: [
              CustomText(tr(LocaleKeys.AppUpdate_NewUpdateIsAvailable)),
              CustomText.timeAgo(
                dateTime: DateTime.now().subtract(const Duration(minutes: 15)),
                isShort: true,
              ),
              CustomText.timeAgo(
                dateTime: DateTime.now().subtract(const Duration(days: 1)),
                isShort: false,
              ),
              CustomButton(
                onPressed: () {},
              ),
              CustomTextField(
                  keyboardType: KeyboardType.datetime, onChanged: (value) {}),
              CustomTextField(
                  keyboardType: KeyboardType.datetimeHour,
                  onChanged: (value) {}),
              CustomSwitch(
                onChanged: (value) {
                  value
                      ? context
                          .read<AppUserCubit>()
                          .changeLanguage(context, AppLanguage.vi)
                      : context
                          .read<AppUserCubit>()
                          .changeLanguage(context, AppLanguage.en);
                },
              ),
              CustomSwitch(
                onChanged: (value) {
                  value
                      ? context
                          .read<AppUserCubit>()
                          .changeTheme(AppThemeDataVersion.v2)
                      : context
                          .read<AppUserCubit>()
                          .changeTheme(AppThemeDataVersion.v1);
                },
              ),
            ],
          ),
        ));
      },
    );
  }
}
