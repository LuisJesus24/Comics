import 'package:moviedb/domain/entities/actor.dart';
import 'package:moviedb/infrastructure/models/moviedb/credits_reponse.dart';

class ActorMapper {
  static Actor castToEntity(Cast cast) =>
      Actor(
        id: cast.id, 
        name: cast.name, 
        profilePath: cast.profilePath != null 
                      ? 'https://image.tmdb.org/t/p/w500${ cast.profilePath }'
                      : 'https://cdn-icons-png.flaticon.com/512/12225/12225935.png', 
        character: cast.character
      );
}
