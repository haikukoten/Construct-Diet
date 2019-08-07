import 'package:construct_diet/common/buttons.dart' as custom;
import 'package:construct_diet/common/cards.dart' as custom;
import 'package:construct_diet/common/diet.dart';
import 'package:construct_diet/common/labels.dart';
import 'package:construct_diet/common/screen_body.dart';
import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

class DietInfoPage extends StatelessWidget {
  final Diet diet;

  DietInfoPage(this.diet);

  final Map<IconData, String> descriptionList = {
    MdiIcons.sausage: "мясные продукты",
    MdiIcons.fish: "рыбные продукты",
    MdiIcons.foodApple: "фрукты",
    MdiIcons.corn: "овощи",
    MdiIcons.rice: "крупы",
    MdiIcons.circleSlice8: "цитрусовые",
    MdiIcons.barley: "содержит глютен",
    MdiIcons.beer: "содержит лактозу",
    MdiIcons.candycane: "содержит глюкозу"
  };

  Widget appBar(BuildContext context) {
    return Padding(
      padding: Theme.of(context).platform == TargetPlatform.iOS
          ? EdgeInsets.fromLTRB(0, 8, 0, 10)
          : EdgeInsets.all(12),
      child: Hero(
        tag: Theme.of(context).platform == TargetPlatform.iOS ? 's' : 'appbar',
        child: Material(
          elevation: 2,
          shadowColor: Theme.of(context).platform == TargetPlatform.iOS
              ? Colors.transparent
              : Colors.black.withAlpha(100),
          borderRadius: BorderRadius.all(Radius.circular(8.5)),
          color: Theme.of(context).platform == TargetPlatform.iOS
              ? Colors.transparent
              : Theme.of(context).cardColor,
          child: Padding(
            padding: EdgeInsets.fromLTRB(0, 2, 0, 2),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.fromLTRB(8, 3, 15, 0),
                  child: Row(
                    children: <Widget>[
                      custom.IconButton(
                        icon: Theme.of(context).platform == TargetPlatform.iOS
                            ? Icons.arrow_back_ios
                            : Icons.arrow_back,
                        iconSize:
                            Theme.of(context).platform == TargetPlatform.iOS
                                ? 18
                                : 22,
                        onPressed: () => Navigator.pop(context),
                      ),
                      Padding(
                        padding: EdgeInsets.fromLTRB(5, 0, 0, 0.5),
                        child: Text(
                          diet.name + " диета",
                          style: Theme.of(context).textTheme.caption,
                        ),
                      ),
                    ],
                  ),
                ),
                InfoLabel("${diet.positiveIndex}%",
                    description:
                        "Совпадение с вашими параметрами и предпочтениями",
                    icon: MdiIcons.starCircleOutline),
                InfoLabel("Эффективность диеты",
                    description:
                        "-${diet.efficiency} кг за ${diet.duration} дней",
                    icon: MdiIcons.playSpeed),
                InfoLabel("Калорийность диеты",
                    description: "${diet.calorific} ккал",
                    icon: MdiIcons.animationOutline),
                InfoLabel("Структура питания",
                    description: [
                      for (int i = 0; i < diet.icons.length; i++)
                        "- " + descriptionList[diet.icons[i]]
                    ].join("\n"),
                    icon: MdiIcons.fileDocumentBox),
                Divider(
                  height: 5,
                ),
                ButtonLabel(
                  "Подробная информация",
                  description: "Показать результаты поисковой системы",
                  onPressed: () {
                    launch(
                        "https://www.yandex.ru/search/?text=${diet.name}+диета");
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ScreenBody(
      appBar(context),
    );
  }
}
