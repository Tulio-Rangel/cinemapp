import 'package:cinemapp/domain/entities/actor.dart';
import 'package:cinemapp/infrastructure/models/moviedb/credits_response.dart';

//* Mapea la respuesta de la API a como defini mi entidad
class ActorMapper {
  static Actor castToEntity(Cast cast) => Actor(
      id: cast.id,
      name: cast.name,
      profilePath: cast.profilePath != null
          ? 'https://image.tmdb.org/t/p/w500${cast.profilePath}'
          : 'https://www.pngitem.com/pimgs/m/287-2876223_no-profile-picture-available-hd-png-download.png',
      character: cast.character);
}
