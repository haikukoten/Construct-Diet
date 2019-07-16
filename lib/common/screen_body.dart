import 'package:flutter/material.dart';

class ScreenBody extends StatelessWidget {
  final Widget child;
  ScreenBody(this.child);

  @override
  Widget build(BuildContext context) {
    final double statusBarHeight = MediaQuery.of(context).padding.top;
    return Scaffold(
      body: SizedBox(
        height: MediaQuery.of(context).size.height,
        child: Padding(
          padding: EdgeInsets.only(top: statusBarHeight),
          child: SingleChildScrollView(
            padding: EdgeInsets.fromLTRB(16, 0, 16, 0),
            child: ConstrainedBox(constraints: BoxConstraints(), child: child),
          ),
        ),
      ),
    );
  }
}
