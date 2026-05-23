import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:hive/hive.dart';
import 'package:meta/meta.dart';
import 'package:movie_db_assign/models/movie_model.dart';
import 'package:movie_db_assign/repository/repo_api.dart';

part 'trending_event.dart';
part 'trending_state.dart';



class TrendingBloc extends Bloc<TrendingEvent, TrendingState> {
  final RepoApi repoApi;
  final Box<MovieModel> moviesBox;

  TrendingBloc(this.repoApi, this.moviesBox) : super(TrendingInitial()) {
    on<GetMoviesOnScreen>(_onGetMoviesOnScreen);
    on<SelectTrendingMovie>(_onSelectTrendingMovie);
    on<GetMovieDetails>(_onGetMovieDetails);
  }

  Future<void> _onGetMoviesOnScreen(GetMoviesOnScreen event, Emitter<TrendingState> emit) async {
    try {
      emit(TrendingInitial());
      final cachedMovies = moviesBox.values.toList();
      if (cachedMovies.isNotEmpty) {
        emit(TrendingLoaded(cachedMovies));
      } else {
        final movies = await repoApi.getMoviesOnScreen();
        for (var movie in movies) {
          moviesBox.put(movie.id, movie);
        }

        emit(TrendingLoaded(movies));
      }
    } catch (e) {
      emit(TrendingError('Failed to fetch trending movies'));
    }
  }

  FutureOr<void> _onSelectTrendingMovie(SelectTrendingMovie event, Emitter<TrendingState> emit) {
    emit(TrendingMovieSelected(event.movie));
  }

  Future<void> _onGetMovieDetails(GetMovieDetails event, Emitter<TrendingState> emit) async {
    try {
      emit(TrendingInitial());
      final movieDetails = await repoApi.getMovieDetails(event.movieId);
      emit(TrendingMovieSelected(movieDetails));
    } catch (e) {
      emit(TrendingError('Failed to fetch movie details'));
    }
  }
}





