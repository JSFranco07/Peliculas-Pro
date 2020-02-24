import 'package:flutter/material.dart';
import 'package:peliculas_definitivo/src/models/pelicula_model.dart';
import 'package:peliculas_definitivo/src/pages/pagesPrueba/pelicula_page.dart';
import 'package:peliculas_definitivo/src/pages/pagesPrueba/prueba_page.dart';
import 'package:peliculas_definitivo/src/pages/pelicula_detalle_page.dart';
import 'package:peliculas_definitivo/src/pages/principal_page.dart';
import 'package:peliculas_definitivo/src/utils/bottom_navigation.dart';

class TabNavigatorRoutes {
  static const String inicio = '/';
  static const String peliculas = '/peliculas';
  static const String series = '/series';
}

class TabNavigator extends StatelessWidget {
  TabNavigator({this.navigatorKey, this.tabItem, this.pelicula});
  final GlobalKey<NavigatorState> navigatorKey;
  final TabItem tabItem;
  final Pelicula pelicula;


  void _push(BuildContext context, Pelicula pelicula) {
    var routeBuilders = _routeBuilders(context, pelicula);

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => routeBuilders[TabNavigatorRoutes.peliculas](context),
      ),
    );
  }

  // void _push2(BuildContext context) {
  //   var routeBuilders = _routeBuilders(context);

  //   Navigator.push(
  //     context,
  //     MaterialPageRoute(
  //       builder: (context) => routeBuilders[TabNavigatorRoutes.series](context),
  //     ),
  //   );
  // }

  Map<String, WidgetBuilder> _routeBuilders(BuildContext context, Pelicula pelicula) {
    if(tabItem == TabItem.inicio){
      return {
        TabNavigatorRoutes.inicio: (context) => PrincipalPage(

        ),
      };
    } else if(tabItem == TabItem.peliculas){
      return {
        TabNavigatorRoutes.inicio: (context) => PeliculaPage(
          onPush: (pelicula) => _push(context, pelicula),
        ),
        TabNavigatorRoutes.peliculas: (context) => PeliculaDetalle(
          pelicula: pelicula,
          onPush: (pelicula) => _push(context, pelicula),
        ),
      };
    } else{
      return{
        TabNavigatorRoutes.inicio: (context) => PruebaPage(
        ),
      };
    }
    // return {
    //   TabNavigatorRoutes.inicio: (context) => ColorsListPage(
    //         color: tabColor[tabItem],
    //         title: tabName[tabItem],
    //         onPush: (materialIndex) =>
    //             _push(context, materialIndex: materialIndex),
    //       ),
    //   TabNavigatorRoutes.peliculas: (context) => ColorDetailPage(
    //         color: tabColor[tabItem],
    //         title: tabName[tabItem],
    //         materialIndex: materialIndex,
    //         onPush: (materialIndex) => 
    //             _push2(context),
    //       ),
    //   TabNavigatorRoutes.series: (context) => PruebaPage(
    //   ),
    // };
  }

  @override
  Widget build(BuildContext context) {
    final routeBuilders = _routeBuilders(context, pelicula);
    return Navigator(
      key: navigatorKey,
      initialRoute: TabNavigatorRoutes.inicio,
      onGenerateRoute: (routeSettings) {
        return MaterialPageRoute(
          builder: (context) => routeBuilders[routeSettings.name](context),
        );
      },
    );
  }
}