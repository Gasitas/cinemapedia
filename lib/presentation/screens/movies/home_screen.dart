import 'package:cinemapedia/presentation/providers/providers.dart';
import 'package:cinemapedia/presentation/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  static const name = 'home-screen';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: _HomeView(),
      ),
      bottomNavigationBar: CustomBottomNavigation(),
    );
  }
}

class _HomeView extends ConsumerStatefulWidget {
  const _HomeView();

  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends ConsumerState<_HomeView> {

  @override
  void initState() {
    super.initState();
    ref.read(nowPlayingMoviesProvider.notifier).loadNextPage(); // Cargamos la primera página de películas populares al iniciar la pantalla. Esto se hace llamando al método loadNextPage() del MoviesNotifier a través del provider popularMoviesProvider. De esta manera, cuando se muestre la pantalla, ya se tendrán cargadas las películas populares para mostrar al usuario.
  }

  @override
  Widget build(BuildContext context) {
    final movies = ref.watch(movieSlideshowProvider);  // Obtenemos la lista de películas en cartelera utilizando el provider movieSlideshowProvider. Esto nos permite acceder a la lista de películas que se ha cargado en el MoviesNotifier y mostrarla en el slideshow de la UI.

    
    return Column(
      children: [
        CustomAppbar(),
        MoviesSlideshow(movies: movies),
        MoviesHorizontalSlideshow(movies: movies, title: 'Películas en Cartelera', subtitle: 'Lunes 20',) // Mostramos el slideshow de películas en cartelera utilizando el widget MoviesSlideshow y pasando la lista de películas obtenida del provider movieSlideshowProvider. De esta manera, se mostrará el slideshow con las películas en cartelera al usuario.
      ],
    );
    // Obtenemos la lista de películas en cartelera utilizando el provider nowPlayingMoviesProvider. Esto nos permite acceder a la lista de películas que se ha cargado en el MoviesNotifier y mostrarla en la UI. 
    //return Placeholder();
  }
}