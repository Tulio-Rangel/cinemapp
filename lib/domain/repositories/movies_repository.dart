// El repositorio es quien va a llamar el datasource
import 'package:cinemapp/domain/entities/movie.dart';

abstract class MoviesRepository {
  Future<List<Movie>> getNowPlaying({int page = 1});
}
