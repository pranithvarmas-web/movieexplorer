import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive/hive.dart';
import 'package:movie_db_assign/models/movie_model.dart';
import 'package:movie_db_assign/presentation/trending/bloc/trending_bloc.dart';
import 'package:movie_db_assign/presentation/trending/pages/movies_list_page.dart';
import 'package:movie_db_assign/repository/repo_api.dart';

class TrendingTitleGesture extends StatelessWidget {
  const TrendingTitleGesture({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final Box<MovieModel> moviesBoxTrending = Hive.box<MovieModel>('moviesTrending');
    return GestureDetector(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => BlocProvider(
                create: (context) => TrendingBloc(RepoApi(),moviesBoxTrending)..add(GetMoviesOnScreen()),
                child: const MoviesListPage(title: 'Movies On Screen'),
              ),
            ),
          );
        },
        child: Text('Movies On Screen',style: GoogleFonts.aBeeZee(fontSize: 24,fontWeight:FontWeight.bold),));
  }
}

