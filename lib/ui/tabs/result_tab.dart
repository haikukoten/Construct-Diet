import 'package:construct_diet/ui/common/cards.dart' as custom;
import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class ResultTab extends StatefulWidget {
  @override
  _ResultTabState createState() => _ResultTabState();
}

class _ResultTabState extends State<ResultTab> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.fromLTRB(16, 0, 16, 0),
      physics: BouncingScrollPhysics(),
      child: new ConstrainedBox(
        constraints: new BoxConstraints(),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          custom.CardInformation(
              "Укажите свои параметры",
              "Нажмите на карточку выше для редактирования.",
              MdiIcons.creation),
          custom.CardPlug("Диеты не найдены", "Нет необходимости в похудении.",
              MdiIcons.magnify)
        ]),
      ),
    );
  }
}
