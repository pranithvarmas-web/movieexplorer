import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive/hive.dart';
import 'package:movie_db_assign/models/movie_model.dart';
import 'package:movie_db_assign/presentation/upcoming/blocs/upcoming_bloc.dart';
import 'package:movie_db_assign/presentation/upcoming/pages/movies_upcoming_page.dart';
import 'package:movie_db_assign/repository/repo_api.dart';

class UpcomingTitleGesture extends StatelessWidget {
  const UpcomingTitleGesture({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final Box<MovieModel> moviesBoxUpComing = Hive.box<MovieModel>('moviesUpComing');

    return GestureDetector(onTap: () {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => BlocProvider(
            create: (context) => UpcomingBloc(RepoApi(),moviesBoxUpComing)..add(GetUpcomingMovies()),
            child: const MoviesUpcomingPage(title: 'Movies Coming Soon'),
          ),
        ),
      );
    }, child: Text('Movies Coming Soon', style: GoogleFonts.aBeeZee(fontSize: 22,fontWeight: FontWeight.bold)));
  }
}


