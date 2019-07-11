import 'package:flutter/material.dart';

class Card extends StatelessWidget {
  final Widget child;

  Card(this.child);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.fromLTRB(0, 5, 0, 5),
      constraints: BoxConstraints(minHeight: 70),
      padding: EdgeInsets.fromLTRB(18, 14.5, 18, 14.5),
      decoration: new BoxDecoration(
        color: Theme.of(context).cardColor,
        border: Border.all(color: Theme.of(context).dividerColor),
        borderRadius: BorderRadius.all(Radius.circular(10)),
      ),
      child: Center(child: child),
    );
  }
}

class CardInformation extends StatelessWidget {
  final String title;
  final String description;
  final IconData icon;

  CardInformation(this.title, [this.description, this.icon]);

  @override
  Widget build(BuildContext context) {
    return Card(Row(
      children: <Widget>[
        Container(
            margin: EdgeInsets.only(right: 15),
            child: Icon(
              icon,
              size: 20,
              color: Theme.of(context).primaryColor,
            )),
        Container(
          width: MediaQuery.of(context).size.width - 140,
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text(
              title,
              style: TextStyle(
                fontSize: description != null ? 15 : 15.5,
                fontWeight: FontWeight.w600,
                color: Theme.of(context).textTheme.caption.color,
              ),
            ),
            description != null
                ? Padding(
                    padding: EdgeInsets.only(top: 3.2),
                    child: Text(
                      description,
                      style: TextStyle(
                        fontSize: 12.2,
                        color: Theme.of(context)
                            .textTheme
                            .caption
                            .color
                            .withAlpha(200),
                      ),
                    ),
                  )
                : Container()
          ]),
        ),
      ],
    ));
  }
}

class CardPlug extends StatelessWidget {
  final String title;
  final String description;
  final IconData icon;

  CardPlug(this.title, [this.description, this.icon]);

  @override
  Widget build(BuildContext context) {
    return Card(Container(
      padding: EdgeInsets.fromLTRB(0, 8, 0, 8),
      child: Column(
        children: <Widget>[
          Container(
              margin: EdgeInsets.only(bottom: 15),
              child: Icon(
                icon,
                size: 40,
                color: Theme.of(context).primaryColor,
              )),
          Column(children: [
            Text(
              title,
              style: TextStyle(
                fontSize: description != null ? 15 : 15.5,
                fontWeight: FontWeight.w600,
                color: Theme.of(context).textTheme.caption.color,
              ),
            ),
            description != null
                ? Padding(
                    padding: EdgeInsets.only(top: 3.2),
                    child: Text(
                      description,
                      style: TextStyle(
                        fontSize: 12.2,
                        color: Theme.of(context)
                            .textTheme
                            .caption
                            .color
                            .withAlpha(200),
                      ),
                    ),
                  )
                : Container()
          ]),
        ],
      ),
    ));
  }
}
