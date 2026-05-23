import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_db_assign/models/movie_model.dart';
import 'package:movie_db_assign/presentation/top_rated/blocs/top_rated_bloc.dart';
import 'package:movie_db_assign/presentation/top_rated/widgets/toprated_sizedbox.dart';

class TopRatedSlider extends StatelessWidget {
  const TopRatedSlider({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<TopRatedBloc, TopRatedState>(
      listenWhen: (previous,current)=>current is TopRatedActionState,
      buildWhen: (previous,current)=>current is !TopRatedActionState,
      listener: (context, state) {
        if (state is TopRatedError) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Error: ${state.message}')),
          );
        }
      },
      builder: (context, state) {
        if (state is TopRatedInitial) {
          return const Center(child: CircularProgressIndicator());
        } else if (state is TopRatedLoaded) {
          final List<MovieModel> movies = state.movies;
          return TopRatedSizedBox(movies: movies);
        } else {
          return const Center(child: Text('No top-rated movies available'));
        }
      },
    );
  }
}

