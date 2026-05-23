import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_db_assign/models/movie_model.dart';
import 'package:movie_db_assign/presentation/upcoming/blocs/upcoming_bloc.dart';
import 'package:movie_db_assign/presentation/upcoming/widgets/upcoming_sized_box.dart';

class UpcomingSlider extends StatelessWidget {
  const UpcomingSlider({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<UpcomingBloc, UpcomingState>(
      listenWhen: (previous,current)=>current is UpcomingActionState,
      buildWhen: (previous,current)=>current is !UpcomingActionState,
      listener: (context, state) {
        if (state is UpcomingError) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Error: ${state.message}')),
          );
        }
      },
      builder: (context, state) {
        if (state is UpcomingInitial) {
          return const Center(child: CircularProgressIndicator());
        } else if (state is UpcomingLoaded) {
          final List<MovieModel> movies = state.movies;
          return UpcomingSizedBox(movies: movies);
        } else {
          return const Center(child: Text('No upcoming movies available'));
        }
      },
    );
  }
}
