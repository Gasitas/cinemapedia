

// provider solo de lectura, no tiene lógica de negocio, solo se encarga de exponer la lista de películas en cartelera para el slideshow. Es un provider que se encarga de obtener la lista de películas en cartelera desde el MoviesNotifier y exponerla para que pueda ser utilizada en la UI.
import 'package:cinemapedia/presentation/providers/movies/movies_providers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final movieSlideshowProvider = Provider((ref) {
  final movies = ref.watch(nowPlayingMoviesProvider); // Obtenemos la lista de películas en cartelera utilizando el provider nowPlayingMoviesProvider. Esto nos permite acceder a la lista de películas que se ha cargado en el MoviesNotifier y mostrarla en la UI. 
  return movies.length >= 6 ? movies.sublist(0, 6) : movies; // Devolvemos solo las primeras 6 películas de la lista para el slideshow. Si la lista tiene menos de 6 películas, devolvemos toda la lista. Esto se hace para limitar el número de películas que se muestran en el slideshow y evitar que se muestren demasiadas películas si la lista es muy larga.
});