// Archivo para interactuar con The MovieDB
// Implementacion (impl) del datasource

import 'package:dio/dio.dart';

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

  @override
  Future<List<Movie>> getNowPlaying({int page = 1}) async {
    // Recibo la respuesta de la API
    final response = await dio.get('/movie/now_playing');
    // Mapeo la respuesta de la API a formato de mi clase MovieDbResponse
    final movieDbResponse = MovieDbResponse.fromJson(response.data);
    // Mapeo la respuesta anterior para que los originea de datos coincidan con mi entidad
    final List<Movie> movies = movieDbResponse.results
        .where((moviedb) =>
            moviedb.posterPath !=
            'no-poster') // Si no tiene poster la pelicula no pasa
        .map((moviedb) => MovieMapper.movieDBToEntity(moviedb))
        .toList();
    return movies;
  }
}
