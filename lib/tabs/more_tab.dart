import 'package:construct_diet/common/cards.dart' as custom;
import 'package:construct_diet/common/labels.dart';
import 'package:construct_diet/common/tab_body.dart';
import 'package:dynamic_theme/dynamic_theme.dart';
import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class MoreTab extends StatefulWidget {
  @override
  _MoreTabState createState() => _MoreTabState();
}

class _MoreTabState extends State<MoreTab> {
  void changeTheme(bool isNight) {
    DynamicTheme.of(context)
        .setBrightness(isNight == true ? Brightness.dark : Brightness.light);
  }

  @override
  Widget build(BuildContext context) {
    return TabBody(
      Column(children: [
        custom.Card(InfoLabel("Construct Diet",
            description: "Версия: 1.0.0 (сборка 9)",
            icon: MdiIcons.featureSearch)),
        custom.Card(TitleLabel(
          "Настройки",
          icon: MdiIcons.settingsOutline,
          child: Column(children: [
            Divider(
              height: 5,
              color: Colors.transparent,
            ),
            InfoSwitchLabel(
              "Перейти на тёмную сторону",
              description: "Активировать тёмную тему",
              icon: MdiIcons.weatherNight,
              value: Theme.of(context).brightness == Brightness.dark,
              onChanged: (isOn) {
                changeTheme(isOn);
              },
            ),
          ]),
        )),
        custom.Card(
          TitleLabel(
            "Разработчики",
            icon: Icons.code,
            child: Column(children: [
              InfoLabel("Семён Бутенко", description: "Разработчик, дизайнер.")
            ]),
          ),
        ),
      ]),
    );
  }
}
