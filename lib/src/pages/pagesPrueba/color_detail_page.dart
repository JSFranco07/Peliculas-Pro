import 'package:flutter/material.dart';

class ColorDetailPage extends StatelessWidget {
  ColorDetailPage({this.color, this.title, this.materialIndex: 500, this.onPush});
  final MaterialColor color;
  final String title;
  final int materialIndex;
  final ValueChanged onPush;

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        backgroundColor: color,
        title: Text(
          '$title[$materialIndex]',
        ),
      ),
      body: Container(
        color: color[materialIndex],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => onPush(context),
        child: Icon(Icons.favorite),
      ),
    );
  }
}