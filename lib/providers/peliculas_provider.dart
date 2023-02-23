import 'dart:async';

import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:peliculas/models/pelicula_model.dart';

class PeliculasProvider {
  // propiedades

  String _apikey = '14b37c990bfba8ef77db501b71862e6f';
  String _urlBase = 'api.themoviedb.org';
  String _language = 'es-ES';

  int populares = 0;

  List<Pelicula> _populares = [];

  //declaramos el controlador del Stream
  final _popularesStreamController =
      StreamController<List<Pelicula>>.broadcast();

  // metodo para obtener el stream
  Stream<List<Pelicula>> get popularesStream =>
      _popularesStreamController.stream;

  // metodo para cerrar el stream
  void disposeStream() {
    _popularesStreamController.close();
  }

  // funcion getter que hace el sink (inserta data al stream)
  Function(List<Pelicula>) get popularesSink =>
      _popularesStreamController.sink.add;

  // metodo para obtener respuesta del endpoint now_playing
  Future<List<Pelicula>> getEnCartelera() async {
    // url de peticion
    final url = Uri.https(_urlBase, '3/movie/now_playing', {
      'api_key': _apikey,
      'language': _language,
    });
    // obtener respuesta
    final resp = await http.get(url);

    // decodificacion de respuesta
    final decodedData = json.decode(resp.body);

    // print(decodedData['results']);
    final peliculas = new Peliculas.fromJsonList(decodedData['results']);
    // print(peliculas.items[0].title);
    return peliculas.items;
  }

  //metodo para pelis populares

  Future<List<Pelicula>> getPopulares() async {
    populares++;
    // url de peticion
    final url = Uri.https(_urlBase, '3/movie/popular', {
      'api_key': _apikey,
      'language': _language,
      'page': populares.toString(),
    });
    // obtener respuesta
    final resp = await http.get(url);

    // decodificacion de respuesta
    final decodedData = json.decode(resp.body);

    // print(decodedData['results']);
    final peliculas = Peliculas.fromJsonList(decodedData['results']);
    // print(peliculas.items[0].title);

    final respuesta = peliculas.items;
    _populares.addAll(respuesta);
    popularesSink(_populares);
    return peliculas.items;
  }
}
