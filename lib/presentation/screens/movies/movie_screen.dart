import 'package:flutter/material.dart';

class MovieScreen extends StatelessWidget {

  static const name = 'movie-screen';
  
  final String moveiId;
  const MovieScreen({super.key, required this.moveiId});



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('MovieScreen'),),
      body: Center(
        child: Text('MovieScreen: $moveiId'),
      ),
    );
  }
}