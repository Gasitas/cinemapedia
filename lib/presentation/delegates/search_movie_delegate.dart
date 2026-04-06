


import 'package:animate_do/animate_do.dart';
import 'package:cinemapedia/domain/entities/movie.dart';
import 'package:flutter/material.dart';

typedef SearchMoviesCallback = Future<List<Movie>> Function(String query);

class SearchMovieDelegate extends SearchDelegate{

  final SearchMoviesCallback searchMovies; // Función de busqueda(String query) {

  SearchMovieDelegate(this.searchMovies);

  @override
  String? get searchFieldLabel => 'Buscar película';
  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      //if (query.isNotEmpty)
        FadeIn(
          animate: query.isNotEmpty,
          child: IconButton(onPressed: () {
            query = '';
          }, icon: Icon(Icons.clear)),
        ),
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(onPressed: () {
      close(context, null);
    }, icon: Icon(Icons.arrow_back_ios_new_outlined));
  }


  @override
  Widget buildResults(BuildContext context) {
    return const Text('build results');
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return FutureBuilder(
      future: searchMovies(query),
      builder: (_, AsyncSnapshot<List<Movie>> snapshot) {
        if (snapshot.hasData) {
          final movies = snapshot.data!;
          return ListView.builder(
            itemCount: movies.length,
            itemBuilder: (_, int index) => _MovieItem(movie: movies[index], onMovieSelected: close),
          );
        } else {
          return const Center(child: CircularProgressIndicator());
        }
      },
    );
  }

}

class _MovieItem extends StatelessWidget {



  

  const _MovieItem( {required this.movie, required this.onMovieSelected});
  final Movie movie;
  final Function onMovieSelected;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        onMovieSelected(context, movie);
        //Navigator.pushNamed(context, 'movie_detail', arguments: movie);
      },
      child: SizedBox(
        //height: 120,
        child: Row(
          children: [
            Container(
              width: 85,
              height: 85,
              margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: Image.network(
                  movie.posterPath,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            SizedBox(width: 10,),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                  movie.title,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 12),
                             ),
                  Text(
                    movie.overview,
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(fontSize: 12,),
                  ),
                ],
              ),
          ),
          ],
        ),
      ),
    );
  }
}