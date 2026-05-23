import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_db_assign/constants/constants.dart';
import 'package:movie_db_assign/models/movie_model.dart';
import 'package:movie_db_assign/presentation/popular/blocs/popular_bloc.dart';
import 'package:movie_db_assign/presentation/popular/widgets/popular_sizedbox.dart';

class PopularSlider extends StatelessWidget {
  const PopularSlider({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<PopularBloc, PopularState>(
      listenWhen: (previous,current)=>current is PopularActionState,
      buildWhen: (previous,current)=>current is !PopularActionState,
      listener: (context, state) {
        if (state is PopularError) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Error: ${state.message}')),
          );
        }
      },
      builder: (context, state) {
        if (state is PopularInitial) {
          return const Center(child: CircularProgressIndicator());
        } else if (state is PopularLoaded) {
          final List<MovieModel> movies = state.movies;
          return PopularSizedBox(movies: movies);
        } else {
          return const Center(child: Text('No popular movies available'));
        }
      },
    );
  }
}
