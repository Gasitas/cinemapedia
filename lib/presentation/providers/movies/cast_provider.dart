

import 'package:cinemapedia/domain/entities/cast.dart';
import 'package:flutter_riverpod/legacy.dart';

import '../providers.dart';

typedef LoadCastCallback = Future<List<Cast>> Function({String movieId}); 


final getCast = StateNotifierProvider< CastNotifier, List<Cast>>((ref)
{
  final loadCast = ref.watch(movieRepositoryProvider).getActorsByMovie(movieId: 'test'); // Obtenemos la función de carga de películas en cartelera (getNowPlaying) del repositorio de películas utilizando el provider movieRepositoryProvider. Esto nos permite inyectar la lógica de carga de películas en el MoviesNotifier, lo que facilita la reutilización y el mantenimiento del código.

  return CastNotifier(
      loadCast: loadCast
  );
});


class CastNotifier extends StateNotifier <List<Cast>>{
  bool isLoading = false;
  int currentPage = 0;
  final LoadCastCallback loadCast;

  CastNotifier({
    required this.loadCast,
  }): super([]);
}