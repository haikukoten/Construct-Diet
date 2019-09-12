import 'package:flutter/material.dart';

class SplitColumn extends StatelessWidget {
  final List<Widget> children;
  SplitColumn({this.children});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: List.generate(
        children.length,
        (index) {
          return Column(
            children: <Widget>[
              children[index],
              index == children.length - 1 ? Container() : Divider(height: 0),
            ],
          );
        },
      ),
    );
  }
}
