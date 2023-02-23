import 'package:flutter/material.dart';
import 'package:peliculas/models/pelicula_model.dart';

class MovieHorizontal extends StatelessWidget {
  final List<Pelicula> peliculas;
  final Function siguientePagina;
  MovieHorizontal(
      {super.key, required this.peliculas, required this.siguientePagina});

  final _pageController =
      PageController(initialPage: 1, viewportFraction: 0.22);

  @override
  Widget build(BuildContext context) {
    final _screenSize = MediaQuery.of(context).size;
    _pageController.addListener(() {
      if (_pageController.position.pixels >=
          _pageController.position.maxScrollExtent - 200) {
        siguientePagina();
      }
    });
    return Container(
      height: _screenSize.height * 0.25,
      child: PageView.builder(
          pageSnapping: false,
          controller: _pageController,
          itemCount: peliculas.length,
          itemBuilder: (context, index) {
            return _crearTarjeta(context, peliculas[index]);
          }),
    );
  }

  // metodo para tarjetas
  List<Widget> _crearTarjetas(BuildContext context) {
    return peliculas.map((pelicula) {
      return Container(
        margin: const EdgeInsets.only(right: 15.0),
        child: Column(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(15.0),
              child: FadeInImage(
                placeholder: const AssetImage('assets/img/no-image.jpg'),
                image: NetworkImage(pelicula.getPosterPath()),
                fit: BoxFit.cover,
                height: 160.0,
              ),
            ),
            const SizedBox(height: 5.0),
            Text(
              pelicula.title!, //! es para decirle que no es nulo
              overflow: TextOverflow.ellipsis,
              style: Theme.of(context).textTheme.caption,
            ),
          ],
        ),
      );
    }).toList();
  }

  //método que retorna una osla tarjeta a la vez

  Widget _crearTarjeta(BuildContext context, Pelicula pelicula) {
    return Container(
      margin: const EdgeInsets.only(right: 15.0),
      child: Column(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(15.0),
            child: FadeInImage(
              placeholder: const AssetImage('assets/img/no-image.jpg'),
              image: NetworkImage(pelicula.getPosterPath()),
              fit: BoxFit.cover,
              height: 160.0,
            ),
          ),
          const SizedBox(height: 5.0),
          Text(
            pelicula.title!, //! es para decirle que no es nulo
            overflow: TextOverflow.ellipsis,
            style: Theme.of(context).textTheme.caption,
          ),
        ],
      ),
    );
  }
}
