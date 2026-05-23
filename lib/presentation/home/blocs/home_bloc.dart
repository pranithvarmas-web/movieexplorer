import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:movie_db_assign/models/movie_model.dart';
import 'package:movie_db_assign/repository/repo_api.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  List<MovieModel> _allMovies = [];
  final RepoApi repoApi;
  HomeBloc(this.repoApi) : super(HomeInitial()) {
    on<SearchLoadMoviesEvent>(_onSearchLoadMoviesEvent);
    on<LoadMoviesEvent>(_onLoadMoviesEvent);
  }

  FutureOr<void> _onLoadMoviesEvent(LoadMoviesEvent event, Emitter<HomeState> emit) async {

    emit(HomeLoading());
    try {
      _allMovies = await repoApi.fetchAllMovies();
      emit(HomeLoaded(_allMovies));
    } catch (e) {
      emit(HomeError("Failed to load movies: ${e.toString()}"));
    }

  }

  FutureOr<void> _onSearchLoadMoviesEvent(SearchLoadMoviesEvent event, Emitter<HomeState> emit) async {

    if (_allMovies.isEmpty) return;
    final filteredMovies = _allMovies.where((movie) {
      return movie.title.toLowerCase().contains(event.query.toLowerCase());
    }).toList();

    emit(HomeLoaded(filteredMovies));
    
  }



}


