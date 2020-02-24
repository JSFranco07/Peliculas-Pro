import 'package:flutter/material.dart';
import 'package:peliculas_definitivo/src/models/pelicula_model.dart';

class MovieHorizontal extends StatelessWidget {

  final List<Pelicula> peliculas;
  final Function siguientePagina;
  final ValueChanged<Pelicula> onPush;

  MovieHorizontal ({@required this.peliculas, @required this.siguientePagina, @required this.onPush});

  final _pageController = new PageController(
    initialPage: 1,
    viewportFraction: 0.3,
  );

  @override
  Widget build(BuildContext context) {

    final _screenSize = MediaQuery.of(context).size;

    _pageController.addListener(() {
      if(_pageController.position.pixels >= _pageController.position.maxScrollExtent - 50){
        siguientePagina();
      }
    });

    return Container(
      height: _screenSize.height * 0.25,
      child: PageView.builder(
        pageSnapping: false,
        controller: _pageController,
        itemCount: peliculas.length,
        itemBuilder: (context, i){
          return _tarjeta(context, peliculas[i]);
        },
        //children: _tarjetas(context),
      ),
    );
  }

  Widget _tarjeta(BuildContext context, Pelicula pelicula){

    pelicula.uniqueId = '${pelicula.id}-poster';

    final tarjeta = Container(
      margin: EdgeInsets.only(right: 10.0),
      child: Column(
        children: <Widget>[
          Hero(
            tag: pelicula.uniqueId,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20.0),
              child: FadeInImage(
                image: NetworkImage(pelicula.getPosterImg()),
                placeholder: AssetImage('assets/img/no-image.jpg'),
                fit: BoxFit.cover,
                height: 180,
              ),
            ),
          ),
          SizedBox(height: 5.0,),
          Text(
            pelicula.title,
            overflow: TextOverflow.ellipsis,
            style: Theme.of(context).textTheme.caption,
          ),
        ],
      ),
    );

    return GestureDetector(
      child: tarjeta,
      onTap: () => onPush(pelicula),
    );

  }

  // List<Widget> _tarjetas(BuildContext context) {
  //   return peliculas.map( (pelicula){
  //     return Container(
  //       margin: EdgeInsets.only(right: 10.0),
  //       child: Column(
  //         children: <Widget>[
  //           ClipRRect(
  //             borderRadius: BorderRadius.circular(15.0),
  //             child: FadeInImage(
  //               image: NetworkImage(pelicula.getPosterImg()),
  //               placeholder: AssetImage('assets/img/no-image.jpg'),
  //               fit: BoxFit.cover,
  //               height: 180,
  //             ),
  //           ),
  //           SizedBox(height: 5.0,),
  //           Text(
  //             pelicula.title,
  //             overflow: TextOverflow.ellipsis,
  //             style: Theme.of(context).textTheme.caption,
  //           ),
  //         ],
  //       ),
  //     );
  //   }).toList();
  // }
}