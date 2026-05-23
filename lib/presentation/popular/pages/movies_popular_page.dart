import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_db_assign/constants/constants.dart';
import 'package:movie_db_assign/presentation/popular/blocs/popular_bloc.dart';
import 'package:movie_db_assign/presentation/popular/pages/popular_details_page.dart';

class MoviesPopularPage extends StatelessWidget {
  final String title;

  const MoviesPopularPage({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: BlocConsumer<PopularBloc, PopularState>(
        listener: (context, state) {
          if (state is PopularError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.message)),
            );
          }
        },
        builder: (context, state) {
          if (state is PopularInitial) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is PopularLoaded) {
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
                final imageUrl = '${Constants.imagePath}${movie.poster_path}'; // Assuming you have a 'posterPath' field
                return GestureDetector(
                  onTap: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context)=>MoviesPopularDetailsPage(movie: movie),
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
          } else if (state is PopularError) {
            return const Center(child: Text('Failed to load movies'));
          }
          return const Center(child: Text('Unknown state'));
        },
      ),
    );
  }
}

