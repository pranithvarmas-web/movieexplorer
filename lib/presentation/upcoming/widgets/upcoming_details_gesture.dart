import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
import 'package:movie_db_assign/models/movie_model.dart';
import 'package:movie_db_assign/presentation/upcoming/blocs/upcoming_bloc.dart';
import 'package:movie_db_assign/presentation/upcoming/pages/movies_upcoming_details_page.dart';
import 'package:movie_db_assign/repository/repo_api.dart';

class UpcomingDetailsGesture extends StatelessWidget {
  const UpcomingDetailsGesture({
    super.key,
    required this.imageUrl,
    required this.movieModel,
  });

  final String imageUrl;
  final MovieModel movieModel;

  @override
  Widget build(BuildContext context) {
    final Box<MovieModel> moviesBoxUpComing = Hive.box<MovieModel>('moviesUpComing');

    return GestureDetector(
      onTap: () {
        final movieId = movieModel.id;
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => BlocProvider(
              create: (context) =>
              UpcomingBloc(RepoApi(),moviesBoxUpComing)..add(GetUpcomingMovieDetails(movieId)),
              child: MoviesUpComingDetailsPage(movie: movieModel),
            ),
          ),
        );
      },
      child: ClipRRect(
        borderRadius: BorderRadius.circular(8.0),
        child: Hero(
          tag: 'upcoming-movie-${movieModel.id}',
          child: Container(
            height: 260,
            width: 140,
            child:CachedNetworkImage(
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
