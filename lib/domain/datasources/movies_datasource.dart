//* Esta clase define los metodos que voy a llamar para traer la data del domain/entity
import 'package:cinemapp/domain/entities/movie.dart';
import 'package:cinemapp/domain/entities/video.dart';

abstract class MoviesDatasource {
  Future<List<Movie>> getNowPlaying({int page = 1});

  Future<List<Movie>> getPopular({int page = 1});

  Future<List<Movie>> getUpcoming({int page = 1});

  Future<List<Movie>> getTopRated({int page = 1});

  Future<Movie> getMovieById(String id);

  Future<List<Movie>> searchMovies(String query);

  Future<List<Movie>> getSimilarMovies(int movieId);

  Future<List<Video>> getYoutubeVideosById(int movieId);
}
