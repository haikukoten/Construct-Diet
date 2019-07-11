import 'package:flutter/widgets.dart';

class TabContent extends StatelessWidget {
  final String title;
  final IconData icon;
  TabContent(this.title, this.icon);

  @override
  Widget build(BuildContext context) {
    return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Container(
            child: Icon(icon),
            margin: const EdgeInsets.only(bottom: 4),
          ),
          Text(title),
        ]);
  }
}
