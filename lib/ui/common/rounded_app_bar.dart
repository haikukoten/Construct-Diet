import 'package:flare_flutter/flare_actor.dart';
import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

import 'transparent_button.dart';

class RoundedAppBar extends StatefulWidget {
  @override
  _RoundedAppBarState createState() => _RoundedAppBarState();
}

class _RoundedAppBarState extends State<RoundedAppBar> {
  String currentAnimation;

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
            animation: currentAnimation,
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
                          tooltip: "Анимация перехода в About",
                          color: Theme.of(context).bottomAppBarColor,
                          icon: Icon(MdiIcons.informationOutline, size: 20),
                          onPressed: () {
                            setState(() {
                              currentAnimation = "startRectState";
                            });
                          }),
                      Padding(
                        padding: const EdgeInsets.only(top: 1),
                        child: Text(
                          "Construct Diet",
                          style: TextStyle(
                              fontSize: 19,
                              fontWeight: FontWeight.w400,
                              color: Theme.of(context).bottomAppBarColor),
                        ),
                      ),
                      IconButton(
                          tooltip: "Сброс анимации",
                          color: Theme.of(context).bottomAppBarColor,
                          icon: Icon(MdiIcons.restart, size: 20),
                          onPressed: () {
                            setState(() {
                              currentAnimation == "open"
                                  ? currentAnimation = "close"
                                  : currentAnimation == "startRectState"
                                      ? currentAnimation = "endRectState"
                                      : currentAnimation = "";
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
                          currentAnimation = "open";
                        });
                      },
                      child: Column(
                        textDirection: TextDirection.ltr,
                        children: <Widget>[
                          Text("мужчина, 16 лет, 182 см, 66 кг, нормостеник",
                              style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w400,
                                  color: Theme.of(context).bottomAppBarColor)),
                          Padding(
                            padding: EdgeInsets.only(top: 3),
                            child: Text("нажмите для редактирования",
                                style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w400,
                                    color:
                                        Theme.of(context).bottomAppBarColor)),
                          ),
                        ],
                      )),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
