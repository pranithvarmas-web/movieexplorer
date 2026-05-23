part of 'upcoming_bloc.dart';

@immutable
sealed class UpcomingEvent {}

class GetUpcomingMovies extends UpcomingEvent {}

class SelectUpcomingMovie extends UpcomingEvent {
  final MovieModel movie;
  SelectUpcomingMovie(this.movie);
}


class GetUpcomingMovieDetails extends UpcomingEvent {
  final int movieId;
  GetUpcomingMovieDetails(this.movieId);
}

