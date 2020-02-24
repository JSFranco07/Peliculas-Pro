import 'package:flutter/material.dart';
import 'package:peliculas_definitivo/src/utils/bottom_navigation.dart';

class SeriePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Series al Aire'),
        backgroundColor: tabColor[TabItem.series],
      ),
    );
  }
}