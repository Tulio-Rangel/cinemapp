import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:cinemapp/infrastructure/datasources/actor_moviedb_datasource.dart';
import 'package:cinemapp/infrastructure/repositories/actor_repository_impl.dart';

//* Este repositorio es inmutable
final actorsRepositoryProvider = Provider((ref) {
  return ActorRepositoryImpl(ActorMovieDbDatasource());
});
