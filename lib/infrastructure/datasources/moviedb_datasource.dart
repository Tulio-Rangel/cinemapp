//* Archivo para interactuar con The MovieDB
// *Implementacion (impl) del datasource

import 'package:cinemapp/domain/entities/video.dart';
import 'package:cinemapp/infrastructure/mappers/video_mapper.dart';
import 'package:cinemapp/infrastructure/models/moviedb/moviedb_videos.dart';
import 'package:dio/dio.dart';
import 'package:cinemapp/infrastructure/models/moviedb/movie_details.dart';
import 'package:cinemapp/config/constants/environment.dart';
import 'package:cinemapp/infrastructure/mappers/movie_mapper.dart';
import 'package:cinemapp/infrastructure/models/moviedb/moviedb_response.dart';
import 'package:cinemapp/domain/datasources/movies_datasource.dart';
import 'package:cinemapp/domain/entities/movie.dart';

class MoviedbDatasource extends MoviesDatasource {
  final dio = Dio(BaseOptions(
      baseUrl: 'https://api.themoviedb.org/3',
      queryParameters: {
        'api_key': Environment.theMovieDbKey,
        'language': 'es-MX'
      }));

  List<Movie> _jsonToMovies(Map<String, dynamic> json) {
    //* Mapeo la respuesta de la API a formato de mi clase MovieDbResponse
    final movieDbResponse = MovieDbResponse.fromJson(json);
    //* Mapeo la respuesta anterior para que los originea de datos coincidan con mi entidad
    final List<Movie> movies = movieDbResponse.results
        .where((moviedb) =>
            moviedb.posterPath !=
            'no-poster') //* Si no tiene poster la pelicula no pasa
        .map((moviedb) => MovieMapper.movieDBToEntity(moviedb))
        .toList();
    return movies;
  }

  @override
  Future<List<Movie>> getNowPlaying({int page = 1}) async {
    //* Recibo la respuesta de la API
    final response =
        await dio.get('/movie/now_playing', queryParameters: {'page': page});

    return _jsonToMovies(response.data);
  }

  @override
  Future<List<Movie>> getPopular({int page = 1}) async {
    //* Recibo la respuesta de la API
    final response =
        await dio.get('/movie/popular', queryParameters: {'page': page});

    return _jsonToMovies(response.data);
  }

  @override
  Future<List<Movie>> getTopRated({int page = 1}) async {
    //* Recibo la respuesta de la API
    final response =
        await dio.get('/movie/top_rated', queryParameters: {'page': page});

    return _jsonToMovies(response.data);
  }

  @override
  Future<List<Movie>> getUpcoming({int page = 1}) async {
    //* Recibo la respuesta de la API
    final response =
        await dio.get('/movie/upcoming', queryParameters: {'page': page});

    return _jsonToMovies(response.data);
  }

  @override
  Future<Movie> getMovieById(String id) async {
    //* Se obtiene la informacion de la pelicula
    final response = await dio.get('/movie/$id');
    //* Si el id no existe se lanza una excepcion
    if (response.statusCode != 200) {
      throw Exception('Movie with id $id not found');
    }

    //* Se mapea la respuesta al modelo de MovieDetail
    final movieDetails = MovieDetails.fromJson(response.data);

    //* Se mapea la respuesta al modelo de Movie
    final Movie movie = MovieMapper.movieDetailsToEntity(movieDetails);

    return movie;
  }

  @override
  Future<List<Movie>> searchMovies(String query) async {
    if (query.isEmpty) return [];

    //* Recibo la respuesta de la API
    final response =
        await dio.get('/search/movie', queryParameters: {'query': query});

    return _jsonToMovies(response.data);
  }

  @override
  Future<List<Movie>> getSimilarMovies(int movieId) async {
    final response = await dio.get('/movie/$movieId/similar');
    return _jsonToMovies(response.data);
  }

  @override
  Future<List<Video>> getYoutubeVideosById(int movieId) async {
    final response = await dio.get('/movie/$movieId/videos');
    final moviedbVideosReponse = MoviedbVideosResponse.fromJson(response.data);
    final videos = <Video>[];

    for (final moviedbVideo in moviedbVideosReponse.results) {
      if (moviedbVideo.site == 'YouTube') {
        final video = VideoMapper.moviedbVideoToEntity(moviedbVideo);
        videos.add(video);
      }
    }

    return videos;
  }
}
