import 'package:construct_diet/common/labels.dart';
import 'package:construct_diet/globalization/vocabulary.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

Future<String> showDialog<String>(String title,
    {@required BuildContext context,
    String description,
    List<Widget> actions}) {
  return showCupertinoDialog<String>(
      context: context,
      builder: (BuildContext context) =>
          Dialog(title, description: description, actions: actions));
}

Future<String> showSelectionDialog<String>(
    {@required BuildContext context, List<Widget> actions}) {
  return showCupertinoDialog<String>(
      context: context,
      builder: (BuildContext context) => SelectionDialog(actions: actions));
}

class Dialog extends StatelessWidget {
  final dynamic title;
  final dynamic description;
  final List<Widget> actions;
  Dialog(this.title, {this.description, this.actions});

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
              Padding(
                padding: EdgeInsets.only(top: 14),
                child: Text(
                  title,
                  textAlign: TextAlign.center,
                  style: Theme.of(context)
                      .textTheme
                      .title
                      .copyWith(fontSize: 15.5),
                ),
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(15, 8, 15, 12),
                child: Text(
                  description,
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.subtitle,
                ),
              ),
              Divider(height: 1),
              Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: actions),
            ],
          ),
        ),
      ),
    );
  }
}

class SelectionDialog extends StatelessWidget {
  final List<Widget> actions;
  SelectionDialog({this.actions});

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
              Flexible(
                child: SingleChildScrollView(
                  child: Column(children: actions),
                ),
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
