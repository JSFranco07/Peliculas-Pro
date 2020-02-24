import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async';
import 'package:peliculas_definitivo/src/models/actor_model.dart';
import 'package:peliculas_definitivo/src/models/pelicula_model.dart';


class PeliculasProvider{
  String __apikey  = '46aa7e26f93fa093d6f1f7eb1dfb4f1c';
  String _url      = 'api.themoviedb.org';
  String _language = 'es-ES';

  //Peliculas Populares
  int _popularesPage = 0;
  bool _cargando = false;

  List<Pelicula> _populares = new List();

  final _popularesStreamController = StreamController<List<Pelicula>>.broadcast();

  Function(List<Pelicula>) get popularesSink => _popularesStreamController.sink.add;

  Stream<List<Pelicula>> get popularesStream => _popularesStreamController.stream;

  void disposeStream(){
    _popularesStreamController?.close();
  }

  Future<List<Pelicula>> _procesarRespuesta(Uri url) async {
    final resp = await http.get(url);
    final decodedData = json.decode(resp.body);

    final peliculas = new Peliculas.fromJsonList(decodedData['results']);

    return peliculas.items;
  }

  Future <List<Pelicula>> getEnCines() async{
    final url = Uri.https(_url, '3/movie/now_playing', {
      'api_key'  : __apikey,
      'language' : _language,
    });

    return await _procesarRespuesta(url);
  }

  Future <List<Pelicula>> getPopulares() async{

    if(_cargando) return [];

    _cargando = true;
    _popularesPage++;

    final url = Uri.https(_url, '3/movie/popular', {
      'api_key'  : __apikey,
      'language' : _language,
      'page'     : _popularesPage.toString()
    });

    final resp = await _procesarRespuesta(url);

    _populares.addAll(resp);
    popularesSink(_populares);

    _cargando = false;
    return resp;
  }

  Future <List<Actor>> getCast(String peliId) async{
    final url = Uri.https(_url, '3/movie/$peliId/credits', {
      'api_key'  : __apikey,
      'language' : _language,
    });

    final resp = await http.get(url);
    final decodedData = json.decode(resp.body);

    final cast = new Cast.fromJsonLsit(decodedData['cast']);

    return cast.actores;
  }

  Future <List<Pelicula>> buscarPelicula(String query) async{
    final url = Uri.https(_url, '3/search/movie', {
      'api_key'  : __apikey,
      'language' : _language,
      'query'    : query
    });

    return await _procesarRespuesta(url);
  }

  Future <List<Pelicula>> getSimilares(String peliId) async{

    final url = Uri.https(_url, '3/movie/$peliId/similar', {
      'api_key'  : __apikey,
      'language' : _language,
    });

    return await _procesarRespuesta(url);
  }

}