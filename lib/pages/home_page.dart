import 'package:card_swiper/card_swiper.dart';
import 'package:flutter/material.dart';
import 'package:peliculas/models/pelicula_model.dart';
import 'package:peliculas/providers/peliculas_provider.dart';
import 'package:peliculas/widgets/card_swiper_widget.dart';
import 'package:peliculas/widgets/movie_horizontal.dart';
import '../models/pelicula_model.dart';
import '../providers/peliculas_provider.dart';

class HomePage extends StatelessWidget {
  final peliculasProvider = PeliculasProvider();

  // const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    peliculasProvider.getPopulares();
    return Scaffold(
      appBar: AppBar(
        title: Text('Peliculas en Cartelera'),
      ),
      body: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            _crearSwiper(),
            _crearFooter(context),
          ],
        ),
      ),
    );
  }

// metodo para swiper
  Widget _crearSwiper() {
    return FutureBuilder(
        future: peliculasProvider.getEnCartelera(),
        builder: (context, AsyncSnapshot<List<Pelicula>> snapshot) {
          if (snapshot.hasData) {
            return CardSwiper(peliculas: snapshot.data!);
          } else {
            return Container(
              height: 400.0,
              child: Center(
                child: CircularProgressIndicator(),
              ),
            );
          }
        });
  }

  //metodo footer
  Widget _crearFooter(context) {
    return Container(
      width: double.infinity,
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.only(left: 20.0),
            child: const Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'Peliculas Populares:',
                style: TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                ),
                // alignment: Alignment.centerLeft,
              ),
            ),
          ),
          const SizedBox(height: 5.0),
          StreamBuilder(
              stream: peliculasProvider.popularesStream,
              builder: (context, AsyncSnapshot<List<Pelicula>> snapshot) {
                /*snapshot.data?.forEach((element) => print(element.title));
                return Container();*/
                if (snapshot.hasData) {
                  return MovieHorizontal(
                    peliculas: snapshot.data!,
                    siguientePagina: peliculasProvider.getPopulares,
                  );
                } else {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }
              }),
        ],
      ),
    );
  }
}
