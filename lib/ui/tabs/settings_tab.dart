import 'package:dynamic_theme/dynamic_theme.dart';
import 'package:flutter/material.dart';

class SettingsTab extends StatefulWidget {
  @override
  _SettingsTabState createState() => _SettingsTabState();
}

class _SettingsTabState extends State<SettingsTab> {
  void changeTheme() {
    DynamicTheme.of(context).setBrightness(
        Theme.of(context).brightness == Brightness.dark
            ? Brightness.light
            : Brightness.dark);
  }

  @override
  Widget build(BuildContext context) {
    final statusBarHeight = MediaQuery.of(context).padding.top;

    return Container(
      padding: EdgeInsets.only(top: statusBarHeight + 120),
      alignment: Alignment.topCenter,
      child: FlatButton(
        child: Text("Сменить тему"),
        onPressed: () {
          changeTheme();
        },
      ),
    );
  }
}
