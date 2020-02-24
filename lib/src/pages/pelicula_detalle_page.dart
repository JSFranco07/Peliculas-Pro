import 'package:flutter/material.dart';
import 'package:peliculas_definitivo/src/models/pelicula_model.dart';
import 'package:peliculas_definitivo/src/providers/pelicula_provider.dart';
import 'package:peliculas_definitivo/src/models/actor_model.dart';

class PeliculaDetalle extends StatelessWidget {

  final Pelicula pelicula;
  final ValueChanged<Pelicula> onPush;

  PeliculaDetalle({this.pelicula, this.onPush});

  @override
  Widget build(BuildContext context) {

  //final Pelicula pelicula = ModalRoute.of(context).settings.arguments;

    return Scaffold(
      body: CustomScrollView(
        slivers: <Widget>[
          _crearAppbar(pelicula),
          SliverList(
            delegate: SliverChildListDelegate(
              [
                SizedBox(height: 15.0,),
                _posterTitulo(context, pelicula),
                _descripcion(pelicula),
                _getTitulo(context, 'Reparto'),
                _crearCasting(pelicula),
                _getTitulo(context, 'Otras personas también buscan'),
                _crearSimilares(pelicula),
                SizedBox(height: 15.0,),
              ]
            ),
          )
        ],
      ),
    );
  }

  Widget _getTitulo(BuildContext context, String titulo){
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 15.0, vertical: 10.0),
      child: Text(titulo, style: Theme.of(context).textTheme.subhead)
    );
  }

  Widget _crearAppbar(Pelicula pelicula) {
    return SliverAppBar(
      elevation: 2.0,
      backgroundColor: Colors.indigoAccent,
      expandedHeight: 200.0,
      floating: false,
      pinned: true,
      flexibleSpace: FlexibleSpaceBar(
        centerTitle: true,
        title: Text(
          pelicula.title,
          style: TextStyle(color: Colors.white, fontSize: 16.0),
        ),
        background: FadeInImage(
          image: NetworkImage(pelicula.getBackgroundImg()),
          placeholder: AssetImage('assets/img/loading.gif'), 
          fadeInDuration: Duration(milliseconds: 150),
          fit: BoxFit.cover,
        ),
      ),
    );
  }

  Widget _posterTitulo(BuildContext context, Pelicula pelicula){
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20.0),
      child: Row(
        children: <Widget>[
          Hero(
            tag: pelicula.uniqueId,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20.0),
              child: Image(
                image: NetworkImage(pelicula.getPosterImg()),
                height: 160.0,
              ),
            ),
          ),
          SizedBox(width: 20.0,),
          Flexible(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(pelicula.title, style: Theme.of(context).textTheme.title, overflow: TextOverflow.ellipsis,),
                Text(pelicula.originalTitle, style: Theme.of(context).textTheme.subhead, overflow: TextOverflow.ellipsis,),
                Row(
                  children: <Widget>[
                    Icon(Icons.star_border),
                    Text(pelicula.voteAverage.toString(), style: Theme.of(context).textTheme.subhead),
                  ],
                )
              ],
            )
          )
        ],
      ),
    );
  }

  Widget _descripcion(Pelicula pelicula) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 15.0, vertical: 15.0),
      child: Text(
        pelicula.overview,
        textAlign: TextAlign.justify,
      ),
    );
  }

  Widget _crearCasting(Pelicula pelicula) {
    final peliProvider = new PeliculasProvider();

    return FutureBuilder(
      future: peliProvider.getCast(pelicula.id.toString()),
      builder: (context, AsyncSnapshot<List> snapshot) {
        if(snapshot.hasData){
          return _crearActoresPageView(snapshot.data);
        } else{
          return Center(child: CircularProgressIndicator(),);
        }
      },
    );
  }

  Widget _crearActoresPageView(List<Actor> actores) {
    return SizedBox(
      height: 190.0,
      child: PageView.builder(
        pageSnapping: false,
        controller: PageController(
          viewportFraction: 0.33 ,
          initialPage: 1,
        ),
        itemCount: actores.length,
        itemBuilder: (context, i) => _actorTarjeta(actores[i]),
      ),
    );
  }

  Widget _actorTarjeta(Actor actor){
    return Container(
      child: Column(
        children: <Widget>[
          ClipRRect(
            borderRadius: BorderRadius.circular(20.0),
            child: FadeInImage(
              image: NetworkImage(actor.getFoto()),
              placeholder: AssetImage('assets/img/no-image.jpg'),
              height: 170.0,
              fit: BoxFit.cover,
            ),
          ),
          Text(
            actor.name,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }


  Widget _crearSimilares(Pelicula pelicula) {
    final peliProvider = new PeliculasProvider();

    return FutureBuilder(
      future: peliProvider.getSimilares(pelicula.id.toString()),
      builder: (context, AsyncSnapshot<List> snapshot) {
        if(snapshot.hasData){
          return _crearSimilaresPageView(snapshot.data);
        } else{
          return Center(child: CircularProgressIndicator(),);
        }
      },
    );
  }

  Widget _crearSimilaresPageView(List<Pelicula> peliculas) {
    return SizedBox(
      height: 190.0,
      child: PageView.builder(
        pageSnapping: false,
        controller: PageController(
          viewportFraction: 0.33,
          initialPage: 1,
        ),
        itemCount: peliculas.length,
        itemBuilder: (context, i) =>_similaresTarjeta(context, peliculas[i]),
      ),
    );
  }

  Widget _similaresTarjeta(context, Pelicula pelicula){
    pelicula.uniqueId = '${pelicula.id}-similar';

    return Container(
      child: Column(
        children: <Widget>[
          Hero(
            tag: pelicula.uniqueId,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20.0),
              child: GestureDetector(
                onTap: () => onPush(pelicula),
                child: FadeInImage(
                  image: NetworkImage(pelicula.getPosterImg()),
                  placeholder: AssetImage('assets/img/no-image.jpg'),
                  height: 170.0,
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          Text(
            pelicula.title,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }
}