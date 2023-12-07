import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../config/helpers/human_formats.dart';
import '../../providers/providers.dart';
import '../../widgets/widgets.dart';

class HomeView extends ConsumerStatefulWidget {
  const HomeView({super.key});

  @override
  HomeViewState createState() => HomeViewState();
}

class HomeViewState extends ConsumerState<HomeView> {
  @override
  void initState() {
    super.initState();

    ref.read(nowPlayingMoviesProvider.notifier).loadNextPage();
    ref.read(popularMoviesProvider.notifier).loadNextPage();
    ref.read(upcomingMoviesProvider.notifier).loadNextPage();
    ref.read(topRatedMoviesProvider.notifier).loadNextPage();
  }

  @override
  Widget build(BuildContext context) {
    final initialLoading = ref.watch(initialLoadingProvider);
    if (initialLoading) {
      return const FullScreenLoader(); //* Pantalla de carga antes de obtener la data de las peliculas
    }

    final slideShowMovies = ref.watch(moviesSlideshowProvider);
    final nowPlayingMovies = ref.watch(nowPlayingMoviesProvider);
    final popularMovies = ref.watch(popularMoviesProvider);
    final upcomingMovies = ref.watch(upcomingMoviesProvider);
    final topRatedMovies = ref.watch(topRatedMoviesProvider);

    return CustomScrollView(slivers: [
      const SliverAppBar(
        floating: true,
        flexibleSpace: FlexibleSpaceBar(),
        title: CustomAppbar(),
      ),
      SliverList(
          delegate: SliverChildBuilderDelegate((context, index) {
        return Column(
          children: [
            // const CustomAppbar(),
            MoviesSlideshow(movies: slideShowMovies),
            MovieHorizontalListview(
              movies: nowPlayingMovies,
              title: 'En cines',
              subTitle: HumanFormats.date(DateTime.now()),
              loadNextPage: () {
                ref
                    .read(nowPlayingMoviesProvider.notifier)
                    .loadNextPage(); //* Scroll infinito en la seccion 'En Cines'
              },
            ),
            MovieHorizontalListview(
              movies: upcomingMovies,
              title: 'Proximamente',
              subTitle: 'En este mes',
              loadNextPage: () {
                ref
                    .read(upcomingMoviesProvider.notifier)
                    .loadNextPage(); //* Scroll infinito en la seccion 'Proximamente'
              },
            ),
            MovieHorizontalListview(
              movies: popularMovies,
              title: 'Populares',
              loadNextPage: () {
                ref
                    .read(popularMoviesProvider.notifier)
                    .loadNextPage(); //* Scroll infinito en la seccion 'Populares'
              },
            ),
            MovieHorizontalListview(
              movies: topRatedMovies,
              title: 'Mejor calificadas',
              subTitle: 'Desde siempre',
              loadNextPage: () {
                ref
                    .read(topRatedMoviesProvider.notifier)
                    .loadNextPage(); //* Scroll infinito en la seccion 'Mejor calificadas'
              },
            ),
            const SizedBox(
              height: 10,
            )
          ],
        );
      }, childCount: 1)),
    ]);
  }
}
