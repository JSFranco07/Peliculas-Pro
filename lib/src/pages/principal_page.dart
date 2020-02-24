import 'package:flutter/material.dart';
import 'package:peliculas_definitivo/src/utils/bottom_navigation.dart';

class PrincipalPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Inicio'),
        backgroundColor: tabColor[TabItem.inicio],
      ),
    );
  }
}