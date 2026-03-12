import 'package:cinemapedia/domain/datasources/movies_datasource.dart';
import 'package:cinemapedia/domain/entities/cast.dart';
import 'package:cinemapedia/domain/entities/movie.dart';
import 'package:cinemapedia/domain/repositories/movie_repository.dart';

class MoviesRepositoriesImpl extends MoviesRepository {

  final MoviesDatasource datasource; // Inyección de dependencia del datasource
  
  MoviesRepositoriesImpl({required this.datasource}); // Constructor para recibir el datasource

  @override
  Future<List<Movie>> getNowPlaying({int page = 1}) async   // Implementación del método getNowPlaying utilizando el datasource
  {
    return datasource.getNowPlaying(page: page); // Delegar la llamada al datasource para obtener las películas en cartelera
  }

  @override
  Future<List<Movie>> getPopular({int page = 1}) async{
    return datasource.getPopular(page: page); // Delegar la llamada al datasource para obtener las películas populares 
  }

  @override
  Future<List<Movie>> getTopRated({int page = 1}) async {
    return datasource.getTopRated(page: page); // Delegar la llamada al datasource para obtener las películas mejor valoradas
    
  }

  @override
  Future<List<Movie>> getUpcoming({int page = 1}) async {
    return datasource.getUpcoming(page: page); // Delegar la llamada al datasource para obtener las películas próximas a estrenarse
  }

  @override
  Future<Movie> getMovieById(String id) async {
    return datasource.getMovieById(id); // Delegar la llamada al datasource para obtener los detalles de una película por su ID
  }

  @override
  Future<List<Cast>> getActorsByMovie(String movieId) async{
    return datasource.getActorsByMovie(movieId); // Delegar la llamada al datasource para obtener los actores de una película por su ID
  }


}