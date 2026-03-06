

import 'package:cinemapedia/infrastructure/datasources/moviedb_datasource.dart';
import 'package:cinemapedia/infrastructure/repositories/movies_repositories_impl.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// Provider para el repositorio de películas inmutable, es decir, no se puede modificar después de su creación. Esto garantiza que el repositorio se mantenga consistente a lo largo de la aplicación y evita problemas relacionados con cambios inesperados en el estado del repositorio.
final movieRepositoryProvider = Provider((ref) {
  return MoviesRepositoriesImpl(datasource:   MoviedbDatasource()); // Se crea una instancia de MoviesRepositoriesImpl utilizando el datasource MoviedbDatasource. Esto permite que el repositorio tenga acceso a los datos de las películas a través del datasource, y se puede utilizar en toda la aplicación para obtener información sobre las películas.
});