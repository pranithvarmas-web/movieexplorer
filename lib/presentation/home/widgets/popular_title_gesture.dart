import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive/hive.dart';
import 'package:movie_db_assign/models/movie_model.dart';
import 'package:movie_db_assign/presentation/popular/blocs/popular_bloc.dart';
import 'package:movie_db_assign/presentation/popular/pages/movies_popular_page.dart';
import 'package:movie_db_assign/repository/repo_api.dart';

class PopularTitleGesture extends StatelessWidget {
  const PopularTitleGesture({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final Box<MovieModel> moviesBoxPopular = Hive.box<MovieModel>('moviesPopular');
    return GestureDetector(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => BlocProvider(
                create: (context) => PopularBloc(RepoApi(),moviesBoxPopular)..add(GetPopularMovies()),
                child: const MoviesPopularPage(title: 'Favorite Movies'),
              ),
            ),
          );
        },
        child: Text('Favorite Movies', style: GoogleFonts.aBeeZee(fontSize: 22,fontWeight: FontWeight.bold)));
  }
}
