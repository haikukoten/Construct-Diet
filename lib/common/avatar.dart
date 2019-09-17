import 'package:flutter/material.dart';
import 'package:transparent_image/transparent_image.dart';

class Avatar extends StatefulWidget {
  final String url;
  final double size;
  Avatar({this.url, this.size});

  @override
  _AvatarState createState() => _AvatarState();
}

class _AvatarState extends State<Avatar> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: widget.size,
      width: widget.size,
      child: ClipOval(
        child: Stack(
          children: <Widget>[
            Container(color: Theme.of(context).dividerColor),
            FadeInImage.memoryNetwork(
              fadeInDuration: Duration(milliseconds: 150),
              placeholder: kTransparentImage,
              image: widget.url,
            ),
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(25.0),
                border: Border.all(
                  width: 0.5,
                  color: Theme.of(context).dividerColor,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
