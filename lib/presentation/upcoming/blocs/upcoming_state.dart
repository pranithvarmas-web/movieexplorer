part of 'upcoming_bloc.dart';

@immutable
sealed class UpcomingState {}

final class UpcomingInitial extends UpcomingState {}
final class UpcomingActionState extends UpcomingState{}

final class UpcomingLoaded extends UpcomingState {
  final List<MovieModel> movies;
  UpcomingLoaded(this.movies);
}

final class UpcomingError extends UpcomingState {
  final String message;
  UpcomingError(this.message);
}

final class UpcomingSelected extends UpcomingActionState {
  final MovieModel selectedMovie;

  UpcomingSelected(this.selectedMovie);
}

