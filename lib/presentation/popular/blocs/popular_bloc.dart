import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:hive/hive.dart';
import 'package:meta/meta.dart';
import 'package:movie_db_assign/models/movie_model.dart';
import 'package:movie_db_assign/repository/repo_api.dart';

part 'popular_event.dart';
part 'popular_state.dart';

class PopularBloc extends Bloc<PopularEvent, PopularState> {
  final RepoApi repoApi;
  final Box<MovieModel> moviesBox;
  PopularBloc(this.repoApi, this.moviesBox) : super(PopularInitial()) {
    on<GetPopularMovies>(_onGetPopularMovies);
    on<SelectPopularMovie>(_onSelectPopularMovie);
    on<GetPopularMovieDetails>(_onGetPopularMovieDetails);
  }

  Future<void> _onGetPopularMovies(GetPopularMovies event, Emitter<PopularState> emit) async {
    try {
      emit(PopularInitial());
      final cachedMovies = moviesBox.values.toList();
      if (cachedMovies.isNotEmpty) {
        emit(PopularLoaded(cachedMovies));
      } else {
        final movies = await repoApi.favoriteMovies();
        for (var movie in movies) {
          moviesBox.put(movie.id, movie);
        }

        emit(PopularLoaded(movies));
      }
    } catch (e) {
      emit(PopularError('Failed to fetch Popular movies'));
    }

  }

  FutureOr<void> _onSelectPopularMovie(SelectPopularMovie event, Emitter<PopularState> emit) {
    emit(PopularMovieSelected(event.movie));
  }


  Future<void> _onGetPopularMovieDetails(GetPopularMovieDetails event, Emitter<PopularState> emit) async {
    try {
      emit(PopularInitial());
      final movieDetails = await repoApi.getPopularMovieDetails(event.movieId);
      emit(PopularMovieSelected(movieDetails));
    } catch (e) {
      emit(PopularError('Failed to fetch popular movie details'));
    }
  }
}


