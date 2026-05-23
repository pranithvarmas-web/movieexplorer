import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_db_assign/models/movie_model.dart';
import 'package:movie_db_assign/presentation/trending/bloc/trending_bloc.dart';
import 'package:movie_db_assign/presentation/trending/widgets/trending_sizedbox.dart';

class TrendingSlider extends StatelessWidget {
  const TrendingSlider({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<TrendingBloc, TrendingState>(
      listenWhen: (previous,current)=>current is TrendingActionState,
      buildWhen: (previous,current)=>current is !TrendingActionState,
      listener: (context, state) {
        if (state is TrendingError) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Error: ${state.message}')),
          );
        }
      },
      builder: (context, state) {
        if (state is TrendingInitial) {
          return const Center(child: CircularProgressIndicator());
        } else if (state is TrendingLoaded) {
          final List<MovieModel> movies = state.movies;
          return TrendingSizedBox(movies: movies);
        } else {
          return const Center(child: Text('No movies available'));
        }
      },
    );
  }
}
