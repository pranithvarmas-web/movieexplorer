import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive/hive.dart';
import 'package:movie_db_assign/models/movie_model.dart';
import 'package:movie_db_assign/presentation/popular/blocs/popular_bloc.dart';
import 'package:movie_db_assign/presentation/top_rated/blocs/top_rated_bloc.dart';
import 'package:movie_db_assign/presentation/top_rated/pages/movies_toprated_page.dart';
import 'package:movie_db_assign/repository/repo_api.dart';

class TopratedTitleGesture extends StatelessWidget {
  const TopratedTitleGesture({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final Box<MovieModel> moviesBoxTopRated = Hive.box<MovieModel>('moviesTopRated');

    return GestureDetector(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => BlocProvider(
                create: (context) => TopRatedBloc(RepoApi(),moviesBoxTopRated)..add(GetTopRatedMovies()),
                child: const MoviesTopratedPage(title: 'Top Rated Movies'),
              ),
            ),
          );
        },
        child: Text('Top Picks', style: GoogleFonts.aBeeZee(fontSize: 22,fontWeight: FontWeight.bold)));
  }
}

