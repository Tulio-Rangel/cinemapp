// El repositorio es quien va a llamar el datasource
import 'package:cinemapp/domain/entities/movie.dart';

abstract class MovieRepository {
  Future<List<Movie>> getNowPlaying({int page = 1});
}
