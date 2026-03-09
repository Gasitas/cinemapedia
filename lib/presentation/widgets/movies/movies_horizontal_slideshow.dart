import 'package:animate_do/animate_do.dart';
import 'package:cinemapedia/config/helpers/human_formats.dart';
import 'package:cinemapedia/domain/entities/movie.dart';
import 'package:flutter/material.dart';

class MoviesHorizontalSlideshow extends StatelessWidget {
  final List<Movie> movies;
  final String? title;
  final String? subtitle;
  final VoidCallback? onNextPage;

  const MoviesHorizontalSlideshow({
    super.key,
    required this.movies,
    this.title,
    this.subtitle,
    this.onNextPage,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 340,
      child: Column(
        children: [
          if (title != null || subtitle != null)
            _Title(title: title, subtitle: subtitle),
          Expanded(child: _ListMovies(movies: movies, onNextPage: onNextPage)),
        ],
      ),
    );
  }
}

class _ListMovies extends StatefulWidget {
  const _ListMovies({required this.movies, this.onNextPage});

  final List<Movie> movies;
  final VoidCallback? onNextPage;

  @override
  State<_ListMovies> createState() => _ListMoviesState();
}

class _ListMoviesState extends State<_ListMovies> {

  final scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    scrollController.addListener(() {
      if (widget.onNextPage == null) return ;
      if (scrollController.position.pixels >= scrollController.position.maxScrollExtent - 500) {
        // Llamamos al callback onNextPage para cargar la siguiente página de películas cuando el usuario se acerque al final del scroll.
        widget.onNextPage?.call();
      }
    });
  }

  @override
  dispose() {
    scrollController.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      physics: const BouncingScrollPhysics(),
      controller: scrollController,
      scrollDirection: Axis.horizontal,
      itemCount: widget.movies.length,
      itemBuilder: (context, index) {
        final movie = widget.movies[index];
        return FadeInRight(child: _SlideMovies(movie: movie));
      },
    );
  }
}

class _SlideMovies extends StatelessWidget {
  const _SlideMovies({required this.movie});

  final Movie movie;

  @override
  Widget build(BuildContext context) {
    final textStyle = Theme.of(context).textTheme;
    
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 8),
      width: 150,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Mostramos la imagen de la película utilizando un widget Image.network. La URL de la imagen se obtiene a través de la propiedad posterPath del objeto Movie. Se utiliza un widget ClipRRect para redondear los bordes de la imagen y se establece un tamaño fijo de 150x220 píxeles. Además, se utiliza el parámetro loadingBuilder para mostrar un indicador de carga mientras se descarga la imagen, y una vez que la imagen se ha cargado, se muestra con una animación de desvanecimiento utilizando el widget FadeIn.
          SizedBox(
            width: 150,
            height: 210,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: Image.network(
                movie.posterPath,
                fit: BoxFit.cover,
                loadingBuilder: (context, child, loadingProgress) {
                  if (loadingProgress == null) return FadeIn(child: child);
                  return Container(
                    padding: const EdgeInsets.all(8),
                    child: const Center(child: CircularProgressIndicator()),
                  );
                },
              ),
            ),
          ),
          SizedBox(height: 4),
          // Mostramos el titulo de la pelicula
          SizedBox(
            width: 150,
            child: Text(
              movie.title,
              maxLines: 2,
              style: textStyle.bodySmall,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          // Rating
          Row(
            children: [
              Icon(Icons.star_half, color: Colors.yellow.shade800, size: 15),
              SizedBox(width: 4),
              Text('${movie.voteAverage}', style: textStyle.bodyMedium?.copyWith(color: Colors.yellow.shade800 )),
              SizedBox(width: 3),
              Text(HumanFormats.number(movie.popularity), style: textStyle.bodyMedium),
            ],
          ),
        ],
      ),
    );
  }
}

class _Title extends StatelessWidget {
  const _Title({required this.title, required this.subtitle});

  final String? title;
  final String? subtitle;

  @override
  Widget build(BuildContext context) {
    final titleStyle = Theme.of(context).textTheme.titleLarge;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Row(
        children: [
          if (title != null) Text(title!, style: titleStyle),
          Spacer(),
          if (subtitle != null)
            FilledButton.tonal(
              style: ButtonStyle(visualDensity: VisualDensity.compact),
              onPressed: () {},
              child: Text(subtitle!),
            ),
        ],
      ),
    );
  }
}
