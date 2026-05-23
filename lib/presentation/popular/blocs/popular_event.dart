part of 'popular_bloc.dart';

@immutable
abstract class PopularEvent {}

class GetPopularMovies extends PopularEvent {}

class SelectPopularMovie extends PopularEvent {
  final MovieModel movie;
  SelectPopularMovie(this.movie);
}

class GetPopularMovieDetails extends PopularEvent {
  final int movieId;

  GetPopularMovieDetails(this.movieId);
}


