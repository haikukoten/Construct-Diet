import 'package:construct_diet/ui/common/cards.dart' as custom;
import 'package:construct_diet/ui/common/labels.dart';
import 'package:construct_diet/ui/common/tab_body.dart';
import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class FavoritesTab extends StatefulWidget {
  @override
  _FavoritesTabState createState() => _FavoritesTabState();
}

class _FavoritesTabState extends State<FavoritesTab> {
  @override
  Widget build(BuildContext context) {
    return TabBody(
      Column(children: [
        custom.Card(InfoLabel(
            "Подбирайте диеты под свой вкус",
            "Выберите, какие продукты вы желаете видеть в диетах, а какие нужно отсеить из выдачи.",
            MdiIcons.heart)),
        custom.Card(PlugLabel(
            "Здесь ничего нет", "Раздел в разработке.", MdiIcons.help))
      ]),
    );
  }
}
