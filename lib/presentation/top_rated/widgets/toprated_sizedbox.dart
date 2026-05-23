import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_db_assign/constants/constants.dart';
import 'package:movie_db_assign/models/movie_model.dart';
import 'package:movie_db_assign/presentation/top_rated/blocs/top_rated_bloc.dart';
import 'package:movie_db_assign/presentation/top_rated/pages/movies_toprated_details_page.dart';
import 'package:movie_db_assign/presentation/top_rated/widgets/toprated_details_gesture.dart';

class TopRatedSizedBox extends StatelessWidget {
  const TopRatedSizedBox({
    super.key,
    required this.movies,
  });

  final List<MovieModel> movies;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<TopRatedBloc, TopRatedState>(
      listener: (context, state) {
        if (state is TopRatedSelected) {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => MoviesTopRatedDetailsPage(movie: state.selectedMovie),
            ),
          );
        }
      },
      builder: (context, state) {
        return SizedBox(
          height: 300,
          width: double.infinity,
          child: ListView.builder(
            physics: BouncingScrollPhysics(),
            scrollDirection: Axis.horizontal,
            itemCount: movies.length,
            itemBuilder: (context, index) {
              final movie = movies[index];
              final imageUrl = '${Constants.imagePath}${movie.backdrop_path}';

              return Padding(
                padding: const EdgeInsets.all(11),
                child: TopRatedDetailsGesture(imageUrl: imageUrl, movieModel: movie),
              );
            },
          ),
        );
      },
    );
  }
}

