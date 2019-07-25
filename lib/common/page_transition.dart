import 'package:flutter/material.dart';

class TransitionPageRoute extends PageRouteBuilder {
  final Widget widget;
  TransitionPageRoute({this.widget})
      : super(
          pageBuilder: (BuildContext context, Animation<double> animation,
              Animation<double> secondaryAnimation) {
            return widget;
          },
          transitionsBuilder: (context, animation1, animation2, child) {
            return FadeTransition(
                opacity:
                    animation1.drive(Tween<double>(begin: 0.0, end: 1.0).chain(
                  CurveTween(curve: Interval(0.0, 0.5)),
                )),
                child: child);
          },
          transitionDuration: Duration(milliseconds: 400),
        );
}
