import 'package:construct_diet/ui/common/transparent_button.dart';
import 'package:flutter/material.dart';

class RoundedAppBar extends StatefulWidget {
  @override
  _RoundedAppBarState createState() => _RoundedAppBarState();
}

class _RoundedAppBarState extends State<RoundedAppBar> {
  @override
  Widget build(BuildContext context) {
    final statusBarHeight = MediaQuery.of(context).padding.top;
    final contentWidth = MediaQuery.of(context).size.width;
    return Container(
      width: contentWidth,
      height: 135,
      padding: EdgeInsets.only(top: statusBarHeight + 12, bottom: 12),
      decoration: new BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Colors.black26,
            blurRadius: 3,
          ),
        ],
        borderRadius: BorderRadius.vertical(bottom: Radius.elliptical(240, 20)),
        gradient: LinearGradient(colors: [
          Theme.of(context).brightness == Brightness.light
              ? Color(0xffF55B9A)
              : Color(0xff5bf5b6),
          Theme.of(context).brightness == Brightness.light
              ? Color(0xffF9B16E)
              : Color(0xff6eb6f9),
        ], begin: Alignment.centerLeft, end: Alignment.centerRight),
      ),
      child: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(6),
            child: Text(
              "Construct Diet",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w600,
                color: Theme.of(context).bottomAppBarColor,
              ),
            ),
          ),
          TransparentButton(
              child: Column(
            textDirection: TextDirection.ltr,
            children: <Widget>[
              Text(
                "мужчина, 16 лет, 182 см, 66 кг, нормостеник",
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color: Theme.of(context).bottomAppBarColor,
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: 3),
                child: Text(
                  "нажмите для редактирования",
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: Theme.of(context).bottomAppBarColor,
                  ),
                ),
              ),
            ],
          ))
        ],
      ),
    );
  }
}
