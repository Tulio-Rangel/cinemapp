import 'package:cinemapp/presentation/providers/providers.dart';
import 'package:cinemapp/presentation/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class FavoritesView extends ConsumerStatefulWidget {
  const FavoritesView({super.key});

  @override
  FavoritesViewState createState() => FavoritesViewState();
}

class FavoritesViewState extends ConsumerState<FavoritesView> {
  bool isLastPage = false;
  bool isLoading = false;

  @override
  void initState() {
    super.initState();

    loadNextPage();
  }

  void loadNextPage() async {
    if (isLoading || isLastPage) return;
    isLoading = true;

    final movies =
        await ref.read(favoriteMoviesProvider.notifier).loadNextPage();
    isLoading = false;

    if (movies.isEmpty) {
      isLastPage = true;
    }
  }

  @override
  Widget build(BuildContext context) {
    final favoritesMovies = ref
        .watch(favoriteMoviesProvider)
        .values
        .toList(); //* Convierto el mapa en una lista

    if (favoritesMovies.isEmpty) {
      final colors = Theme.of(context).colorScheme;
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Icon(
              Icons.favorite_outline_sharp,
              size: 60,
              color: colors.primary,
            ),
            Text(
              'Ohhh no!!!',
              style: TextStyle(fontSize: 30, color: colors.primary),
            ),
            const Text(
              'No tienes películas favoritas',
              style: TextStyle(fontSize: 20, color: Colors.black45),
            )
          ],
        ),
      );
    }

    return Scaffold(
        body:
            MovieMasonry(loadNextPage: loadNextPage, movies: favoritesMovies));
  }
}
