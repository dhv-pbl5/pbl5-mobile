import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:device_preview/device_preview.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

import '/app_common_data/enums/app_language.dart';
import '/app_common_data/common_data/global_variable.dart';
import '/screens/my_app/my_app.dart';
import '/shared_customization/widgets/custom_widgets/screens/custom_error_screen.dart';

void main() async {
  ///
  /// Init global variable
  ///
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();
  await sp.init();
  await dotenv.load(fileName: '.env');
  // apis = ApiClient(AppDio(), baseUrl: dotenv.env['BASE_URL']!);

  ///
  /// Custom Error Widget
  ///
  ErrorWidget.builder =
      (details) => CustomErrorScreen(errorMessage: '${details.exception}');

  ///
  /// Run Application
  ///
  runApp(
    DevicePreview(
        enabled: false,
        builder: (context) {
          return EasyLocalization(
            path: 'assets/translations',
            supportedLocales: AppLanguage.values.map((e) => e.locale).toList(),
            startLocale: AppLanguage.vi.locale,
            saveLocale: true,
            useOnlyLangCode: true,
            fallbackLocale: AppLanguage.vi.locale,
            child: const MyApp(),
          );
        }),
  );
}
