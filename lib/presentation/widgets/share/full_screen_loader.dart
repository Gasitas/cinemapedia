import 'package:flutter/material.dart';

class FullScreenLoader extends StatelessWidget {
   FullScreenLoader({super.key});

  final messages = [
    'Cargando...',
    'Obteniendo datos...',
    'Preparando la experiencia...',
    'Casi listo...',
    'Un momento por favor...'
  ];

  Stream<String> get messagesStream async* {
    for (final message in messages) {
      yield message;
      await Future.delayed(const Duration(seconds: 2));
    }
  }

  @override
  Widget build(BuildContext context) {
    return 
      Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const CircularProgressIndicator(),
            const SizedBox(height: 20),
            StreamBuilder(stream: messagesStream, builder:(context, snapshot) {
              if (snapshot.hasData) {
                return Text(snapshot.data!, style: Theme.of(context).textTheme.titleMedium,);
              }
              return const SizedBox();
            },)

          ],
        ),
      );
  }
}