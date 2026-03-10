import 'package:cinemapedia/config/constants/environment.dart';
import 'package:cinemapedia/domain/datasources/movies_datasource.dart';
import 'package:cinemapedia/domain/entities/movie.dart';
import 'package:cinemapedia/infrastructure/mappers/movie_mapper.dart';
import 'package:cinemapedia/infrastructure/models/moviedb/movie_details.dart';
import 'package:cinemapedia/infrastructure/models/moviedb/movie_moviedb.dart';
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
    List<Movie> movies = _jsonToMovies(response); // Mapear cada MovieMovieDB a Movie usando el MovieMapper 
    
    return movies;
  }

  List<Movie> _jsonToMovies(Response<dynamic> response) {
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
        List<Movie> movies = _jsonToMovies(response); // Mapear cada MovieMovieDB a Movie usando el MovieMapper 

    
    return movies;
  }

  @override
  Future<List<Movie>> getTopRated({int page = 1}) async {
    final Response response = await dio.get('/movie/top_rated', queryParameters: {
      'page': page,
    });
    List<Movie> movies = _jsonToMovies(response); // Mapear cada MovieMovieDB a Movie usando el MovieMapper 

    return movies;
  }

  @override
  Future<List<Movie>> getUpcoming({int page = 1}) async {
     final Response response = 
     
     await dio.get('/movie/upcoming', queryParameters: {
      'page': page,
    });
    List<Movie> movies = _jsonToMovies(response); // Mapear cada MovieMovieDB a Movie usando el MovieMapper 

    
    return movies;
  }

  @override
  Future<Movie> getMovieById(String id) async {
    final Response response = await dio.get('/movie/$id');
    if (response.statusCode != 200) throw Exception('Movie with id: $id not found');
    final movieDb = MovieDetails.fromJson(response.data); // Si la respuesta no es exitosa, lanzar una excepción indicando que la película con el ID especificado no se encontró.
    final Movie movie = MovieMapper.fromMovieDetailsDBToEntity(movieDb);
    return movie;
  }


}