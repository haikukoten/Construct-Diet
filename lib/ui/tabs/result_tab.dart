import 'package:flutter/material.dart';

class ResultTab extends StatefulWidget {
  @override
  _ResultTabState createState() => _ResultTabState();
}

class _ResultTabState extends State<ResultTab> {
  Widget block(int index) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text("хуй намбар " + index.toString(),
              style: TextStyle(
                fontSize: 15.0,
                fontWeight: FontWeight.w400,
                color: Theme.of(context).textTheme.caption.color,
              )),
          Text("хуй хуй ?",
              style: TextStyle(
                fontSize: 13.0,
                fontWeight: FontWeight.w400,
                color: Theme.of(context).textTheme.caption.color.withAlpha(200),
              )),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: BouncingScrollPhysics(),
      child: new ConstrainedBox(
        constraints: new BoxConstraints(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: List.generate(
            100,
            (int index) {
              return block(index);
            },
          ),
        ),
      ),
    );
  }
}
