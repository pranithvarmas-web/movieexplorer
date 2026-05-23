import 'package:flutter/material.dart';
import 'package:movie_db_assign/constants/constants.dart';
import 'package:movie_db_assign/models/movie_model.dart';
import 'package:movie_db_assign/presentation/upcoming/widgets/upcoming_details_gesture.dart';
class UpcomingSizedBox extends StatelessWidget {
  const UpcomingSizedBox({
    super.key,
    required this.movies,
  });
  final List<MovieModel> movies;
  @override
  Widget build(BuildContext context) {
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
              child: UpcomingDetailsGesture(imageUrl: imageUrl, movieModel: movie),
          );
        },
      ),
    );
  }
}