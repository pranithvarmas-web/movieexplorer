part of 'top_rated_bloc.dart';

@immutable
sealed class TopRatedState {}

final class TopRatedInitial extends TopRatedState {}
final class TopRatedActionState extends TopRatedState{}

final class TopRatedLoaded extends TopRatedState {
  final List<MovieModel> movies;
  TopRatedLoaded(this.movies);
}

final class TopRatedError extends TopRatedState {
  final String message;
  TopRatedError(this.message);
}

final class TopRatedSelected extends TopRatedActionState {
  final MovieModel selectedMovie;

  TopRatedSelected(this.selectedMovie);
}
