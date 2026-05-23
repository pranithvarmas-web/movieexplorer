part of 'trending_bloc.dart';

@immutable
sealed class TrendingState {}



final class TrendingInitial extends TrendingState {}

final class TrendingActionState extends TrendingState{}


final class TrendingLoaded extends TrendingState {
  final List<MovieModel> movies;

  TrendingLoaded(this.movies);
}

final class TrendingError extends TrendingState {
  final String message;

  TrendingError(this.message);
}

final class TrendingMovieSelected extends TrendingActionState {
  final MovieModel selectedMovie;

  TrendingMovieSelected(this.selectedMovie);
}
