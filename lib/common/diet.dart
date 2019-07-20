import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class Diet {
  final String name;
  final List<int> category;
  final int duration;
  final int efficiency;
  final int calorific;
  int positiveIndex;

  final String description;
  final List<IconData> icons;

  Diet(this.name, this.category, this.duration, this.efficiency, this.calorific)
      : description = "-$efficiency кг за $duration дней, $calorific ккал",
        icons = List<IconData>.generate(category.length, (index) {
          Map<int, IconData> _iconList = {
            1: MdiIcons.sausage,
            2: MdiIcons.fish,
            3: MdiIcons.foodApple,
            4: MdiIcons.corn,
            5: MdiIcons.rice,
            9: MdiIcons.circleSlice8,
            7: MdiIcons.barley,
            8: MdiIcons.beer,
            10: MdiIcons.candycane
          };
          return _iconList[category[index]];
        }),
        positiveIndex = 0;
}
