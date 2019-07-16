import 'package:construct_diet/common/labels.dart';
import 'package:construct_diet/common/screen_body.dart';
import 'package:flutter/material.dart';

class EditPage extends StatefulWidget {
  @override
  _EditPageState createState() => _EditPageState();
}

class _EditPageState extends State<EditPage> {
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
                ButtonLabel(
                  "Пол",
                  description: "Женский",
                  onPressed: () {},
                ),
                ButtonLabel(
                  "Возраст",
                  description: "18 лет",
                  onPressed: () {},
                ),
                ButtonLabel(
                  "Рост",
                  description: "165 см",
                  onPressed: () {},
                ),
                ButtonLabel(
                  "Вес",
                  description: "80 кг",
                  onPressed: () {},
                ),
                ButtonLabel(
                  "Обхват запястья",
                  description: "Не указано",
                  onPressed: () {},
                ),
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
