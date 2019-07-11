import 'package:construct_diet/ui/common/cards.dart' as custom;
import 'package:construct_diet/ui/common/labels.dart';
import 'package:construct_diet/ui/common/tab_body.dart';
import 'package:dynamic_theme/dynamic_theme.dart';
import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

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
    return TabBody(
      Column(children: [
        custom.Card(InfoLabel("Construct Diet", "Версия: 1.0.0 (сборка 9)",
            MdiIcons.featureSearch)),
        custom.Card(TitleLabel(
          "Разработчики",
          Icons.code,
          Row(
            children: <Widget>[
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                Text(
                  "Семён Бутенко",
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                    color: Theme.of(context).textTheme.caption.color,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 3.2),
                  child: Text(
                    "Разработчик, дизайнер",
                    style: TextStyle(
                      fontSize: 12.2,
                      color: Theme.of(context)
                          .textTheme
                          .caption
                          .color
                          .withAlpha(180),
                    ),
                  ),
                ),
              ]),
            ],
          ),
        )),
      ]),
    );
  }
}
