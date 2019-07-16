import 'package:construct_diet/ui/common/cards.dart' as custom;
import 'package:construct_diet/ui/common/labels.dart';
import 'package:construct_diet/ui/common/tab_body.dart';
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
        custom.Card(InfoLabel("Укажите свои параметры",
            description: "Нажмите на карточку выше для редактирования.",
            icon: MdiIcons.creation)),
        custom.Card(PlugLabel("Диеты не найдены",
            description: "Нет необходимости в похудении.",
            icon: MdiIcons.magnify)),
      ]),
    );
  }
}
