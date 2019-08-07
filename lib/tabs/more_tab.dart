import 'package:construct_diet/common/buttons.dart' as custom;
import 'package:construct_diet/common/cards.dart' as custom;
import 'package:construct_diet/common/labels.dart';
import 'package:construct_diet/common/tab_body.dart';
import 'package:construct_diet/scoped_models/data_model.dart';
import 'package:construct_diet/theme.dart' as custom;
import 'package:dynamic_theme/dynamic_theme.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:package_info/package_info.dart';
import 'package:scoped_model/scoped_model.dart';

class MoreTab extends StatefulWidget {
  @override
  _MoreTabState createState() => _MoreTabState();
}

class _MoreTabState extends State<MoreTab> {
  String version = "1.0.0";
  String buildNumber = "9";

  @override
  void initState() {
    super.initState();
    PackageInfo.fromPlatform().then((PackageInfo packageInfo) {
      version = packageInfo.version;
      buildNumber = packageInfo.buildNumber;
    });
  }

  void changeTheme(bool isNight) {
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(
          statusBarColor: Colors.white.withAlpha(0),
          statusBarIconBrightness:
              !isNight ? Brightness.dark : Brightness.light,
          systemNavigationBarColor: !isNight ? Colors.white : Color(0xFF2E2F32),
          systemNavigationBarIconBrightness:
              !isNight ? Brightness.dark : Brightness.light),
    );
    if (Theme.of(context).platform == TargetPlatform.iOS) {
      DynamicTheme.of(context)
          .setThemeData(isNight ? custom.ThemeIOS.dark : custom.ThemeIOS.light);
    } else {
      DynamicTheme.of(context).setThemeData(
          isNight ? custom.ThemeAndroid.dark : custom.ThemeAndroid.light);
    }
  }

  void changePlatform(bool isIOS) {
    if (isIOS) {
      DynamicTheme.of(context).setThemeData(
          Theme.of(context).brightness == Brightness.dark
              ? custom.ThemeIOS.dark
              : custom.ThemeIOS.light);
    } else {
      DynamicTheme.of(context).setThemeData(
          Theme.of(context).brightness == Brightness.dark
              ? custom.ThemeAndroid.dark
              : custom.ThemeAndroid.light);
    }
  }

  @override
  Widget build(BuildContext context) {
    return TabBody(
      Column(
        children: [
          custom.Card(
            GestureDetector(
              onLongPress: () {
                showCupertinoModalPopup<void>(
                    context: context,
                    builder: (BuildContext context) {
                      return Container(
                        constraints: MediaQuery.of(context).size.width > 780
                            ? BoxConstraints(maxWidth: 500)
                            : BoxConstraints(),
                        height: 126,
                        margin: EdgeInsets.fromLTRB(8, 8, 8, 4),
                        child: custom.Card(
                          DisplayLabel(
                            "Меню разработчика",
                            child: Padding(
                              padding: EdgeInsets.only(top: 4),
                              child: Column(
                                children: <Widget>[
                                  SwitchLabel(
                                    "Использовать интерфейс для iOS",
                                    description:
                                        "Влияет на внешность компонентов",
                                    icon: Icons.phone_iphone,
                                    value: Theme.of(context).platform ==
                                        TargetPlatform.iOS,
                                    onChanged: (isOn) {
                                      changePlatform(isOn);
                                    },
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      );
                    });
              },
              child: Material(
                color: Colors.transparent,
                child: InfoLabel("Construct Diet",
                    description: "Версия: $version (сборка $buildNumber)",
                    icon: MdiIcons.featureSearch),
              ),
            ),
          ),
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
              ButtonLabel(
                "Сбросить настройки",
                description: "После сброса запустите приложение снова.",
                icon: Icons.settings_backup_restore,
                onPressed: () => ScopedModel.of<DataModel>(context)
                    .clearStorage()
                    .then((s) => SystemChannels.platform
                        .invokeMethod('SystemNavigator.pop')),
              )
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
                  padding: EdgeInsets.fromLTRB(7, 10, 5, 5),
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
            child: Opacity(
              opacity: 0.8,
              child: Text(
                "с любовью, команда oneLab.",
                style: Theme.of(context).textTheme.subtitle,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
