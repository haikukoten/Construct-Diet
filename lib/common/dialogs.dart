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
        decoration: BoxDecoration(
          color: Theme.of(context).cardColor,
          border: Border.all(color: Theme.of(context).dividerColor),
          borderRadius: BorderRadius.all(Radius.circular(10)),
        ),
        child: Material(
          color: Colors.transparent,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: actions +
                [
                  Divider(height: 0),
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
