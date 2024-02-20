// ignore_for_file: deprecated_member_use

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pbl5/app_common_data/common_data/global_variable.dart';
import 'package:pbl5/public_providers/providers/app_notification_cubit/app_notification_cubit.dart';
import 'package:pbl5/public_providers/providers/app_user_cubit/app_user_cubit.dart';
import '/app_common_data/themes/app_theme.dart';

extension BuildContextExt on BuildContext {
  ///
  /// MediaQuery
  ///
  Size get screenSize => MediaQuery.of(this).size;
  EdgeInsets get viewInset => MediaQuery.of(this).viewInsets;
  EdgeInsets get viewPadding => MediaQuery.of(this).padding;
  double get devicePixelRatio => MediaQuery.of(this).devicePixelRatio;
  Orientation get orientation => MediaQuery.of(this).orientation;
  double get textScaleFactor => MediaQuery.of(this).textScaleFactor;
  bool get alwaysUse24HourFormat => MediaQuery.of(this).alwaysUse24HourFormat;

  ///
  /// Localizations
  ///
  Locale get currentLocale => locale;
  String get currentLanguageCode => currentLocale.languageCode;

  ///
  /// ThemeData & AppTheme
  ///
  ThemeData get theme => Theme.of(this);
  AppTheme get appTheme => AppTheme.of(this)!;

  ///
  /// Focus manager
  ///
  void unfocus() => FocusScope.of(this).unfocus();

  ///
  /// Drawer
  ///
  bool get hasDrawer => Scaffold.of(this).hasDrawer;
  void openDrawer() => hasDrawer ? Scaffold.of(this).openDrawer() : null;
  void closeDrawer() => hasDrawer ? Scaffold.of(this).closeDrawer() : null;

  ///
  /// Navigator
  ///
  bool get canPop => Navigator.of(this).canPop();
  // Pop
  void pop<T extends Object?>([T? result]) => Navigator.of(this).pop(result);
  // Push route
  Future<T?> pushRoute<T extends Object?>(
          Widget Function(BuildContext context) builder) =>
      Navigator.of(this).push(MaterialPageRoute(builder: builder));
  // Push named
  Future<T?> pushNamed<T extends Object?>(String routeName,
          {Object? arguments}) =>
      Navigator.of(this).pushNamed<T>(routeName, arguments: arguments);
  // Pop and push named
  Future<T?> popAndPushNamed<T extends Object?, TO extends Object?>(
          String routeName,
          {TO? result,
          Object? arguments}) =>
      Navigator.of(this).popAndPushNamed<T, TO>(
        routeName,
        result: result,
        arguments: arguments,
      );
  // Push Named And Remove Until
  Future<T?> pushNamedAndRemoveUntil<T extends Object?>(
    String newRouteName,
    bool Function(Route<dynamic>) predicate, {
    Object? arguments,
  }) =>
      Navigator.of(this).pushNamedAndRemoveUntil<T>(
        newRouteName,
        predicate,
        arguments: arguments,
      );
  // Push Named And Remove Until
  Future<T?> pushReplacementNamed<T extends Object?, TO extends Object?>(
    String routeName, {
    TO? result,
    Object? arguments,
  }) =>
      Navigator.of(this).pushReplacementNamed<T, TO>(
        routeName,
        result: result,
        arguments: arguments,
      );

  ///
  /// ModalRoute
  ///
  ModalRoute<dynamic>? get modalRoute => ModalRoute.of(this);
  T? getArguments<T>() =>
      modalRoute == null ? null : ModalRoute.of(this)!.settings.arguments as T;

  ///
  /// App data
  ///
  Future<void> clearAppData() async {
    read<AppUserCubit>().cleanUserData();
    read<AppNotificationCubit>().clearData();
    await sp.clear();
  }
}
