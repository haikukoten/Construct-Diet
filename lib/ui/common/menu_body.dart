import 'package:flutter/material.dart';

class MenuBody extends StatelessWidget {
  MenuBody({Key key, this.child}) : super(key: key);
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(child: child),
    );
  }
}
