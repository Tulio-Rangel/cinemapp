import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:cinemapp/domain/entities/movie.dart';
import 'package:cinemapp/presentation/providers/providers.dart';

//* Estado del query de la busqueda
final searchQueryProvider = StateProvider<String>((ref) => '');

//* Estado de las peliculas ya buscadas en el search
final searchedMoviesProvider =
    StateNotifierProvider<SearchedMoviesNotifier, List<Movie>>((ref) {
  final movieRepository = ref.read(movieRepositoryProvider);

  return SearchedMoviesNotifier(
      searchedMovies: movieRepository.searchMovies, ref: ref);
});

typedef SearchMoviesCallback = Future<List<Movie>> Function(String query);

class SearchedMoviesNotifier extends StateNotifier<List<Movie>> {
  final SearchMoviesCallback searchedMovies;
  final Ref ref;

  SearchedMoviesNotifier({required this.searchedMovies, required this.ref})
      : super([]);

  Future<List<Movie>> searchMovieByQuery(String query) async {
    final List<Movie> movies = await searchedMovies(query);
    ref.read(searchQueryProvider.notifier).update((state) => query);

    state = movies;

    return movies;
  }
}
