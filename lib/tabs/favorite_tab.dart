import 'package:construct_diet/common/cards.dart' as custom;
import 'package:construct_diet/common/labels.dart';
import 'package:construct_diet/common/tab_body.dart';
import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class FavoritesTab extends StatefulWidget {
  @override
  _FavoritesTabState createState() => _FavoritesTabState();
}

class FavoriteFood {
  final int id;
  final String name;
  final IconData icon;
  int isLiked;

  FavoriteFood(this.id, this.name, this.icon, [this.isLiked = 0]);
}

class _FavoritesTabState extends State<FavoritesTab> {
  List<FavoriteFood> foodList = <FavoriteFood>[
    FavoriteFood(1, 'Мясные продукты', MdiIcons.sausage),
    FavoriteFood(2, 'Рыбные продукты', MdiIcons.fish),
    FavoriteFood(3, 'Фрукты', MdiIcons.foodApple),
    FavoriteFood(4, 'Овощи', MdiIcons.corn),
    FavoriteFood(5, 'Крупы', MdiIcons.rice),
    FavoriteFood(9, 'Цитрусовые', MdiIcons.circleSlice8),
    FavoriteFood(7, 'Глютен', MdiIcons.barley),
    FavoriteFood(8, 'Лактоза', MdiIcons.beer),
    FavoriteFood(10, 'Глюкоза', MdiIcons.candycane)
  ];

  @override
  Widget build(BuildContext context) {
    return TabBody(
      Column(children: [
        custom.Card(InfoLabel("Подбирайте диеты под свой вкус",
            description:
                "Выберите, какие продукты вы желаете видеть в диетах, а какие нужно отсеить из выдачи.",
            icon: MdiIcons.heart)),
        custom.Card(Column(
          children: List<Widget>.generate(foodList.length, (int i) {
            FavoriteFood food = foodList[i];
            return Column(
              children: <Widget>[
                i == 0
                    ? Container(
                        height: 1,
                      )
                    : Divider(
                        height: 0,
                      ),
                SelectFavoriteLabel(
                  food.name,
                  icon: food.icon,
                  isLiked: food.isLiked,
                  onChanged: (value) {
                    print(value);
                  },
                ),
              ],
            );
          }),
        ))
      ]),
    );
  }
}
