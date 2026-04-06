
import 'package:cinemapedia/presentation/delegates/search_movie_delegate.dart';
import 'package:cinemapedia/presentation/providers/providers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class CustomAppbar extends ConsumerWidget {
  const CustomAppbar({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {

    final colors = Theme.of(context).colorScheme; 
    final textStyles = Theme.of(context).textTheme.titleMedium;
    // Obtenemos el esquema de colores actual del tema utilizando Theme.of(context).colorScheme. Esto nos permite acceder a los colores definidos en el tema de la aplicación y utilizarlos para estilizar los widgets de manera consistente con el diseño general de la aplicación. En este caso, se utiliza colors.primary para establecer el color del ícono de la película, asegurando que se integre visualmente con el resto de la interfaz de usuario.
    return SafeArea(
      bottom: false,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        child: SizedBox(
          width: double.infinity,
          child: Row(
            children: [
              Icon(Icons.movie_outlined, color: colors.primary, size: 30,), 
              SizedBox(width: 5,),
              Text(
                'Cinemapedia',
                style: textStyles?.copyWith(color: colors.primary, fontWeight: FontWeight.bold), // Establecemos el estilo del texto utilizando textStyles obtenido del tema, y modificamos el color y el peso de la fuente para que se destaque en la barra de navegación. Esto asegura que el texto se vea bien integrado con el diseño general de la aplicación y sea fácilmente legible para los usuarios.
              ),
              Spacer(),
              IconButton(onPressed: () async{
                final searchFunction = ref.read(movieRepositoryProvider);
                //delegate es el que trabaja la búsqueda
                final movie = await showSearch(context: context, delegate: SearchMovieDelegate( searchFunction.searchMovies),);
                  if (movie != null && context.mounted) {
                    context.push('/movie/${movie.id}');
                  }
              } , icon: Icon(Icons.search_outlined))
            ],
          ),
        ),
      ),
    );
  }
}

