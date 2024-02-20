import 'package:flutter/material.dart';
import 'package:pbl5/shared_customization/extensions/string_ext.dart';
import 'package:pbl5/shared_customization/widgets/custom_layout.dart';
import 'package:pbl5/shared_customization/widgets/texts/custom_text.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomLayout(
        showAppBar: false,
        body: Center(
          child: CustomText("Register Screen".hardCoded),
        ));
  }
}
