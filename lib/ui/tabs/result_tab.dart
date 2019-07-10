import 'package:flutter/material.dart';

class ResultTab extends StatefulWidget {
  @override
  _ResultTabState createState() => _ResultTabState();
}

class _ResultTabState extends State<ResultTab> {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: 20,
      itemBuilder: (context, position) {
        return ListTile(
          title: Text('хуй'),
          subtitle: Text('хуй хуй ?'),
        );
      },
    );
  }
}
