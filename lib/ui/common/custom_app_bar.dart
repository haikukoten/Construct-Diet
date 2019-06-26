import 'package:construct_diet/ui/screens/settings_page.dart';
import 'package:dynamic_theme/dynamic_theme.dart';
import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class CustomAppBar extends StatefulWidget {
  @override
  _CustomAppBarState createState() => _CustomAppBarState();
}

class _CustomAppBarState extends State<CustomAppBar> {
  void changeTheme() {
    DynamicTheme.of(context).setBrightness(
        Theme.of(context).brightness == Brightness.dark
            ? Brightness.light
            : Brightness.dark);
  }

  @override
  Widget build(BuildContext context) {
    final statusBarHeight = MediaQuery.of(context).padding.top;
    final contentWidth = MediaQuery.of(context).size.width;
    return Container(
      width: contentWidth,
      padding: EdgeInsets.fromLTRB(3, statusBarHeight + 6, 3, 22),
      decoration: new BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Colors.black38,
            blurRadius: 5.0,
          ),
        ],
        borderRadius: BorderRadius.vertical(bottom: Radius.elliptical(240, 20)),
        gradient: LinearGradient(colors: [
          Theme.of(context).brightness == Brightness.light
              ? Color(0xffF55B9A)
              : Color(0xff5bf5b6),
          Theme.of(context).brightness == Brightness.light
              ? Color(0xffF9B16E)
              : Color(0xff6eb6f9)
        ], begin: Alignment.centerLeft, end: Alignment.centerRight),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              IconButton(
                  tooltip: "Настройки",
                  color: Theme.of(context).bottomAppBarColor,
                  icon: Icon(MdiIcons.settingsOutline, size: 20),
                  onPressed: () {
                    Navigator.push(
                      context,
                      PageRouteBuilder(
                          pageBuilder: (context, animation1, animation2) {
                            return SettingsPage();
                          },
                          transitionsBuilder:
                              (context, animation1, animation2, child) {
                            return SlideTransition(
                              position: animation1.drive(
                                Tween<Offset>(
                                  begin: const Offset(-1.0, 0.0),
                                  end: Offset.zero,
                                ).chain(
                                  CurveTween(
                                    curve: Curves.easeInOutQuart,
                                  ),
                                ),
                              ),
                              child: child,
                            );
                          },
                          transitionDuration: Duration(milliseconds: 400)),
                    );
                  }),
              Text("Construct Diet",
                  style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                      color: Theme.of(context).bottomAppBarColor)),
              IconButton(
                  tooltip: Theme.of(context).brightness == Brightness.dark
                      ? "Перейти на светлую сторону"
                      : "Перейти на тёмную сторону",
                  color: Theme.of(context).bottomAppBarColor,
                  icon: Theme.of(context).brightness == Brightness.dark
                      ? Icon(MdiIcons.weatherSunny, size: 20)
                      : Icon(MdiIcons.weatherNight, size: 20),
                  onPressed: () {
                    changeTheme();
                  })
            ],
          ),
          Padding(
            padding: EdgeInsets.only(top: 4),
            child: UIFlatButton(
                child: Column(
              textDirection: TextDirection.ltr,
              children: <Widget>[
                Text("мужчина, 16 лет, 182 см, 66 кг, нормостеник",
                    style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        color: Theme.of(context).bottomAppBarColor)),
                Padding(
                  padding: EdgeInsets.only(top: 3),
                  child: Text("нажмите для редактирования",
                      style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          color: Theme.of(context).bottomAppBarColor)),
                )
              ],
            )),
          )
        ],
      ),
    );
  }
}

class UIFlatButton extends StatelessWidget {
  UIFlatButton({Key key, this.onTap, this.child}) : super(key: key);

  final VoidCallback onTap;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: onTap,
        child: Opacity(
          opacity: 0.95,
          child: Material(
            type: MaterialType.transparency,
            child: child,
          ),
        ));
  }
}
