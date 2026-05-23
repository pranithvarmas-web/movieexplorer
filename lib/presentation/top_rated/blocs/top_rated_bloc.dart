import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:hive/hive.dart';
import 'package:meta/meta.dart';
import 'package:movie_db_assign/models/movie_model.dart';
import 'package:movie_db_assign/repository/repo_api.dart';

part 'top_rated_event.dart';
part 'top_rated_state.dart';

class TopRatedBloc extends Bloc<TopRatedEvent, TopRatedState> {
  final RepoApi repoApi;
  final Box<MovieModel> moviesBox;

  TopRatedBloc(this.repoApi, this.moviesBox) : super(TopRatedInitial()) {
    on<GetTopRatedMovies>(_onGetTopRatedMovies);
    on<SelectTopRatedMovie>(_onSelectTopRatedMovie);
    on<GetTopRatedMovieDetails>(_onGetTopRatedMovieDetails);
  }

  Future<void> _onGetTopRatedMovies(GetTopRatedMovies event, Emitter<TopRatedState> emit) async {
    try {
      emit(TopRatedInitial());
      final cachedMovies = moviesBox.values.toList();
      if (cachedMovies.isNotEmpty) {
        emit(TopRatedLoaded(cachedMovies));
      } else {
        final movies = await repoApi.topPicks();
        for (var movie in movies) {
          moviesBox.put(movie.id, movie);
        }

        emit(TopRatedLoaded(movies));
      }
    } catch (e) {
      emit(TopRatedError('Failed to fetch Top Rated movies'));
    }

  }

  FutureOr<void> _onSelectTopRatedMovie( SelectTopRatedMovie event, Emitter<TopRatedState> emit) {
    emit(TopRatedSelected(event.movie));
  }


  Future<void> _onGetTopRatedMovieDetails(GetTopRatedMovieDetails event, Emitter<TopRatedState> emit) async {
    try {
      emit(TopRatedInitial());
      final movieDetails = await repoApi.getTopRatedMovieDetails(event.movieId);
      emit(TopRatedSelected(movieDetails));
    } catch (e) {
      emit(TopRatedError('Failed to fetch popular movie details'));
    }
  }
}
