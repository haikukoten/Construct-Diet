import 'package:construct_diet/common/buttons.dart' as custom;
import 'package:construct_diet/common/cards.dart' as custom;
import 'package:construct_diet/common/labels.dart';
import 'package:construct_diet/common/tab_body.dart';
import 'package:construct_diet/scoped_models/data_model.dart';
import 'package:dynamic_theme/dynamic_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:scoped_model/scoped_model.dart';

class MoreTab extends StatefulWidget {
  @override
  _MoreTabState createState() => _MoreTabState();
}

class _MoreTabState extends State<MoreTab> {
  String version = "1.0.0";
  String buildNumber = "9";

  void changeTheme(bool isNight) {
    DynamicTheme.of(context)
        .setBrightness(isNight == true ? Brightness.dark : Brightness.light);
  }

  @override
  Widget build(BuildContext context) {
    return TabBody(
      Column(
        children: [
          custom.Card(InfoLabel("Construct Diet",
              description: "Версия: $version (сборка $buildNumber)",
              icon: MdiIcons.featureSearch)),
          custom.Card(TitleLabel(
            "Настройки",
            icon: MdiIcons.settingsOutline,
            child: Column(children: [
              Divider(
                height: 5,
                color: Colors.transparent,
              ),
              SwitchLabel(
                "Перейти на тёмную сторону",
                description: "Активировать тёмную тему",
                icon: MdiIcons.weatherNight,
                value: Theme.of(context).brightness == Brightness.dark,
                onChanged: (isOn) {
                  changeTheme(isOn);
                },
              ),
              Divider(height: 5),
              ButtonLabel("Сбросить настройки",
                  description: "После сброса запустите приложение снова.",
                  icon: Icons.settings_backup_restore,
                  onPressed: () =>
                      ScopedModel.of<DataModel>(context).clearStorage())
            ]),
          )),
          custom.Card(
            TitleLabel(
              "Разработчики",
              icon: Icons.code,
              child: Column(
                children: [
                  InfoLabel("Семён Бутенко",
                      description: "Разработчик, дизайнер.")
                ],
              ),
            ),
          ),
          custom.Card(
            TitleLabel(
              "Мы в социальных сетях",
              icon: MdiIcons.accountMultipleOutline,
              child: Opacity(
                opacity: 0.8,
                child: Padding(
                  padding: EdgeInsets.fromLTRB(5, 10, 5, 5),
                  child: Row(children: [
                    custom.IconButton.url(
                        MdiIcons.vkCircle, "https://vk.com/onelab"),
                    custom.IconButton.url(MdiIcons.githubCircle,
                        "https://github.com/oneLab-Projects"),
                    custom.IconButton.url(
                        MdiIcons.dribbble, "https://dribbble.com/Laim0n"),
                  ]),
                ),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.all(12),
            child: Text(
              "с любовью, команда oneLab.",
              style: TextStyle(
                fontSize: 12.2,
                fontWeight: FontWeight.w400,
                color: Colors.grey[400],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
