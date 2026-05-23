part of 'popular_bloc.dart';

@immutable
sealed class PopularState {}

final class PopularInitial extends PopularState {}
final class PopularActionState extends PopularState{}


final class PopularLoaded extends PopularState {
  final List<MovieModel> movies;

  PopularLoaded(this.movies);
}

final class PopularError extends PopularState {
  final String message;

  PopularError(this.message);
}

final class PopularMovieSelected extends PopularActionState {
  final MovieModel selectedMovie;

  PopularMovieSelected(this.selectedMovie);
}
