import 'package:cinemapedia/domain/entities/actor.dart';
import 'package:cinemapedia/infrastructure/models/moviedb/actor_actordb.dart';

class ActorMapper {
  static Actor fromActorDBToEntity(ActorActorDb actorDb) {
    return Actor(
      id: actorDb.id,
      name: actorDb.name,
      profilePath: actorDb.profilePath,
      placeOfBirth: actorDb.placeOfBirth,
      biography: actorDb.biography,

    );

    
  }
}