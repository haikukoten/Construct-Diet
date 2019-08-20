import 'package:construct_diet/common/labels.dart';
import 'package:construct_diet/globalization/vocabulary.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

Future<String> showDialog<String>(
    {@required BuildContext context, List<Widget> actions}) {
  return showCupertinoDialog<String>(
      context: context,
      builder: (BuildContext context) => Dialog(actions: actions));
}

class Dialog extends StatelessWidget {
  final List<Widget> actions;
  Dialog({this.actions});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: 270,
        constraints: BoxConstraints(maxHeight: 365),
        decoration: BoxDecoration(
          color: Theme.of(context).cardColor,
          borderRadius: BorderRadius.all(Radius.circular(10)),
          boxShadow: [
            BoxShadow(
                color: Colors.black.withOpacity(0.1),
                blurRadius: 8,
                offset: Offset(0, 3)),
          ],
        ),
        child: Material(
          color: Colors.transparent,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Expanded(
                child: ListView(children: actions, padding: EdgeInsets.zero),
              ),
              Divider(height: 1),
              DialogButtonLabel(
                Vocabluary.getWord('Cancel'),
                onPressed: () => Navigator.pop(context),
                color: Theme.of(context).errorColor,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
