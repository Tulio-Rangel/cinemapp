import 'package:dio/dio.dart';
import 'package:cinemapp/domain/datasources/actors_datasource.dart';
import 'package:cinemapp/domain/entities/actor.dart';
import 'package:cinemapp/infrastructure/mappers/actor_mapper.dart';
import 'package:cinemapp/infrastructure/models/moviedb/credits_response.dart';

import '../../config/constants/environment.dart';

class ActorMovieDbDatasource extends ActorsDatasource {
  final dio = Dio(BaseOptions(
      baseUrl: 'https://api.themoviedb.org/3',
      queryParameters: {
        'api_key': Environment.theMovieDbKey,
        'language': 'es-MX'
      }));

  //* Implementar la funcion para obtener los actores
  @override
  Future<List<Actor>> getActorsByMovie(String movieId) async {
    //* Se hace la peticcion HTTP por medio de dio
    final response = await dio.get('/movie/$movieId/credits');

    //* La respuesta de dio se pasa de json a CreditsResponse
    final castResponse = CreditsResponse.fromJson(response.data);

    //* Se mapea/transforma de CastResponse a tipo Actor con la funcion castToEntity
    List<Actor> actors = castResponse.cast
        .map((cast) => ActorMapper.castToEntity(cast))
        .toList();

    //* Retornamos lista de actores
    return actors;
  }
}
