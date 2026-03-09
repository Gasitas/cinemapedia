
import 'package:cinemapedia/domain/entities/movie.dart';
import 'package:cinemapedia/presentation/providers/movies/movies_repository_provider.dart';
import 'package:flutter_riverpod/legacy.dart';

final nowPlayingMoviesProvider = StateNotifierProvider<MoviesNotifier, List<Movie>>((ref)
{
  final loadMovies = ref.watch(movieRepositoryProvider).getNowPlaying; // Obtenemos la función de carga de películas en cartelera (getNowPlaying) del repositorio de películas utilizando el provider movieRepositoryProvider. Esto nos permite inyectar la lógica de carga de películas en el MoviesNotifier, lo que facilita la reutilización y el mantenimiento del código.

  return MoviesNotifier(
      loadMovies: loadMovies
  );
});

final popularMoviesProvider = StateNotifierProvider<MoviesNotifier, List<Movie>>((ref)
{
  final loadMovies = ref.watch(movieRepositoryProvider).getPopular; // Obtenemos la función de carga de películas populares (getPopular) del repositorio de películas utilizando el provider movieRepositoryProvider. Esto nos permite inyectar la lógica de carga de películas en el MoviesNotifier, lo que facilita la reutilización y el mantenimiento del código.

  return MoviesNotifier(
      loadMovies: loadMovies
  );
});

final topRatedMoviesProvider = StateNotifierProvider<MoviesNotifier, List<Movie>>((ref)
{
  final loadMovies = ref.watch(movieRepositoryProvider).getTopRated; // Obtenemos la función de carga de películas mejor valoradas (getTopRated) del repositorio de películas utilizando el provider movieRepositoryProvider. Esto nos permite inyectar la lógica de carga de películas en el MoviesNotifier, lo que facilita la reutilización y el mantenimiento del código.

  return MoviesNotifier(
      loadMovies: loadMovies
  );
});

final upcomingMoviesProvider = StateNotifierProvider<MoviesNotifier, List<Movie>>((ref)
{
  final loadMovies = ref.watch(movieRepositoryProvider).getUpcoming; // Obtenemos la función de carga de películas próximas a estrenarse (getUpcoming) del repositorio de películas utilizando el provider movieRepositoryProvider. Esto nos permite inyectar la lógica de carga de películas en el MoviesNotifier, lo que facilita la reutilización y el mantenimiento del código.

  return MoviesNotifier(
      loadMovies: loadMovies
  );
});

typedef LoadMoviesCallback = Future<List<Movie>> Function({int page}); // Definimos un tipo de función llamado LoadMoviesCallback que representa una función asíncrona que devuelve una lista de películas (List<Movie>) y acepta un parámetro opcional page de tipo int. Este tipo de función se utilizará para cargar las películas en la clase MoviesNotifier, permitiendo que se pueda inyectar la lógica de carga de películas desde fuera de la clase, lo que facilita la reutilización y el mantenimiento del código.

class MoviesNotifier extends StateNotifier <List<Movie>>{
  bool isLoading = false;
  int currentPage = 0;
  final LoadMoviesCallback loadMovies;

  MoviesNotifier({
    required this.loadMovies,
  }): super([]);


  Future<void> loadNextPage() async {

    if (isLoading) return; // Si ya se está cargando una página, no hacemos nada para evitar cargar varias páginas al mismo tiempo.
    isLoading = true; // Marcamos que estamos cargando una página para evitar cargar varias
    currentPage++;
    
    //Agregamos un nuevo estado para que sepa que hay un cambio en el estado y se vuelva a renderizar la UI
    final List<Movie> movies = await loadMovies(page: currentPage);
    state =[...state, ...movies];
    await Future.delayed(const Duration(seconds: 2)); // Simulamos un retraso de 2 segundos para mostrar el indicador de carga en la UI. En una implementación real, este retraso no sería necesario, ya que la función loadMovies ya es asíncrona y se completará cuando se hayan cargado las películas.
    isLoading = false; // Marcamos que hemos terminado de cargar la página para permitir cargar la siguiente página cuando el usuario se acerque al final del scroll.
    // Llamamos a la función loadMovies pasando el número de página actual (currentPage) para cargar las películas correspondientes a esa página. La función loadMovies es asíncrona, por lo que utilizamos await para esperar a que se complete la carga de películas antes de continuar con la ejecución del código.
    //final List<Movie> movies =  // Simulamos una llamada a una API con un retraso de 2 segundos, y devolvemos una lista vacía de películas. En una implementación real, aquí se haría la llamada a la API para obtener las películas en cartelera.
  }
}