import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:movie_db_assign/models/movie_model.dart';
import 'package:movie_db_assign/constants/constants.dart';

class MoviesUpComingDetailsPage extends StatelessWidget {
  final MovieModel movie;

  const MoviesUpComingDetailsPage({super.key, required this.movie});

  @override
  Widget build(BuildContext context) {
    final posterImageUrl = '${Constants.imagePath}${movie.poster_path}';
    final roundedRating = movie.vote_average.round();

    return Scaffold(
      appBar: AppBar(
        title: Text(movie.title),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Hero(
              tag:'upcoming-movie-${movie.id}',
              child: CachedNetworkImage(
                imageUrl: posterImageUrl,
                placeholder: (context, url) => const Center(child: CircularProgressIndicator()),
                errorWidget: (context, url, error) => const Icon(Icons.error),
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(height: 16),
            Text('Title: ${movie.title}', style: TextStyle(fontSize: 24)),
            const SizedBox(height: 8),
            Text('Release Date: ${movie.release_date}', style: TextStyle(fontSize: 18)),
            const SizedBox(height: 8),
            Row(
              children: [
                Text('Rating : $roundedRating', style: TextStyle(fontSize: 18)),
                const Icon(Icons.star, color: Colors.yellow),
              ],
            ),
            const SizedBox(height: 16),
            const Text('Overview', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            Text(movie.overview, style: const TextStyle(fontSize: 16)),
          ],
        ),
      ),
    );
  }
}


