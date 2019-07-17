import 'package:flutter/material.dart';

class IconButton extends StatelessWidget {
  final double width;
  final double height;
  final Icon icon;
  final GestureTapCallback onPressed;

  IconButton({this.width = 40, this.height = 40, this.icon, this.onPressed});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: height,
      child: InkWell(
        highlightColor: Colors.grey.withAlpha(50),
        splashColor: Colors.grey.withAlpha(50),
        borderRadius: BorderRadius.all(Radius.circular(50)),
        child: icon,
        onTap: onPressed,
      ),
    );
  }
}
