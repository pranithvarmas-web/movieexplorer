import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
import 'package:movie_db_assign/models/movie_model.dart';
import 'package:movie_db_assign/presentation/top_rated/blocs/top_rated_bloc.dart';
import 'package:movie_db_assign/presentation/top_rated/pages/movies_toprated_details_page.dart';
import 'package:movie_db_assign/repository/repo_api.dart';

class TopRatedDetailsGesture extends StatelessWidget {
  const TopRatedDetailsGesture({
    super.key,
    required this.imageUrl,
    required this.movieModel,
  });

  final String imageUrl;
  final MovieModel movieModel;

  @override
  Widget build(BuildContext context) {
    final Box<MovieModel> moviesBoxTopRated = Hive.box<MovieModel>('moviesTopRated');

    return GestureDetector(
      onTap: () {
        final movieId = movieModel.id;
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => BlocProvider(
              create: (context) =>
              TopRatedBloc(RepoApi(),moviesBoxTopRated)..add(GetTopRatedMovieDetails(movieId)),
              child: MoviesTopRatedDetailsPage(movie: movieModel),
            ),
          ),
        );
      },
      child: ClipRRect(
        borderRadius: BorderRadius.circular(8.0),
        child: Hero(
          tag: 'top-rated-movie-${movieModel.id}',
          child: Container(
            height: 260,
            width: 140,
            child: CachedNetworkImage(
              imageUrl: imageUrl,
              placeholder: (context, url) => const Center(child: CircularProgressIndicator()),
              errorWidget: (context, url, error) => const Icon(Icons.error),
              fit: BoxFit.cover,
            ),
          ),
        ),
      ),
    );
  }
}
