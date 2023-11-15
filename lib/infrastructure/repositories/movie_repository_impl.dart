// Implemenatacion (impl) del repository
import 'package:cinemapp/domain/datasources/movies_datasource.dart';
import 'package:cinemapp/domain/entities/movie.dart';
import 'package:cinemapp/domain/repositories/movies_repository.dart';

class MovieRespositoryImpl extends MoviesRepository {
  final MoviesDatasource datasource;

  MovieRespositoryImpl(this.datasource);

  @override
  Future<List<Movie>> getNowPlaying({int page = 1}) {
    return datasource.getNowPlaying(page: page);
  }

  @override
  Future<List<Movie>> getPopular({int page = 1}) {
    return datasource.getPopular(page: page);
  }
}
