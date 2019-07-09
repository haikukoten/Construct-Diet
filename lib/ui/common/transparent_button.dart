import 'package:flutter/material.dart';

class TransparentButton extends StatelessWidget {
  TransparentButton({Key key, this.onTap, this.child}) : super(key: key);

  final VoidCallback onTap;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8),
      child: GestureDetector(
          onTap: onTap,
          child: Opacity(
            opacity: 0.95,
            child: Material(
              type: MaterialType.transparency,
              child: child,
            ),
          )),
    );
  }
}
