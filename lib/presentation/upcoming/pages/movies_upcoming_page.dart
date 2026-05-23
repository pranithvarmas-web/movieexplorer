import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_db_assign/constants/constants.dart';
import 'package:movie_db_assign/presentation/upcoming/blocs/upcoming_bloc.dart';
import 'package:movie_db_assign/presentation/upcoming/pages/movies_upcoming_details_page.dart';

class MoviesUpcomingPage extends StatelessWidget {
  final String title;

  const MoviesUpcomingPage({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: BlocConsumer<UpcomingBloc, UpcomingState>(
        listener: (context, state) {
          if (state is UpcomingError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.message)),
            );
          }
        },
        builder: (context, state) {
          if (state is UpcomingInitial) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is UpcomingLoaded) {
            final movies = state.movies;
            return GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  crossAxisSpacing: 10.0,
                  mainAxisSpacing: 10.0,
                  childAspectRatio: 3/4
              ),
              padding: const EdgeInsets.all(8.0),
              itemCount: movies.length,
              itemBuilder: (context, index) {
                final movie = movies[index];
                final imageUrl = '${Constants.imagePath}${movie.poster_path}';
                return GestureDetector(
                  onTap: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context)=>MoviesUpComingDetailsPage(movie: movie),
                    ),
                    );
                  },
                  child: GridTile(
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: CachedNetworkImage(
                        imageUrl: imageUrl,
                        placeholder: (context, url) => const Center(child: CircularProgressIndicator()),
                        errorWidget: (context, url, error) => const Icon(Icons.error),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                );
              },
            );
          } else if (state is UpcomingError) {
            return const Center(child: Text('Failed to load movies'));
          }
          return const Center(child: Text('Unknown state'));
        },
      ),
    );
  }
}
