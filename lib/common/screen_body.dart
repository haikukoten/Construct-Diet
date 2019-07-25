import 'package:flutter/material.dart';

class ScreenBody extends StatelessWidget {
  final Widget child;
  ScreenBody(this.child);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        height: MediaQuery.of(context).size.height,
        child: Padding(
          padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top),
          child: Align(
            alignment: Alignment.topCenter,
            child: SingleChildScrollView(
              padding: EdgeInsets.fromLTRB(12, 0, 12, 0),
              child: ConstrainedBox(
                constraints: MediaQuery.of(context).size.width > 780
                    ? BoxConstraints(maxWidth: 730)
                    : BoxConstraints(),
                child: child,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
