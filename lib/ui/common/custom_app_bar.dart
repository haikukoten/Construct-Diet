import 'package:flare_flutter/flare_actor.dart';
import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

import 'transparent_button.dart';

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
    return Container(
      width: contentWidth,
      height: 340,
      child: Stack(
        children: <Widget>[
          FlareActor(
            "assets/app_bar_animations.flr",
            animation: animationName,
            fit: BoxFit.fitHeight,
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(3, statusBarHeight + 5, 3, 22),
            child: Column(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(top: 1),
                  child: Row(
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
                      Text("Construct Diet",
                          style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w600,
                              color: Theme.of(context).bottomAppBarColor)),
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
                ),
                Padding(
                  padding: EdgeInsets.only(top: 4),
                  child: TransparentButton(
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
                                    color:
                                        Theme.of(context).bottomAppBarColor)),
                          )
                        ],
                      )),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
