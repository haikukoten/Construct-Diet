import 'package:flutter/material.dart';

class FavoritesTab extends StatefulWidget {
  @override
  _FavoritesTabState createState() => _FavoritesTabState();
}

class _FavoritesTabState extends State<FavoritesTab> {
  @override
  Widget build(BuildContext context) {
    final statusBarHeight = MediaQuery.of(context).padding.top;

    return Container(
        padding: EdgeInsets.only(top: statusBarHeight + 120),
        alignment: Alignment.topCenter,
        child: Text("а)"));
  }
}
