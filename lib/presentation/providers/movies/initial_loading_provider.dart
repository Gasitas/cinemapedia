

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:cinemapedia/presentation/providers/providers.dart';

final initialLoadingProvider = Provider<bool>((ref) {
  final nowPlaying = ref.watch(nowPlayingMoviesProvider);
  final upcoming = ref.watch(upcomingMoviesProvider);
  final popular = ref.watch(popularMoviesProvider);
  final topRated = ref.watch(topRatedMoviesProvider);

  return nowPlaying.isEmpty || upcoming.isEmpty || popular.isEmpty || topRated.isEmpty;
});