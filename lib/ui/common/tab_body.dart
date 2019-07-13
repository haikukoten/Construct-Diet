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
    return SingleChildScrollView(
      padding: EdgeInsets.fromLTRB(16, 0, 16, 0),
      child: ConstrainedBox(constraints: BoxConstraints(), child: child),
    );
  }
}
