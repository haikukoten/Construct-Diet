import 'package:construct_diet/common/labels.dart';
import 'package:construct_diet/common/screen_body.dart';
import 'package:construct_diet/scoped_models/data_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

class EditPage extends StatefulWidget {
  @override
  _EditPageState createState() => _EditPageState();
}

class _EditPageState extends State<EditPage> {
  List<int> ageList = [for (int i = 12; i <= 100; i++) i];
  List<String> genderList = <String>['женский', 'мужской'];
  List<int> heightList = [for (int i = 100; i <= 250; i++) i];
  List<int> weightList = [for (int i = 30; i <= 300; i++) i];
  List<int> wristWomanList = [for (int i = 14; i <= 18; i++) i];
  List<int> wristManList = [for (int i = 17; i <= 21; i++) i];

  Widget buttonOpenPicker(String title, value, String postfix, int currentIndex,
      Function setter, List list) {
    final FixedExtentScrollController scrollController =
        FixedExtentScrollController(initialItem: currentIndex);
    return ButtonLabel(
      title,
      description:
          "${value == null ? "Не указано" : value} ${postfix == null ? "" : (value == null ? "" : postfix)}",
      onPressed: () async {
        await showCupertinoModalPopup<void>(
            context: context,
            builder: (BuildContext context) {
              return Container(
                height: 250,
                decoration: BoxDecoration(
                  color: Theme.of(context).bottomAppBarColor,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withAlpha(15),
                      blurRadius: 3,
                    ),
                  ],
                  borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
                ),
                child: Material(
                  clipBehavior: Clip.hardEdge,
                  borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
                  type: MaterialType.transparency,
                  child: Column(
                    children: <Widget>[
                      Padding(
                        padding: EdgeInsets.all(15),
                        child: Text(
                          title,
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w500,
                            color: Theme.of(context).textTheme.caption.color,
                          ),
                        ),
                      ),
                      Expanded(
                        child: CupertinoPicker(
                          scrollController: scrollController,
                          itemExtent: 52,
                          backgroundColor: Theme.of(context).bottomAppBarColor,
                          onSelectedItemChanged: (int index) {
                            setState(() => setter(list[index], index));
                          },
                          children:
                              List<Widget>.generate(list.length, (int index) {
                            return Center(
                              child: Text(
                                  "${list[index]} ${postfix == null ? "" : postfix}"),
                            );
                          }),
                        ),
                      ),
                      Divider(height: 1),
                    ],
                  ),
                ),
              );
            });
      },
    );
  }

  Widget appBar() {
    return Padding(
      padding: EdgeInsets.fromLTRB(0, 8, 0, 10),
      child: Hero(
        tag: 'appbar',
        child: Material(
          elevation: 2,
          shadowColor: Colors.black.withAlpha(100),
          borderRadius: BorderRadius.all(Radius.circular(8.5)),
          color: Theme.of(context).cardColor,
          child: Padding(
            padding: EdgeInsets.fromLTRB(5, 2, 5, 2),
            child: Column(
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.fromLTRB(3, 3, 15, 0),
                  child: Row(
                    children: <Widget>[
                      SizedBox(
                        width: 40,
                        height: 40,
                        child: InkWell(
                          highlightColor: Colors.grey.withAlpha(50),
                          splashColor: Colors.grey.withAlpha(50),
                          borderRadius: BorderRadius.all(Radius.circular(50)),
                          child: Icon(
                            Icons.arrow_back,
                            size: 22,
                          ),
                          onTap: () {
                            Navigator.pop(context);
                          },
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.fromLTRB(8, 0, 0, 0.5),
                        child: Text(
                          "Параметры тела",
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w500,
                            color: Theme.of(context).textTheme.caption.color,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                ScopedModelDescendant<DataModel>(
                    builder: (context, child, model) {
                  return Column(
                    children: <Widget>[
                      buttonOpenPicker(
                          "Пол",
                          model.isWoman ? "Женский" : "Мужской",
                          null,
                          model.genderIndex,
                          model.setGender,
                          genderList),
                      buttonOpenPicker("Возраст", model.age, "лет",
                          model.ageIndex, model.setAge, ageList),
                      buttonOpenPicker("Рост", model.height, "см",
                          model.heightIndex, model.setHeight, heightList),
                      buttonOpenPicker("Вес", model.weight, "кг",
                          model.weightIndex, model.setWeight, weightList),
                      buttonOpenPicker(
                          "Обхват запястья",
                          model.wrist,
                          "см",
                          model.wristIndex,
                          model.setWrist,
                          model.isWoman ? wristWomanList : wristManList),
                    ],
                  );
                }),
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ScreenBody(appBar());
  }
}
