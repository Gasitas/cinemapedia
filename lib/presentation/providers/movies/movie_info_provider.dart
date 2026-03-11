import 'package:cinemapedia/domain/entities/movie.dart';
import 'package:cinemapedia/presentation/providers/movies/movies_repository_provider.dart';
import 'package:flutter_riverpod/legacy.dart';


final movieInfoProvider = StateNotifierProvider <MovieMapNotifier, Map<String, Movie>>((ref) {
  final loadMovie =  ref.watch(movieRepositoryProvider).getMovieById; 
  return MovieMapNotifier(getMovie: loadMovie);
 
});

typedef GetMovieCallback = Future<Movie> Function(String movieId); // Definimos un tipo de función llamado GetMovieCallback que representa una función asíncrona que devuelve una película (Movie) y acepta un parámetro movieId de tipo String. Este tipo de función se utilizará para obtener los detalles de una película en la clase MovieMapNotifier, permitiendo que se pueda inyectar la lógica de obtención de detalles de película desde fuera de la clase, lo que facilita la reutilización y el mantenimiento del código.

class MovieMapNotifier extends StateNotifier<Map<String, Movie>>{

  final GetMovieCallback getMovie;
  
  MovieMapNotifier({
    required this.getMovie,
    }): super({});

  Future<void> loadMovie(String movieId) async {
    if (state[movieId] != null) return;
    
    final movie = await getMovie(movieId); 
    // Si el mapa ya contiene la película con su ID como clave, no hacemos nada para evitar agregar la misma película varias veces.
    
    state = {...state, movieId: movie}; // clonar el estado actual del mapa de películas y agregar la nueva película con su ID como clave. Esto nos permite actualizar el estado del mapa de películas de manera inmutable, lo que es una buena práctica en Flutter para evitar problemas de estado compartido y facilitar la depuración.
  }
 //Actualizamos el estado del mapa de películas agregando la película con su ID como clave. Esto nos permite almacenar y acceder a las películas de manera eficiente utilizando su ID como referencia.
  
}