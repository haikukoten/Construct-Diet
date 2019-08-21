import 'package:construct_diet/common/buttons.dart' as custom;
import 'package:construct_diet/common/cards.dart' as custom;
import 'package:construct_diet/common/screen_body.dart';
import 'package:construct_diet/common/tab_body.dart';
import 'package:construct_diet/globalization/vocabulary.dart';
import 'package:flutter/material.dart';

class ContributorsPage extends StatelessWidget {
  Widget appBar(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(16),
      child: Hero(
        tag: 'appbar',
        child: Material(
          elevation: 2,
          shadowColor: Theme.of(context).platform == TargetPlatform.iOS
              ? Colors.transparent
              : Colors.black.withAlpha(100),
          borderRadius: BorderRadius.all(Radius.circular(8.5)),
          color: Theme.of(context).platform == TargetPlatform.iOS
              ? Colors.transparent
              : Theme.of(context).cardColor,
          child: Padding(
            padding: EdgeInsets.fromLTRB(8, 5, 15, 5),
            child: Center(
              child: Row(
                children: <Widget>[
                  custom.IconButton(
                    icon: Theme.of(context).platform == TargetPlatform.iOS
                        ? Icons.arrow_back_ios
                        : Icons.arrow_back,
                    iconSize: Theme.of(context).platform == TargetPlatform.iOS
                        ? 18
                        : 22,
                    onPressed: () => Navigator.pop(context),
                  ),
                  Padding(
                    padding: EdgeInsets.fromLTRB(5, 0, 0, 0),
                    child: Text(
                      Vocabluary.getWord('Project Contributors'),
                      style: Theme.of(context).textTheme.caption,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ScreenBody(
      Column(
        children: [
          appBar(context),
          TabBody(
            Text("хуй"),
          ),
        ],
      ),
    );
  }
}
