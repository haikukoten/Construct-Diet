import 'package:construct_diet/common/cards.dart' as custom;
import 'package:construct_diet/common/labels.dart';
import 'package:construct_diet/common/tab_body.dart';
import 'package:construct_diet/globalization/vocabulary.dart';
import 'package:construct_diet/scoped_models/data_model.dart';
import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:scoped_model/scoped_model.dart';

class ResultTab extends StatefulWidget {
  @override
  _ResultTabState createState() => _ResultTabState();
}

class _ResultTabState extends State<ResultTab> {
  @override
  Widget build(BuildContext context) {
    ScopedModel.of<DataModel>(context, rebuildOnChange: true)
        .generateDietWidgetList();
    return TabBody(
      ScopedModelDescendant<DataModel>(builder: (context, child, model) {
        return Stack(
          children: <Widget>[
            Column(
              children: [
                model.isSet
                    ? custom.Card(
                        TitleLabel(
                          Vocabluary.getWord('Health information'),
                          icon: Icons.info_outline,
                          child: Column(children: [
                            Divider(
                              height: 5,
                              color: Colors.transparent,
                            ),
                            Column(
                              children: <Widget>[
                                InfoLabel(Vocabluary.getWord('Body mass index'),
                                    description: model.imt.toStringAsFixed(2)),
                                InfoLabel(Vocabluary.getWord('Allowable weight'),
                                    description:
                                        Vocabluary.getWord('LeftWModel') + '${model.minWeight}' + Vocabluary.getWord('MiddleWModel') +'${model.maxWeight}' + Vocabluary.getWord('MiddleRightWModel') + '${model.idealWeight}' + Vocabluary.getWord('RightWModel')),
                                InfoLabel(Vocabluary.getWord('Overweight'),
                                    description: model.overweight == 0
                                        ? Vocabluary.getWord('Missing')
                                        : (model.overweight.toString() + ' ' + Vocabluary.getWord('kg')))
                              ],
                            ),
                          ]),
                        ),
                      )
                    : Container(),
                custom.Card(
                  model.widgetGoodDiet == null
                      ? PlugLabel(Vocabluary.getWord('Diets not found'),
                          description: model.overweight < 4
                              ? Vocabluary.getWord('No need to lose weight')
                              : Vocabluary.getWord('Try changing the filter by preferences'),
                          icon: MdiIcons.cards)
                      : TitleLabel(
                          Vocabluary.getWord('The most appropriate diet'),
                          icon: MdiIcons.crown,
                          child: model.widgetGoodDiet,
                        ),
                ),
                model.widgetDietList.length != 0
                    ? custom.Card(TitleLabel(
                        Vocabluary.getWord('Diets'),
                        icon: MdiIcons.cardsOutline,
                        paddingBottom: 0,
                        child: Column(children: model.widgetDietList),
                      ))
                    : Container(),
              ],
            ),
            Visibility(
              visible: model.isSet &&
                  !model.isOpenedDiet &&
                  model.widgetGoodDiet != null,
              child: Positioned(
                top: 240,
                right: MediaQuery.of(context).size.width > 700 ? 150 : 5,
                child: custom.Tip(
                    Vocabluary.getWord('Click on the diet to show more information')),
              ),
            ),
          ],
        );
      }),
    );
  }
}
