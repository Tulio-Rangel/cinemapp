import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:cinemapp/infrastructure/datasources/moviedb_datasource.dart';
import 'package:cinemapp/infrastructure/repositories/movie_repository_impl.dart';

//* Este provider no se va a modificar asi que puede ser de solo lectura, es inmutable
final movieRepositoryProvider = Provider((ref) {
  return MovieRespositoryImpl(MoviedbDatasource());
});
