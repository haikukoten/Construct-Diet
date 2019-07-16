import 'package:construct_diet/common/cards.dart' as custom;
import 'package:construct_diet/common/labels.dart';
import 'package:construct_diet/common/tab_body.dart';
import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class ResultTab extends StatefulWidget {
  @override
  _ResultTabState createState() => _ResultTabState();
}

class _ResultTabState extends State<ResultTab> {
  @override
  Widget build(BuildContext context) {
    return TabBody(
      Column(children: [
        /*custom.Card(
          TitleLabel(
            "Сведения о здоровье",
            icon: Icons.info_outline,
            child: Column(children: [
              Divider(
                height: 5,
                color: Colors.transparent,
              ),
              InfoLabel("Индекс массы тела", description: "24.75"),
              InfoLabel("Допустимый вес", description: "от 62 кг до 77 кг"),
              InfoLabel("Избыточный вес", description: "3 кг")
            ]),
          ),
        ),*/
        custom.Card(PlugLabel("Диеты не найдены",
            description: "Нет необходимости в похудении.",
            icon: MdiIcons.magnify)),
      ]),
    );
  }
}
