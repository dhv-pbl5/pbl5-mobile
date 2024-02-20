import 'package:easy_localization/easy_localization.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pbl5/shared_customization/extensions/string_ext.dart';
import 'package:pbl5/shared_customization/widgets/buttons/custom_button.dart';
import 'package:pbl5/shared_customization/widgets/buttons/custom_text_button.dart';
import 'package:pbl5/shared_customization/widgets/custom_container.dart';
import 'package:pbl5/shared_customization/widgets/custom_layout.dart';
import 'package:pbl5/shared_customization/widgets/custom_widgets/custom_dismiss_keyboard.dart';
import 'package:pbl5/shared_customization/widgets/form_fields/custom_form.dart';
import 'package:pbl5/shared_customization/widgets/form_fields/custom_text_form_field.dart';
import 'package:pbl5/shared_customization/widgets/texts/custom_text.dart';
import '/app_common_data/app_text_sytle.dart';
import '/app_common_data/common_data/global_variable.dart';
import '/app_common_data/routes/app_routes.dart';
import '/public_providers/providers/app_user_cubit/app_user_cubit.dart';
import '/screens/bloc_base_screen.dart';
import '/screens/login_screen/cubit/login_screen_cubit.dart';
import '/shared_customization/extensions/build_context.ext.dart';
import '/shared_customization/helpers/utilizations/validators.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBaseScreen<LoginScreenCubit, LoginScreenState>(
      createCubit: (_) => LoginScreenCubit(),
      onShowSuccess: (_, state) => Future(() => null),
      onShowSuccessDone: (_, state) {
        context
            .read<AppUserCubit>()
            .updateState((s) => s.copyWith(user: state.user));
        context.popAndPushNamed(Routes.mainScreen);
      },
      builder: (context, state) {
        final color = context.appTheme.appThemeData;
        return CustomDismissKeyboard(
          canPop: false,
          child: CustomLayout.scrollableView(
            leading: EMPTY_WIDGET,
            leadingWidth: 0,
            showAppBar: false,
            paddingAll: const EdgeInsets.all(16),
            child: CustomForm(
              child: (formKey) => Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  CustomContainer(
                    color: const Color(0xFFF5F5F5),
                    borderRadius: BorderRadius.circular(40),
                    padding: const EdgeInsets.all(24),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        CustomText(
                          tr('Sign in'.hardCoded),
                          style: AppTextStyle.header
                              .copyWith(color: color.primary_color),
                          padding: const EdgeInsets.only(bottom: 40),
                        ),
                        CustomTextFormField(
                          label: tr('Email'.hardCoded),
                          onChanged: (value) {
                            context
                                .read<LoginScreenCubit>()
                                .updateState((s) => s.copyWith(email: value));
                          },
                          validations: const [Validators.validateEmail],
                        ),
                        const SizedBox(height: 20),
                        CustomTextFormField(
                          label: tr('Password'.hardCoded),
                          obscureText: true,
                          onChanged: (value) {
                            context
                                .read<LoginScreenCubit>()
                                .updateState((s) => s.copyWith(pwd: value));
                          },
                          validations: const [Validators.validatePassword],
                        ),
                        const SizedBox(height: 8),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            CustomTextButton(
                                onPressed: () {},
                                text: CustomText(
                                    tr('Forgot password'.hardCoded))),
                          ],
                        ),
                        const SizedBox(height: 32),
                        CustomButton(
                          onPressed: () {
                            context.unfocus();
                            if (formKey.currentState?.validate() ?? false) {
                              context.read<LoginScreenCubit>().login();
                            }
                          },
                          width: MAX_WIDTH_SCREEN,
                          label: tr('Sign in'.hardCoded),
                        ),
                        CustomText(
                          tr('Do not have any account?'.hardCoded),
                          padding: const EdgeInsets.only(top: 16, bottom: 4),
                        ),
                        CustomTextButton(
                          onPressed: () {
                            // context.popAndPushNamed(Routes.registerScreen);
                          },
                          text: CustomText(
                            'Register'.hardCoded,
                            color: color.primary_color,
                            fontWeight: FontWeight.w600,
                          ),
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
