import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_db_assign/constants/constants.dart';
import 'package:movie_db_assign/models/movie_model.dart';
import 'package:movie_db_assign/presentation/popular/blocs/popular_bloc.dart';
import 'package:movie_db_assign/presentation/popular/pages/popular_details_page.dart';
import 'package:movie_db_assign/presentation/popular/widgets/popular_details_gesture.dart';

class PopularSizedBox extends StatelessWidget {
  const PopularSizedBox({
    super.key,
    required this.movies,
  });

  final List<MovieModel> movies;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<PopularBloc, PopularState>(
      listener: (context, state) {
        if (state is PopularMovieSelected) {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => MoviesPopularDetailsPage(movie: state.selectedMovie),
            ),
          );
        }
      },
      builder: (context, state) {
        return SizedBox(
          height: 200,
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
                child: PopularDetailsGesture(imageUrl: imageUrl, movieModel: movie),
              );
            },
          ),
        );
      },
    );
  }
}

