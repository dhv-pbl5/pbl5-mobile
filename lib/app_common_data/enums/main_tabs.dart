import 'package:flutter/material.dart';

enum MainTabs {
  home,
  account,
}

extension MainTabsExt on MainTabs {
  String get title => {
        MainTabs.home: "",
      }[this]!;

  IconData get icon => {
        MainTabs.home: Icons.abc,
      }[this]!;

  Widget get widget => {
        MainTabs.home: const SizedBox.shrink(),
      }[this]!;

  List<Widget> get action => {
        MainTabs.home: <Widget>[],
      }[this]!;
}
