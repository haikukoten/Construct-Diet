import 'package:flutter/material.dart';

class MenuBody extends StatelessWidget {
  MenuBody({Key key, this.child}) : super(key: key);
  final Widget child;

  @override
  Widget build(BuildContext context) {
    final statusBarHeight = MediaQuery.of(context).padding.top;
    return Scaffold(
      body: Container(
        padding: EdgeInsets.only(top: statusBarHeight),
        child: Column(
          children: <Widget>[
            Container(
              height: 55,
              decoration: new BoxDecoration(
                  color: Theme.of(context).bottomAppBarColor,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black38,
                      blurRadius: 5,
                    ),
                  ],
                  borderRadius:
                      BorderRadius.vertical(bottom: Radius.circular(10))),
            ),
            Container(child: child),
          ],
        ),
      ),
    );
  }
}
