import 'package:construct_diet/common/cards.dart' as custom;
import 'package:construct_diet/common/labels.dart';
import 'package:construct_diet/common/split_column.dart';
import 'package:construct_diet/common/tab_body.dart';
import 'package:construct_diet/globalization/vocabulary.dart';
import 'package:construct_diet/scoped_models/data_model.dart';
import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:scoped_model/scoped_model.dart';

class FavoritesTab extends StatefulWidget {
  @override
  _FavoritesTabState createState() => _FavoritesTabState();
}

class FavoriteFood {
  final int id;
  final String name;
  final IconData icon;

  FavoriteFood(this.id, this.name, this.icon);
}

class _FavoritesTabState extends State<FavoritesTab> {
  List<FavoriteFood> foodList = <FavoriteFood>[
    FavoriteFood(1, Vocabluary.getWord('Meat products'), MdiIcons.sausage),
    FavoriteFood(2, Vocabluary.getWord('Fish products'), MdiIcons.fish),
    FavoriteFood(3, Vocabluary.getWord('Fruit'), MdiIcons.foodApple),
    FavoriteFood(4, Vocabluary.getWord('Vegetables'), MdiIcons.corn),
    FavoriteFood(5, Vocabluary.getWord('Cereals'), MdiIcons.rice),
    FavoriteFood(9, Vocabluary.getWord('Citrus'), MdiIcons.circleSlice8),
    FavoriteFood(7, Vocabluary.getWord('Gluten'), MdiIcons.barley),
    FavoriteFood(8, Vocabluary.getWord('Lactose'), MdiIcons.beer),
    FavoriteFood(10, Vocabluary.getWord('Glucose'), MdiIcons.candycane)
  ];

  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant<DataModel>(builder: (context, child, model) {
      return TabBody(
        Column(children: [
          custom.Card(InfoLabel(
              Vocabluary.getWord('Choose diets to suit your taste'),
              description: Vocabluary.getWord(
                  'Choose which foods you want to see in your diets and which to remove from the diet.'),
              icon: MdiIcons.heart)),
          custom.Card(SplitColumn(
            children: List<Widget>.generate(foodList.length, (int i) {
              FavoriteFood food = foodList[i];
              return SelectFavoriteLabel(
                food.name,
                icon: food.icon,
                isLiked: model.getPositiveOrNegative(food.id),
                onChanged: (value) {
                  setState(() {
                    model.addFavorite(food.id, value);
                  });
                },
              );
            }),
          ))
        ]),
      );
    });
  }
}
