import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:peliculas_definitivo/src/models/pelicula_model.dart';

class CardSwiper extends StatelessWidget {

  final List<Pelicula> peliculas;
  final ValueChanged<Pelicula> onPush;

  CardSwiper({ @required this.peliculas, @required this.onPush});

  @override
  Widget build(BuildContext context) {

    final _screenSize = MediaQuery.of(context).size;

    return Container(
      padding: EdgeInsets.only(top: 20.0),
      child: new Swiper(
        layout: SwiperLayout.STACK,
        itemCount: peliculas.length,
        itemWidth: _screenSize.width * 0.7,
        itemHeight: _screenSize.height * 0.5,
        //pagination: new SwiperPagination(),
        itemBuilder: (BuildContext context, int index){

          peliculas[index].uniqueId = '${peliculas[index].id}-tarjeta';

          return Hero(
            tag: peliculas[index].uniqueId,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20.0),
              child: GestureDetector(
                onTap: () => onPush(peliculas[index]),
                child: FadeInImage(
                  image : NetworkImage(peliculas[index].getPosterImg()),
                  placeholder: AssetImage('assets/img/no-image.jpg'),
                  fit: BoxFit.cover,
                ),
              ),
            ),
          );
        },
        //control: new SwiperControl(),
      ),
    );
  }
}