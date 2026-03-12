import 'package:cinemapedia/infrastructure/models/moviedb/actordb_response.dart';

import '../../domain/entities/cast.dart';

class CastMapper {
  static Cast fromCastDBToEntity(CastMovie castMovie) {
    return Cast(
      id: castMovie.id,
      name: castMovie.name,
      profilePath: castMovie.profilePath,
      gender: castMovie.gender,

    );
}
}