import 'package:cinemapedia/domain/entities/movie.dart';
import 'package:cinemapedia/infrastructure/models/moviedb/movie_details.dart';
import 'package:cinemapedia/infrastructure/models/moviedb/movie_moviedb.dart';

class MovieMapper {
  static Movie fromMovieDBToEntity(MovieMovieDB movieDB) => Movie(
        adult: movieDB.adult,
        backdropPath: (movieDB.backdropPath != '') ? 'https://image.tmdb.org/t/p/w500${movieDB.backdropPath}' : 'https://i.stack.imgur.com/GNhxO.png',
        genreIds: movieDB.genreIds.map((id) => id.toString()).toList(),
        id: movieDB.id,
        originalLanguage: movieDB.originalLanguage,
        originalTitle: movieDB.originalTitle,
        overview: movieDB.overview,
        popularity: movieDB.popularity*1000,
        posterPath: (movieDB.posterPath != '')
            ? 'https://image.tmdb.org/t/p/w500${movieDB.posterPath}'
            : 'no-poster',
        releaseDate: movieDB.releaseDate,
        title: movieDB.title,
        video: movieDB.video,
        voteAverage: movieDB.voteAverage,
        voteCount: movieDB.voteCount,
      );

      static Movie fromMovieDetailsDBToEntity(MovieDetails movieDetails) => Movie(
        adult: movieDetails.adult,
        backdropPath: (movieDetails.backdropPath != '') ? 'https://image.tmdb.org/t/p/w500${movieDetails.backdropPath}' : 'https://i.stack.imgur.com/GNhxO.png',
        genreIds: movieDetails.genres.map((genre) => genre.id.toString()).toList(),
        id: movieDetails.id,
        originalLanguage: movieDetails.originalLanguage,
        originalTitle: movieDetails.originalTitle,
        overview: movieDetails.overview,
        popularity: movieDetails.popularity*1000,
        posterPath: (movieDetails.posterPath != '')
            ? 'https://image.tmdb.org/t/p/w500${movieDetails.posterPath}'
            : 'no-poster',
        releaseDate: movieDetails.releaseDate,
        title: movieDetails.title,
        video: movieDetails.video,
        voteAverage: movieDetails.voteAverage,
        voteCount: movieDetails.voteCount,
      );
}