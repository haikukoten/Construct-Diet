import 'package:construct_diet/ui/screens/settings_page.dart';
import 'package:flare_dart/actor.dart';
import 'package:flare_flutter/flare_actor.dart';
import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class CustomAppBar extends StatefulWidget {
  @override
  _CustomAppBarState createState() => _CustomAppBarState();
}

class _CustomAppBarState extends State<CustomAppBar> {
  String animationName;

  @override
  Widget build(BuildContext context) {
    final statusBarHeight = MediaQuery.of(context).padding.top;
    final contentWidth = MediaQuery.of(context).size.width;
    return Stack(
      children: <Widget>[
        Container(
          width: contentWidth,
          height: 340,
          child: FlareActor(
            "assets/app_bar_animations.flr",
            animation: animationName,
            fit: BoxFit.fitHeight,
          ),
        ),
        Padding(
          padding: EdgeInsets.fromLTRB(3, statusBarHeight + 5, 3, 22),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  IconButton(
                      tooltip: "Анимация перехода в настройки",
                      color: Theme.of(context).bottomAppBarColor,
                      icon: Icon(MdiIcons.settingsOutline, size: 20),
                      onPressed: () {
                        setState(() {
                          animationName = "startRectState";
                        });
                      }),
                  Padding(
                    padding: EdgeInsets.only(top: 1),
                    child: Text("Construct Diet",
                        style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w600,
                            color: Theme.of(context).bottomAppBarColor)),
                  ),
                  IconButton(
                      tooltip: "Сброс анимации",
                      color: Theme.of(context).bottomAppBarColor,
                      icon: Icon(MdiIcons.restart, size: 20),
                      onPressed: () {
                        setState(() {
                          animationName == "open"
                              ? animationName = "close"
                              : animationName == "startRectState"
                                  ? animationName = "endRectState"
                                  : animationName = "";
                        });
                      }),
                ],
              ),
              Padding(
                padding: EdgeInsets.only(top: 4),
                child: UIFlatButton(
                    onTap: () {
                      setState(() {
                        animationName = "open";
                      });
                    },
                    child: Column(
                      textDirection: TextDirection.ltr,
                      children: <Widget>[
                        Text("мужчина, 16 лет, 182 см, 66 кг, нормостеник",
                            style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                                color: Theme.of(context).bottomAppBarColor)),
                        Padding(
                          padding: EdgeInsets.only(top: 3),
                          child: Text("нажмите для редактирования",
                              style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500,
                                  color: Theme.of(context).bottomAppBarColor)),
                        )
                      ],
                    )),
              )
            ],
          ),
        ),
      ],
    );
  }
}

class UIFlatButton extends StatelessWidget {
  UIFlatButton({Key key, this.onTap, this.child}) : super(key: key);

  final VoidCallback onTap;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: onTap,
        child: Opacity(
          opacity: 0.95,
          child: Material(
            type: MaterialType.transparency,
            child: child,
          ),
        ));
  }
}
