import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:cinemapp/presentation/widgets/movies/movie_poster_link.dart';
import 'package:cinemapp/domain/entities/movie.dart';

class MovieMasonry extends StatefulWidget {
  final List<Movie> movies;
  final VoidCallback? loadNextPage;
  const MovieMasonry({super.key, required this.movies, this.loadNextPage});

  @override
  State<MovieMasonry> createState() => _MovieMasonryState();
}

class _MovieMasonryState extends State<MovieMasonry> {
  // TODO InitSate

  //TODO: dispose

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: MasonryGridView.count(
          crossAxisCount: 3,
          itemCount: widget.movies.length,
          mainAxisSpacing: 10,
          crossAxisSpacing: 10,
          itemBuilder: (context, index) {
            if (index == 1) {
              return Column(children: [
                const SizedBox(
                  height: 15,
                ),
                MoviePosterLink(movie: widget.movies[index])
              ]);
            }
            return MoviePosterLink(movie: widget.movies[index]);
          }),
    );
  }
}
