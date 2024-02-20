import 'package:bot_toast/bot_toast.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '/app_common_data/themes/app_theme.dart';
import '/app_common_data/themes/app_theme_data.dart';
import '/app_common_data/extensions/locale_ext.dart';
import '/app_common_data/common_data/global_key_variable.dart';
import '/shared_customization/extensions/build_context.ext.dart';
import '/app_common_data/routes/app_routes.dart';
import '/public_providers/providers/app_user_cubit/app_user_cubit.dart';
import '/public_providers/providers/page_router_cubit/page_router_cubit.dart';
import '/app_common_data/common_data/global_variable.dart';
import '/app_common_data/routes/app_router_observer.dart';

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late BuildContext _context;
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      _context.read<AppUserCubit>().changeTheme(sp.loadThemeVersion());
    });
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final botToastBuilder = BotToastInit();
    PADDING_BOTTOM = context.viewPadding.bottom;
    PADDING_TOP = context.viewPadding.top;
    MAX_WIDTH_SCREEN = context.screenSize.width;
    MAX_HEIGHT_SCREEN = context.screenSize.height;

    return MultiBlocProvider(
      providers: [
        BlocProvider(
            create: (_) => AppUserCubit(
                initialLanguage: context.currentLocale.toAppLanguage)),
        BlocProvider(create: (_) => PageRouterCubit()),
      ],
      child: Builder(builder: (context) {
        return BlocSelector<AppUserCubit, AppUserState, AppThemeData>(
          selector: (state) => state.appThemeData,
          builder: (context, appThemeData) {
            return AppTheme(
              appThemeData: appThemeData,
              child: Builder(builder: (context) {
                _context = context;
                return MaterialApp(
                  title: 'Flutter App',
                  debugShowCheckedModeBanner: false,
                  localizationsDelegates: context.localizationDelegates,
                  supportedLocales: context.supportedLocales,
                  locale: context.locale,
                  theme: ThemeData.light(),
                  darkTheme: ThemeData.dark(),
                  themeMode: ThemeMode.system,
                  initialRoute: Routes.loginScreen,
                  routes: Routes.routes,
                  navigatorObservers: [
                    AppRouteObserver(context),
                    BotToastNavigatorObserver()
                  ],
                  builder: (_, child) => botToastBuilder(
                      _,
                      MultiBlocListener(listeners: [
                        ///
                        /// AppUserCubit
                        ///
                        BlocListener<AppUserCubit, AppUserState>(
                          listener: (context, state) {},
                        ),
                      ], child: child ?? EMPTY_WIDGET)),
                  navigatorKey: GlobalKeyVariable.navigatorState,
                  scaffoldMessengerKey:
                      GlobalKeyVariable.scaffoldMessengerState,
                );
              }),
            );
          },
        );
      }),
    );
  }
}
