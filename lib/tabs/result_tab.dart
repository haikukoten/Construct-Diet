import 'package:construct_diet/common/cards.dart' as custom;
import 'package:construct_diet/common/labels.dart';
import 'package:construct_diet/common/tab_body.dart';
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
    return TabBody(
      ScopedModelDescendant<DataModel>(builder: (context, child, model) {
        return Column(children: [
          model.isSet
              ? custom.Card(
                  TitleLabel(
                    "Сведения о здоровье",
                    icon: Icons.info_outline,
                    child: Column(children: [
                      Divider(
                        height: 5,
                        color: Colors.transparent,
                      ),
                      Column(
                        children: <Widget>[
                          InfoLabel("Индекс массы тела",
                              description: model.imt.toStringAsFixed(2)),
                          InfoLabel("Допустимый вес",
                              description:
                                  "от ${model.minWeight} кг до ${model.maxWeight} кг (идеально – ${model.idealWeight} кг)"),
                          InfoLabel("Избыточный вес",
                              description: model.overweight == 0
                                  ? 'Отсутствует'
                                  : (model.overweight.toString() + "кг"))
                        ],
                      ),
                    ]),
                  ),
                )
              : Container(),
          custom.Card(
            PlugLabel("Диеты не найдены",
                description: model.overweight < 4
                    ? "Нет необходимости в похудении."
                    : "Попробуйте изменить фильтр по предпочтениям.",
                icon: MdiIcons.magnify),
          ),
        ]);
      }),
    );
  }
}
