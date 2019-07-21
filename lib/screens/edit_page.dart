import 'package:construct_diet/common/buttons.dart' as custom;
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
                constraints: MediaQuery.of(context).size.width > 780
                    ? BoxConstraints(maxWidth: 500)
                    : BoxConstraints(),
                height: 200,
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
                        padding: EdgeInsets.fromLTRB(0, 15, 0, 5),
                        child: Text(
                          title,
                          style: TextStyle(
                            fontSize: 17,
                            fontWeight: FontWeight.w500,
                            color: Theme.of(context).textTheme.caption.color,
                          ),
                        ),
                      ),
                      Expanded(
                        child: Stack(
                          children: <Widget>[
                            CupertinoPicker(
                              diameterRatio: 10,
                              magnification: 0.7,
                              scrollController: scrollController,
                              itemExtent: 68,
                              backgroundColor:
                                  Theme.of(context).bottomAppBarColor,
                              onSelectedItemChanged: (int index) {
                                setState(() => setter(list[index], index));
                              },
                              children: List<Widget>.generate(
                                list.length,
                                (int index) {
                                  return Padding(
                                    padding: EdgeInsets.only(
                                        right: postfix != null
                                            ? ((MediaQuery.of(context)
                                                                .size
                                                                .width >
                                                            770
                                                        ? 500
                                                        : MediaQuery.of(context)
                                                            .size
                                                            .width) /
                                                    2 +
                                                1.6)
                                            : 0),
                                    child: Align(
                                      alignment: postfix != null
                                          ? Alignment.centerRight
                                          : Alignment.center,
                                      child: Text(
                                        "${list[index]}",
                                        style: TextStyle(
                                          fontSize: 17,
                                          fontWeight: FontWeight.w500,
                                          color: Theme.of(context).primaryColor,
                                        ),
                                      ),
                                    ),
                                  );
                                },
                              ),
                            ),
                            postfix != null
                                ? Padding(
                                    padding: EdgeInsets.only(
                                        left: ((MediaQuery.of(context)
                                                            .size
                                                            .width >
                                                        780
                                                    ? 500
                                                    : MediaQuery.of(context)
                                                        .size
                                                        .width) /
                                                2) +
                                            1.6),
                                    child: Align(
                                        alignment: Alignment.centerLeft,
                                        child: Text(
                                          postfix,
                                          style: TextStyle(
                                            fontSize: 17,
                                            fontWeight: FontWeight.w500,
                                            color:
                                                Theme.of(context).primaryColor,
                                          ),
                                        )),
                                  )
                                : Container(),
                            IgnorePointer(
                              ignoring: true,
                              child: Center(
                                child: Container(
                                  height: 48.7,
                                  decoration: BoxDecoration(
                                    border: Border(
                                      top: BorderSide(
                                          width: 1,
                                          color: Theme.of(context).cardColor),
                                      bottom: BorderSide(
                                          width: 1,
                                          color: Theme.of(context).cardColor),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.fromLTRB(0, 5, 0, 0),
                        child: Divider(height: 1),
                      ),
                    ],
                  ),
                ),
              );
            }).then((s) => ScopedModel.of<DataModel>(context).save());
      },
    );
  }

  Widget appBar() {
    return Padding(
      padding: EdgeInsets.fromLTRB(4, 12, 4, 14),
      child: Hero(
        tag: 'appbar',
        child: Material(
          elevation: 2,
          shadowColor: Colors.black.withAlpha(100),
          borderRadius: BorderRadius.all(Radius.circular(8.5)),
          color: Theme.of(context).cardColor,
          child: Padding(
            padding: EdgeInsets.fromLTRB(0, 2, 0, 2),
            child: Column(
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.fromLTRB(8, 3, 15, 0),
                  child: Row(
                    children: <Widget>[
                      custom.IconButton(
                        icon: Icon(
                          Icons.arrow_back,
                          size: 22,
                        ),
                        onPressed: () => Navigator.pop(context),
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
