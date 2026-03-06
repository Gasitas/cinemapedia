import 'package:cinemapedia/config/constants/environment.dart';
import 'package:cinemapedia/domain/datasources/movies_datasource.dart';
import 'package:cinemapedia/domain/entities/movie.dart';
import 'package:cinemapedia/infrastructure/mappers/movie_mapper.dart';
import 'package:cinemapedia/infrastructure/models/moviedb/moviedb_response.dart';
import 'package:dio/dio.dart';

class MoviedbDatasource extends MoviesDatasource {

      final dio =Dio(
        BaseOptions(
          baseUrl: 'https://api.themoviedb.org/3',
          queryParameters: {
            'api_key': Environment.movieDbKey,
            'language': 'es-ES',
          } 
      ));

  @override
  Future<List<Movie>> getNowPlaying({int page = 1}) async{ 

    final Response response = await dio.get('/movie/now_playing', queryParameters: {
      'page': page,
    });
    final MoviesDbResponse moviesDbResponse = MoviesDbResponse.fromJson(response.data); // Convertir la respuesta JSON a MoviesDbResponse
    final List<Movie> movies = moviesDbResponse.results
      .where((moviedb) => moviedb.posterPath != 'no-poster') // Filtrar solo las películas que tienen posterPath distinto de 'no-poster'
      .map((movieDB) => MovieMapper.fromMovieDBToEntity(movieDB)).toList(); // Mapear cada MovieMovieDB a Movie usando el MovieMapper 
    
    return movies;
  }


  @override
  Future<List<Movie>> getPopular({int page = 1}) async {
    final Response response = await dio.get('/movie/popular', queryParameters: {
      'page': page,
    });
    final MoviesDbResponse moviesDbResponse = MoviesDbResponse.fromJson(response.data); // Convertir la respuesta JSON a MoviesDbResponse
    final List<Movie> movies = moviesDbResponse.results
      .where((moviedb) => moviedb.posterPath != 'no-poster') // Filtrar solo las películas que tienen posterPath distinto de 'no-poster'
      .map((movieDB) => MovieMapper.fromMovieDBToEntity(movieDB)).toList(); // Mapear cada MovieMovieDB a Movie usando el MovieMapper 
    
    return movies;
  }

  @override
  Future<List<Movie>> getTopRated({int page = 1}) {
    return Future.value([]);
  }

  @override
  Future<List<Movie>> getUpcoming({int page = 1}) {
    return Future.value([]);
  }


}