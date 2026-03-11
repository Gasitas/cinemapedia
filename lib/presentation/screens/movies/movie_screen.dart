import 'package:cinemapedia/domain/entities/movie.dart';
import 'package:cinemapedia/presentation/providers/movies/movie_info_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class MovieScreen extends ConsumerStatefulWidget {

  static const name = 'movie-screen';
  
  final String moveiId;
  const MovieScreen({super.key, required this.moveiId});

  @override
  MovieScreenState   createState() => MovieScreenState();
}

class MovieScreenState extends ConsumerState<MovieScreen> {

  @override
  void initState() {
    super.initState();
    ref.read(movieInfoProvider.notifier).loadMovie(widget.moveiId); // Cargamos los detalles de la película utilizando el provider movieProvider. Esto se hace llamando al método loadMovie() del MovieNotifier a través del provider movieProvider, pasando el ID de la película que se obtiene de widget.moveiId. De esta manera, cuando se muestre la pantalla, ya se tendrán cargados los detalles de la película para mostrar al usuario.
    // Aquí podríamos cargar los detalles de la película utilizando el widget.moveiId para obtener la información de la película desde una API o una base de datos. Esto se haría típicamente utilizando un provider o un state management para manejar el estado de la película y actualizar la UI en consecuencia.
  }

  @override
  Widget build(BuildContext context) {

    final Movie? actualMovie = ref.watch(movieInfoProvider)[widget.moveiId];
    
    if (actualMovie == null) {
      return const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }
    return Scaffold(
      body: CustomScrollView(
        physics: const ClampingScrollPhysics(),
        slivers: [
          _CustomSliverAppBar(actualMovie),
          SliverList(
            delegate: SliverChildBuilderDelegate(
              (context, index) => _MovieDetails(actualMovie),
              childCount: 1,
            ),
          )
        ],
      )
    );
  }
}

class _MovieDetails extends StatelessWidget {
  final Movie movie;
  const _MovieDetails(this.movie);

  @override
  Widget build(BuildContext context) {

    //final size = MediaQuery.of(context).size;
    final textStyles = Theme.of(context).textTheme;

    return Container(
      padding: const EdgeInsets.all(8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(padding: EdgeInsets.all(8)),
          Text(movie.title, style: textStyles.titleLarge, textAlign: TextAlign.left),
          SizedBox(height: 10,),
          Text(movie.overview),
          SizedBox(height: 10),
          Padding(padding:  EdgeInsets.all(8),
          child: Wrap(
            spacing: 10,
            children: [
              ...movie.genreIds.map((genre) => Chip(label: Text(genre))),
            ],
          ),),
        ],
      ),
    );
  }
}


class _CustomSliverAppBar extends StatelessWidget {

  final Movie movie;
  const _CustomSliverAppBar(
    this.movie,
  );

  @override
  Widget build(BuildContext context) {

    final size = MediaQuery.of(context).size;
    
    return SliverAppBar(
      backgroundColor: Colors.black,
      expandedHeight: size.height*0.5,
      foregroundColor: Colors.white,
      flexibleSpace: FlexibleSpaceBar(
        titlePadding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        /*title: Text(movie.title,
          style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white),
          textAlign: TextAlign.start,
        ),*/
        background: Stack(
          children: [
            SizedBox.expand(
              child: Image.network(
                movie.posterPath,
                fit: BoxFit.cover,
                loadingBuilder: (context, child, loadingProgress) {
                  if (loadingProgress == null) return child;
                  return Container(
                    padding: const EdgeInsets.all(8),
                    child: const Center(child: CircularProgressIndicator()),
                  );
                },
              ),
            ),
                SizedBox.expand(
                  child: DecoratedBox(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          Colors.black87,
                          Colors.transparent,
                          Colors.transparent,
                          Colors.black87,
                        ],
                        stops: const [ 0, 0.3, 0.8, 1],
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                      )
                    ),
                  ),
                ),


          ],),
      ),
    );
  }
}