import 'package:construct_diet/common/diet.dart';
import 'package:construct_diet/common/page_transition.dart';
import 'package:construct_diet/scoped_models/data_model.dart';
import 'package:construct_diet/screens/diet_info_page.dart';
import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:scoped_model/scoped_model.dart';

import 'buttons.dart' as custom;

class ButtonLabel extends StatelessWidget {
  final String title;
  final String description;
  final IconData icon;
  final Color color;
  final VoidCallback onPressed;

  ButtonLabel(this.title,
      {this.description, this.icon, this.color, this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(8, 5, 8, 5),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          highlightColor: Colors.grey.withAlpha(30),
          splashColor: Colors.grey.withAlpha(30),
          onTap: onPressed,
          borderRadius: BorderRadius.all(Radius.circular(5)),
          child: Padding(
            padding: EdgeInsets.all(10),
            child: Stack(
              alignment: Alignment.center,
              children: [
                Row(
                  children: <Widget>[
                    icon != null
                        ? Container(
                            margin: EdgeInsets.only(right: 15),
                            child: Icon(
                              icon,
                              size: 20,
                              color: color ?? Theme.of(context).primaryColor,
                            ),
                          )
                        : Container(),
                    Container(
                      width: MediaQuery.of(context).size.width > 750
                          ? 750.0 - 170.0
                          : MediaQuery.of(context).size.width - 170,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            title,
                            strutStyle: StrutStyle(
                              leading: 0,
                            ),
                            style: TextStyle(
                              fontSize: 15,
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
                        ],
                      ),
                    ),
                  ],
                ),
                Align(
                  alignment: Alignment.centerRight,
                  child: Icon(
                    Icons.chevron_right,
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

class DietLabel extends StatelessWidget {
  final Diet diet;

  DietLabel(this.diet);

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: Padding(
        padding: EdgeInsets.all(8.0),
        child: InkWell(
          highlightColor: Colors.grey.withAlpha(30),
          splashColor: Colors.grey.withAlpha(30),
          onTap: () {
            ScopedModel.of<DataModel>(context).closeTip();
            Navigator.push(
              context,
              TransitionPageRoute(widget: DietInfoPage(diet)),
            );
          },
          borderRadius: BorderRadius.all(Radius.circular(5)),
          child: Padding(
            padding: EdgeInsets.fromLTRB(10, 8.5, 2, 8.5),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      diet.name,
                      strutStyle: StrutStyle(
                        leading: 0,
                      ),
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w600,
                        color: Theme.of(context).textTheme.caption.color,
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 3.2),
                      child: Text(
                        diet.description,
                        style: TextStyle(
                          fontSize: 12.2,
                          color: Theme.of(context)
                              .textTheme
                              .caption
                              .color
                              .withAlpha(180),
                        ),
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: EdgeInsets.only(bottom: 14.5),
                  child: Row(
                    children: List<Widget>.generate(
                      diet.icons.length,
                      (i) {
                        return Padding(
                          padding: EdgeInsets.all(3),
                          child: Icon(
                            diet.icons[i],
                            size: 12.2,
                            color: Theme.of(context)
                                .textTheme
                                .caption
                                .color
                                .withAlpha(200),
                          ),
                        );
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class InfoLabel extends StatelessWidget {
  final String title;
  final String description;
  final IconData icon;
  final Color color;

  InfoLabel(this.title, {this.description, this.icon, this.color});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: description != null
          ? EdgeInsets.fromLTRB(18, 14.5, 18, 14.5)
          : EdgeInsets.fromLTRB(18, 19.5, 18, 19.5),
      child: Row(
        crossAxisAlignment: description.contains("\n")
            ? CrossAxisAlignment.start
            : CrossAxisAlignment.center,
        children: <Widget>[
          icon != null
              ? Container(
                  margin: EdgeInsets.only(
                    right: 15,
                    top: description.contains("\n") ? 5 : 0,
                  ),
                  child: Icon(
                    icon,
                    size: 20,
                    color: color ?? Theme.of(context).primaryColor,
                  ))
              : Container(),
          Container(
            width: MediaQuery.of(context).size.width > 750
                ? 750.0 - 140.0
                : MediaQuery.of(context).size.width - 140,
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: EdgeInsets.only(top: description != null ? 0 : 4),
                    child: Text(
                      title,
                      strutStyle: StrutStyle(
                        leading: 0,
                      ),
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w600,
                        color: Theme.of(context).textTheme.caption.color,
                      ),
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

class SwitchLabel extends StatefulWidget {
  final String title;
  final String description;
  final IconData icon;
  final Color color;
  final bool value;
  final ValueChanged<bool> onChanged;

  SwitchLabel(this.title,
      {this.description, this.icon, this.color, this.value, this.onChanged});

  @override
  _SwitchLabelState createState() => _SwitchLabelState(this.value);
}

class PlugLabel extends StatelessWidget {
  final String title;
  final String description;
  final IconData icon;
  final Color color;

  PlugLabel(this.title, {this.description, this.icon, this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.fromLTRB(18, 21, 18, 21),
      child: Column(
        children: <Widget>[
          icon != null
              ? Container(
                  margin: EdgeInsets.only(bottom: 16),
                  child: Icon(
                    icon,
                    size: 40,
                    color: color ?? Theme.of(context).primaryColor,
                  ))
              : Container(),
          Column(children: [
            Text(
              title,
              textAlign: TextAlign.center,
              strutStyle: StrutStyle(
                leading: 0,
              ),
              style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w600,
                color: Theme.of(context).textTheme.caption.color,
              ),
            ),
            description != null
                ? Padding(
                    padding: EdgeInsets.only(top: 3.2),
                    child: Text(
                      description,
                      textAlign: TextAlign.center,
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

class SelectFavoriteLabel extends StatefulWidget {
  final String title;
  final IconData icon;
  final int isLiked;
  final ValueChanged<int> onChanged;

  SelectFavoriteLabel(this.title, {this.icon, this.isLiked, this.onChanged});

  @override
  _SelectFavoriteLabelState createState() => _SelectFavoriteLabelState();
}

class TitleLabel extends StatelessWidget {
  final String title;
  final IconData icon;
  final Widget child;
  final double paddingTop;
  final double paddingBottom;

  TitleLabel(this.title,
      {this.icon, this.child, this.paddingTop = 14, this.paddingBottom = 2});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Padding(
          padding: EdgeInsets.fromLTRB(18, paddingTop, 18, 0),
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
              Padding(
                padding: EdgeInsets.only(top: 0.5),
                child: Text(
                  title,
                  strutStyle: StrutStyle(
                    leading: 0,
                  ),
                  style: TextStyle(
                    fontSize: 12.8,
                    color: Theme.of(context)
                        .textTheme
                        .caption
                        .color
                        .withAlpha(180),
                  ),
                ),
              ),
            ],
          ),
        ),
        Padding(
          padding: EdgeInsets.only(bottom: paddingBottom),
          child: child,
        ),
      ],
    );
  }
}

class _SwitchLabelState extends State<SwitchLabel> {
  bool value;
  _SwitchLabelState(this.value);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(8, 5, 8, 5),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          highlightColor: Colors.grey.withAlpha(30),
          splashColor: Colors.grey.withAlpha(30),
          onTap: () {
            setState(() {
              value = !value;
            });
            widget.onChanged(value);
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
                              color: widget.color ??
                                  Theme.of(context).primaryColor,
                            ))
                        : Container(),
                    Container(
                      width: MediaQuery.of(context).size.width > 750
                          ? 750.0 - 164.0
                          : MediaQuery.of(context).size.width - 164,
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              widget.title,
                              style: TextStyle(
                                fontSize: 15,
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
                        child:
                            Switch(value: value, onChanged: widget.onChanged)),
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

class _SelectFavoriteLabelState extends State<SelectFavoriteLabel> {
  int isLiked;

  @override
  void initState() {
    super.initState();
    isLiked = widget.isLiked;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(13, 5, 8, 5),
      child: Material(
        color: Colors.transparent,
        child: Padding(
          padding: EdgeInsets.all(5),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: <Widget>[
                  Container(
                      margin: EdgeInsets.only(right: 15),
                      child: Icon(
                        widget.icon,
                        size: 20,
                        color: Theme.of(context).primaryColor,
                      )),
                  Container(
                    width: MediaQuery.of(context).size.width > 750
                        ? 750.0 - 185.0
                        : MediaQuery.of(context).size.width - 185,
                    child: Text(
                      widget.title,
                      strutStyle: StrutStyle(
                        leading: 0,
                      ),
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w600,
                        color: Theme.of(context).textTheme.caption.color,
                      ),
                    ),
                  ),
                ],
              ),
              Row(
                children: <Widget>[
                  custom.IconSwitch(
                    icon: Icon(
                      MdiIcons.thumbUpOutline,
                      size: 18,
                      color: Theme.of(context)
                          .textTheme
                          .caption
                          .color
                          .withAlpha(150),
                    ),
                    selectedIcon: Icon(
                      MdiIcons.thumbUp,
                      size: 18,
                      color: Theme.of(context).primaryColorLight,
                    ),
                    value: isLiked == 1,
                    onChanged: (isOn) {
                      if (isOn == true) {
                        setState(() {
                          isLiked = 1;
                        });
                        widget.onChanged(isLiked);
                      } else if (isLiked == 1) {
                        setState(() {
                          isLiked = 0;
                        });
                        widget.onChanged(isLiked);
                      }
                    },
                  ),
                  custom.IconSwitch(
                    icon: Icon(
                      MdiIcons.thumbDownOutline,
                      size: 18,
                      color: Theme.of(context)
                          .textTheme
                          .caption
                          .color
                          .withAlpha(150),
                    ),
                    selectedIcon: Icon(
                      MdiIcons.thumbDown,
                      size: 18,
                      color: Theme.of(context).errorColor,
                    ),
                    value: isLiked == 2,
                    onChanged: (isOn) {
                      if (isOn == true) {
                        setState(() {
                          isLiked = 2;
                        });
                        widget.onChanged(isLiked);
                      } else if (isLiked == 2) {
                        setState(() {
                          isLiked = 0;
                        });
                        widget.onChanged(isLiked);
                      }
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
