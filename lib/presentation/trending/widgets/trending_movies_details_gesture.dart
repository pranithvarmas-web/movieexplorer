import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
import 'package:movie_db_assign/models/movie_model.dart';
import 'package:movie_db_assign/presentation/trending/bloc/trending_bloc.dart';
import 'package:movie_db_assign/presentation/trending/pages/now_playing_details.dart';
import 'package:movie_db_assign/repository/repo_api.dart';
import 'package:cached_network_image/cached_network_image.dart';

class TrendingMoviesDetailsGesture extends StatelessWidget {
  const TrendingMoviesDetailsGesture({
    super.key,
    required this.itemWidth,
    required this.scale,
    required this.opacity,
    required this.imageUrl,
    required this.movieModel,
  });

  final double itemWidth;
  final double scale;
  final double opacity;
  final String imageUrl;
  final MovieModel movieModel;

  @override
  Widget build(BuildContext context) {
    final Box<MovieModel> moviesBoxTrending = Hive.box<MovieModel>('moviesTrending');

    return GestureDetector(
      onTap: () {
        final movieId = movieModel.id;
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => BlocProvider(
              create: (context) =>
              TrendingBloc(RepoApi(), moviesBoxTrending)..add(GetMovieDetails(movieId)),
              child: MovieDetailsPage(movie: movieModel),
            ),
          ),
        );
      },
      child: Container(
        width: itemWidth,
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        child: Transform.scale(
          scale: scale,
          child: Opacity(
            opacity: opacity,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Hero(
                tag: 'movie-${movieModel.id}',
                child: Container(
                  decoration: const BoxDecoration(
                    color: Colors.teal,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black26,
                        blurRadius: 6,
                        offset: Offset(0, 4),
                      ),
                    ],
                  ),
                  child: CachedNetworkImage(
                    imageUrl: imageUrl,
                    placeholder: (context, url) => const Center(child: CircularProgressIndicator()),
                    errorWidget: (context, url, error) => const Icon(Icons.error),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
