import 'package:flutter/material.dart';

class TabBody extends StatefulWidget {
  final Widget child;

  TabBody(this.child);
  @override
  _TabBodyState createState() => _TabBodyState(child);
}

class _TabBodyState extends State<TabBody> {
  final Widget child;

  _TabBodyState(this.child);

  @override
  Widget build(BuildContext context) {
    double padding = MediaQuery.of(context).size.width > 700
        ? MediaQuery.of(context).size.width * 0.05
        : 16;
    return SingleChildScrollView(
      padding: EdgeInsets.symmetric(horizontal: padding),
      child: child,
    );
  }
}
