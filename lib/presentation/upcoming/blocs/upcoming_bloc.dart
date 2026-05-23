import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:hive/hive.dart';
import 'package:meta/meta.dart';
import 'package:movie_db_assign/models/movie_model.dart';
import 'package:movie_db_assign/repository/repo_api.dart';

part 'upcoming_event.dart';
part 'upcoming_state.dart';

class UpcomingBloc extends Bloc<UpcomingEvent, UpcomingState> {
  final RepoApi repoApi;
  final Box<MovieModel> moviesBox;

  UpcomingBloc(this.repoApi, this.moviesBox) : super(UpcomingInitial()) {
    on<GetUpcomingMovies>(_onGetUpcomingMovies);
    on<SelectUpcomingMovie>(_onSelectUpcomingMovie);
    on<GetUpcomingMovieDetails>(_onGetUpcomingMovieDetails);
  }

  Future<void> _onGetUpcomingMovies(GetUpcomingMovies event, Emitter<UpcomingState> emit) async {
    try {
      emit(UpcomingInitial());
      final cachedMovies = moviesBox.values.toList();
      if (cachedMovies.isNotEmpty) {
        emit(UpcomingLoaded(cachedMovies));
      } else {
        final movies = await repoApi.comingMovies();
        for (var movie in movies) {
          moviesBox.put(movie.id, movie);
        }

        emit(UpcomingLoaded(movies));
      }
    } catch (e) {
      emit(UpcomingError('Failed to fetch Up Coming movies'));
    }

  }

  FutureOr<void> _onSelectUpcomingMovie( SelectUpcomingMovie event, Emitter<UpcomingState> emit) {
    emit(UpcomingSelected(event.movie));
  }


  Future<void> _onGetUpcomingMovieDetails(GetUpcomingMovieDetails event, Emitter<UpcomingState> emit) async {
    try {
      emit(UpcomingInitial());
      final movieDetails = await repoApi.getUpcomingMovieDetails(event.movieId);
      emit(UpcomingSelected(movieDetails));
    } catch (e) {
      emit(UpcomingError('Failed to fetch popular movie details'));
    }
  }
}


