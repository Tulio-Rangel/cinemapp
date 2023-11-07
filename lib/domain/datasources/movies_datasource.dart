// Esta clase define los metodos que voy a llamar para traer la data del domain/entity
import 'package:cinemapp/domain/entities/movie.dart';

abstract class MoviesDatasource {
  Future<List<Movie>> getNowPlaying({int page = 1});
}
