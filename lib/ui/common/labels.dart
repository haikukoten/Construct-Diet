import 'package:flutter/material.dart';

class InfoLabel extends StatelessWidget {
  final String title;
  final String description;
  final IconData icon;

  InfoLabel(this.title, [this.description, this.icon]);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(10),
      child: Row(
        children: <Widget>[
          icon != null
              ? Container(
                  margin: EdgeInsets.only(right: 15),
                  child: Icon(
                    icon,
                    size: 20,
                    color: Theme.of(context).primaryColor,
                  ))
              : Container(),
          Container(
            width: MediaQuery.of(context).size.width - 140,
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text(
                title,
                strutStyle: StrutStyle(
                  leading: 0,
                ),
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
      ),
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
      padding: EdgeInsets.fromLTRB(10, 18, 10, 18),
      child: Column(
        children: <Widget>[
          icon != null
              ? Container(
                  margin: EdgeInsets.only(bottom: 15),
                  child: Icon(
                    icon,
                    size: 40,
                    color: Theme.of(context).primaryColor,
                  ))
              : Container(),
          Column(children: [
            Text(
              title,
              strutStyle: StrutStyle(
                leading: 0,
              ),
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

  TitleLabel(this.title, {this.icon, this.child});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
          child: Row(
            children: <Widget>[
              icon != null
                  ? Container(
                      margin: EdgeInsets.only(right: 15),
                      child: Icon(
                        icon,
                        size: 16.5,
                        color: Theme.of(context)
                            .textTheme
                            .caption
                            .color
                            .withAlpha(180),
                      ))
                  : Container(),
              Text(
                title,
                strutStyle: StrutStyle(
                  leading: 0,
                ),
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
        ),
      ],
    );
  }
}

class InfoSwitchLabel extends StatefulWidget {
  final String title;
  final String description;
  final IconData icon;
  final bool value;
  final ValueChanged<bool> onChanged;

  InfoSwitchLabel(this.title, this.description, this.icon,
      {this.value, this.onChanged});

  @override
  _InfoSwitchLabelState createState() => _InfoSwitchLabelState(
      this.title, this.description, this.icon, this.value, this.onChanged);
}

class _InfoSwitchLabelState extends State<InfoSwitchLabel> {
  String title;
  String description;
  IconData icon;
  bool value;
  ValueChanged<bool> onChanged;

  _InfoSwitchLabelState(
      this.title, this.description, this.icon, this.value, this.onChanged);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(0, 5, 0, 0),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          highlightColor: Colors.grey.withAlpha(30),
          splashColor: Colors.grey.withAlpha(30),
          onTap: () {
            setState(() {
              value = !value;
            });
            onChanged(value);
          },
          borderRadius: BorderRadius.all(Radius.circular(5)),
          child: Padding(
            padding: EdgeInsets.fromLTRB(10, 10, 0, 10),
            child: Stack(
              alignment: Alignment.center,
              children: <Widget>[
                Row(
                  children: <Widget>[
                    widget.icon != null
                        ? Container(
                            margin: EdgeInsets.only(right: 15),
                            child: Icon(
                              widget.icon,
                              size: 20,
                              color: Theme.of(context).primaryColor,
                            ))
                        : Container(),
                    Container(
                      width: MediaQuery.of(context).size.width - 164,
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              widget.title,
                              style: TextStyle(
                                fontSize:
                                    widget.description != null ? 15 : 15.5,
                                fontWeight: FontWeight.w600,
                                color:
                                    Theme.of(context).textTheme.caption.color,
                              ),
                            ),
                            widget.description != null
                                ? Padding(
                                    padding: EdgeInsets.only(top: 3.2),
                                    child: Text(
                                      widget.description,
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
                    )
                  ],
                ),
                Align(
                  alignment: Alignment.centerRight,
                  child: SizedBox(
                    width: 55,
                    height: 35,
                    child: IgnorePointer(
                        ignoring: true,
                        child: Switch(value: value, onChanged: onChanged)),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
