

import 'package:cinemapedia/domain/entities/cast.dart';
import 'package:cinemapedia/presentation/providers/movies/movies_repository_provider.dart';
import 'package:flutter_riverpod/legacy.dart';


typedef LoadCastCallback = Future<List<Cast>> Function(String movieId); 


final getCast = StateNotifierProvider< CastNotifier, List<Cast>>((ref)
{
  final loadCast = ref.watch(movieRepositoryProvider).getActorsByMovie; // Obtenemos la función de carga de películas en cartelera (getNowPlaying) del repositorio de películas utilizando el provider movieRepositoryProvider. Esto nos permite inyectar la lógica de carga de películas en el MoviesNotifier, lo que facilita la reutilización y el mantenimiento del código.

  return CastNotifier(
      loadCast: loadCast
  );
});


class CastNotifier extends StateNotifier <List<Cast>>{
  
  bool isLoading = false;
  //int currentPage = 0;
  final LoadCastCallback loadCast;

  CastNotifier({
    required this.loadCast,
  }): super([]);

  Future<void> loadMovieCast(String movieId) async {
    
    if (isLoading) return; // Si ya se está cargando una página, no hacemos nada para evitar cargar varias páginas al mismo tiempo.
    isLoading = true; // Marcamos que estamos cargando una página para evitar cargar varias
    //currentPage++;
    
    //Agregamos un nuevo estado para que sepa que hay un cambio en el estado y se vuelva a renderizar la UI
    final List<Cast> cast = await loadCast(movieId);
    state = cast;
    isLoading = false; 
    // Marcamos que hemos terminado de cargar la página para permitir cargar la siguiente página cuando el usuario se acerque al final del scroll.
  }
}