import 'package:flutter/material.dart';

class Card extends StatelessWidget {
  final Widget child;

  Card(this.child);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.fromLTRB(0, 5, 0, 5),
      constraints: BoxConstraints(minHeight: 70),
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        border: Border.all(color: Theme.of(context).dividerColor),
        borderRadius: BorderRadius.all(Radius.circular(10)),
      ),
      child: Material(
        color: Colors.transparent,
        child: Center(child: child),
      ),
    );
  }
}

class Tip extends StatelessWidget {
  final Widget child;

  Tip(this.child);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Container(
          padding: EdgeInsets.fromLTRB(10, 9, 10, 9),
          margin: EdgeInsets.only(bottom: 18),
          constraints: BoxConstraints(maxWidth: 230),
          decoration: BoxDecoration(
            color: Theme.of(context).primaryColor,
            border: Border.all(color: Theme.of(context).primaryColor),
            borderRadius: BorderRadius.all(Radius.circular(10)),
          ),
          child: Material(
            color: Colors.transparent,
            child: Center(child: child),
          ),
        ),
        Positioned(
          bottom: 0,
          left: 90,
          child: SizedBox(
            width: 15,
            height: 15,
            child: Material(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(50.0),
                  side: BorderSide(
                      width: 3,
                      color: Theme.of(context)
                          .scaffoldBackgroundColor
                          .withAlpha(200))),
              color: Theme.of(context).primaryColor.withAlpha(250),
            ),
          ),
        ),
      ],
    );
  }
}
