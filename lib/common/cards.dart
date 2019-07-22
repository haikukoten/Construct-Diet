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
    );
  }
}
