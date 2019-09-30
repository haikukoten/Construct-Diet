import 'package:construct_diet/common/buttons.dart' as custom;
import 'package:construct_diet/common/labels.dart';
import 'package:construct_diet/common/screen_body.dart';
import 'package:construct_diet/common/split_column.dart';
import 'package:construct_diet/globalization/vocabulary.dart';
import 'package:construct_diet/scoped_models/data_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:scoped_model/scoped_model.dart';

class EditPage extends StatefulWidget {
  @override
  _EditPageState createState() => _EditPageState();
}

class _EditPageState extends State<EditPage> {
  List<int> ageList = [for (int i = 12; i <= 100; i++) i];
  List<String> genderList = <String>[
    Vocabluary.getWord('Female'),
    Vocabluary.getWord('Male')
  ];
  List<int> heightList = [for (int i = 100; i <= 250; i++) i];
  List<int> weightList = [for (int i = 30; i <= 250; i++) i];

  Widget buttonOpenPicker(String title, value, String postfix, int currentIndex,
      Function setter, List list) {
    final FixedExtentScrollController scrollController =
        FixedExtentScrollController(initialItem: currentIndex);
    return ButtonLabel(
      title,
      description:
          "${value ?? "Не указано"} ${postfix == null ? "" : (value == null ? "" : postfix)}",
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
                  child: DisplayLabel(
                    title,
                    child: SizedBox(
                      height: 155,
                      child: Stack(
                        children: <Widget>[
                          CupertinoPicker(
                            diameterRatio:
                                Theme.of(context).platform == TargetPlatform.iOS
                                    ? 1.3
                                    : 10,
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
                                      style: Theme.of(context).textTheme.button,
                                    ),
                                  ),
                                );
                              },
                            ),
                          ),
                          postfix != null
                              ? Padding(
                                  padding: EdgeInsets.only(
                                      left:
                                          ((MediaQuery.of(context).size.width >
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
                                        style:
                                            Theme.of(context).textTheme.button,
                                      )),
                                )
                              : Container(),
                          IgnorePointer(
                            ignoring: true,
                            child: Center(
                              child: Opacity(
                                opacity: Theme.of(context).platform ==
                                        TargetPlatform.iOS
                                    ? 0.8
                                    : 1,
                                child: Container(
                                  height: 48.7,
                                  decoration: BoxDecoration(
                                    border: Border(
                                      top: BorderSide(
                                          width: 1,
                                          color: Theme.of(context).platform ==
                                                  TargetPlatform.iOS
                                              ? Theme.of(context).dividerColor
                                              : Theme.of(context).cardColor),
                                      bottom: BorderSide(
                                          width: 1,
                                          color: Theme.of(context).platform ==
                                                  TargetPlatform.iOS
                                              ? Theme.of(context).dividerColor
                                              : Theme.of(context).cardColor),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              );
            }).then((s) => ScopedModel.of<DataModel>(context).save());
      },
    );
  }

  Widget appBar() {
    return Padding(
      padding: EdgeInsets.fromLTRB(12, 12, 12, 14),
      child: Hero(
        tag: 'appbar',
        child: Material(
          elevation: 2,
          shadowColor: Colors.black.withAlpha(100),
          borderRadius: BorderRadius.all(Radius.circular(8.5)),
          color: Theme.of(context).cardColor,
          child: ListView(
            scrollDirection: Axis.vertical,
            addAutomaticKeepAlives: true,
            shrinkWrap: true,
            children: <Widget>[
              Container(
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    custom.IconButton(
                      icon: Theme.of(context).platform == TargetPlatform.iOS
                          ? Icons.arrow_back_ios
                          : Icons.arrow_back,
                      iconSize: Theme.of(context).platform == TargetPlatform.iOS
                          ? 18
                          : 22,
                      onPressed: () => Navigator.pop(context),
                    ),
                    Padding(
                      padding: EdgeInsets.all(0.0),
                      child: Text(
                        Vocabluary.getWord('Body parameters'),
                        style: Theme.of(context).textTheme.caption,
                      ),
                    ),
                  ],
                ),
              ),
              ScopedModelDescendant<DataModel>(
                  builder: (context, child, model) {
                return SplitColumn(
                  children: <Widget>[
                    buttonOpenPicker(
                        Vocabluary.getWord('Gender'),
                        model.isWoman
                            ? Vocabluary.getWord('Female')
                            : Vocabluary.getWord('Male'),
                        null,
                        model.genderIndex,
                        model.setGender,
                        genderList),
                    buttonOpenPicker(
                        Vocabluary.getWord('Age'),
                        model.age,
                        Vocabluary.getWord('years old'),
                        model.ageIndex,
                        model.setAge,
                        ageList),
                    buttonOpenPicker(
                        Vocabluary.getWord('Height'),
                        model.height,
                        Vocabluary.getWord('cm'),
                        model.heightIndex,
                        model.setHeight,
                        heightList),
                    buttonOpenPicker(
                        Vocabluary.getWord('Weight'),
                        model.weight,
                        Vocabluary.getWord('kg'),
                        model.weightIndex,
                        model.setWeight,
                        weightList),
                  ],
                );
              }),
            ],
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
