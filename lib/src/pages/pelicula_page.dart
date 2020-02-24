import 'package:flutter/material.dart';
import 'package:peliculas_definitivo/src/models/pelicula_model.dart';
import 'package:peliculas_definitivo/src/providers/pelicula_provider.dart';
import 'package:peliculas_definitivo/src/search/search_delegate.dart';
import 'package:peliculas_definitivo/src/utils/bottom_navigation.dart';
import 'package:peliculas_definitivo/src/widgets/card_swiper_widget.dart';
import 'package:peliculas_definitivo/src/widgets/movie_horizontal_widget.dart';

class PeliculaPage extends StatelessWidget {

  final peliculasProvider = PeliculasProvider();
  final ValueChanged<Pelicula> onPush;

  PeliculaPage({@required this.onPush});

  @override
  Widget build(BuildContext context) {

    peliculasProvider.getPopulares();

    return Scaffold(
      appBar: AppBar(
        title: Text('Peliculas en Cartelera'),
        backgroundColor: tabColor[TabItem.peliculas],
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.search), 
            onPressed: (){
              showSearch(
                context: context, 
                delegate: DataSearch(onPush: onPush),
              );
            }
          )
        ]
      ),
      body: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            _swiperTarjetas(),
            _footer(context),
          ],
        ),
      ),
    );
  }

  Widget _swiperTarjetas() {
    return FutureBuilder(
      future: peliculasProvider.getEnCines(),
      builder: (BuildContext context, AsyncSnapshot<List> snapshot){
        if (snapshot.hasData) {
          return CardSwiper(peliculas: snapshot.data, onPush: onPush,);
        } else {
          return Container(
            height: 400.0,
            child: Center(
              child: CircularProgressIndicator(),
            ),
          );
        }
      },
    );
  }

  Widget _footer( BuildContext context) {
    return Container(
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            padding: EdgeInsets.only(left: 20.0),
            child: Text('Populares', style: Theme.of(context).textTheme.subhead)
          ),
          SizedBox(height: 10.0,),
          StreamBuilder(
            stream: peliculasProvider.popularesStream,
            builder: (BuildContext context, AsyncSnapshot<List> snapshot) {

              if(snapshot.hasData){
                return MovieHorizontal (
                  peliculas: snapshot.data,
                  siguientePagina: peliculasProvider.getPopulares,
                  onPush: onPush,
                );
              } else{
                return Center(child: CircularProgressIndicator());
              }
            },
          )
        ],
      ),
    );
  }
}