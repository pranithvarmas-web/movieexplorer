import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
import 'package:movie_db_assign/models/movie_model.dart';
import 'package:movie_db_assign/presentation/home/widgets/custom_scroll_widget.dart';
import 'package:movie_db_assign/presentation/trending/bloc/trending_bloc.dart';
import 'package:movie_db_assign/presentation/popular/blocs/popular_bloc.dart';
import 'package:movie_db_assign/presentation/top_rated/blocs/top_rated_bloc.dart';
import 'package:movie_db_assign/presentation/upcoming/blocs/upcoming_bloc.dart';
import 'package:movie_db_assign/repository/repo_api.dart';

class CustomMultiBlocProvider extends StatelessWidget {
  const CustomMultiBlocProvider({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final Box<MovieModel> moviesBoxTrending = Hive.box<MovieModel>('moviesTrending');
    final Box<MovieModel> moviesBoxPopular = Hive.box<MovieModel>('moviesPopular');
    final Box<MovieModel> moviesBoxTopRated = Hive.box<MovieModel>('moviesTopRated');
    final Box<MovieModel> moviesBoxUpcoming = Hive.box<MovieModel>('moviesUpComing');

    return MultiBlocProvider(
      providers: [
        BlocProvider<TrendingBloc>(
          create: (context) => TrendingBloc(RepoApi(), moviesBoxTrending)..add(GetMoviesOnScreen()),
        ),
        BlocProvider<PopularBloc>(
          create: (context) => PopularBloc(RepoApi(),moviesBoxPopular)..add(GetPopularMovies()),
        ),
        BlocProvider<TopRatedBloc>(
          create: (context) => TopRatedBloc(RepoApi(),moviesBoxTopRated)..add(GetTopRatedMovies()),
        ),
        BlocProvider<UpcomingBloc>(
          create: (context) => UpcomingBloc(RepoApi(),moviesBoxUpcoming)..add(GetUpcomingMovies()),
        ),
      ],
      child: const CustomScrollViewWidget(),
    );
  }
}
