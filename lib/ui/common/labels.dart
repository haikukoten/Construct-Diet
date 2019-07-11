import 'package:flutter/material.dart';

class InfoLabel extends StatelessWidget {
  final String title;
  final String description;
  final IconData icon;

  InfoLabel(this.title, [this.description, this.icon]);

  @override
  Widget build(BuildContext context) {
    return Row(
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
                            .withAlpha(180),
                      ),
                    ),
                  )
                : Container()
          ]),
        ),
      ],
    );
  }
}

class PlugLabel extends StatelessWidget {
  final String title;
  final String description;
  final IconData icon;

  PlugLabel(this.title, [this.description, this.icon]);

  @override
  Widget build(BuildContext context) {
    return Container(
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
                            .withAlpha(180),
                      ),
                    ),
                  )
                : Container()
          ]),
        ],
      ),
    );
  }
}

class TitleLabel extends StatelessWidget {
  final String title;
  final IconData icon;
  final Widget child;

  TitleLabel(this.title, this.icon, this.child);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.only(bottom: 10),
          child: Row(
            children: <Widget>[
              Container(
                  margin: EdgeInsets.only(right: 14.4),
                  child: Icon(
                    icon,
                    size: 20,
                    color: Theme.of(context)
                        .textTheme
                        .caption
                        .color
                        .withAlpha(180),
                  )),
              Text(
                title,
                style: TextStyle(
                  fontSize: 12.8,
                  color:
                      Theme.of(context).textTheme.caption.color.withAlpha(180),
                ),
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(bottom: 4),
          child: child,
        )
      ],
    );
  }
}
