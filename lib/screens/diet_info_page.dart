import 'package:construct_diet/common/buttons.dart' as custom;
import 'package:construct_diet/common/cards.dart' as custom;
import 'package:construct_diet/common/diet.dart';
import 'package:construct_diet/common/labels.dart';
import 'package:construct_diet/common/screen_body.dart';
import 'package:construct_diet/globalization/vocabulary.dart';
import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

class DietInfoPage extends StatelessWidget {
  final Diet diet;

  DietInfoPage(this.diet);

  final Map<IconData, String> descriptionList = {
    MdiIcons.sausage: Vocabluary.getWord('List Meat products'),
    MdiIcons.fish: Vocabluary.getWord('List Fish products'),
    MdiIcons.foodApple: Vocabluary.getWord('List Fruit'),
    MdiIcons.corn: Vocabluary.getWord('List Vegetables'),
    MdiIcons.rice: Vocabluary.getWord('List Cereals'),
    MdiIcons.circleSlice8: Vocabluary.getWord('List Citrus'),
    MdiIcons.barley: Vocabluary.getWord('List Gluten'),
    MdiIcons.beer: Vocabluary.getWord('List Lactose'),
    MdiIcons.candycane: Vocabluary.getWord('List Glucose')
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
                          diet.name + ' ' + Vocabluary.getWord('diet'),
                          style: Theme.of(context).textTheme.caption,
                        ),
                      ),
                    ],
                  ),
                ),
                InfoLabel("${diet.positiveIndex}%",
                    description: Vocabluary.getWord('Match your preferences'),
                    icon: MdiIcons.starCircleOutline),
                InfoLabel(Vocabluary.getWord('Diet efficiency'),
                    description: '-${diet.efficiency} ' +
                        Vocabluary.getWord('kg in') +
                        ' ${diet.duration} ' +
                        Vocabluary.getWord('days'),
                    icon: MdiIcons.playSpeed),
                InfoLabel(Vocabluary.getWord('Calorie diet'),
                    description:
                        '${diet.calorific} ' + Vocabluary.getWord('kcal'),
                    icon: MdiIcons.animationOutline),
                InfoLabel(Vocabluary.getWord('Nutrition structure'),
                    description: [
                      for (int i = 0; i < diet.icons.length; i++)
                        "- " + descriptionList[diet.icons[i]]
                    ].join("\n"),
                    icon: MdiIcons.fileDocumentBox),
                Divider(
                  height: 5,
                ),
                ButtonLabel(
                  Vocabluary.getWord('More information about diet'),
                  description: Vocabluary.getWord('Show search engine results'),
                  onPressed: () {
                    launch('https://www.google.com/search?q=${diet.name}+' +
                        Vocabluary.getWord('diet'));
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
