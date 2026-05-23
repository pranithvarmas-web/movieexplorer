part of 'top_rated_bloc.dart';

@immutable
sealed class TopRatedEvent {}


class GetTopRatedMovies extends TopRatedEvent {}

class SelectTopRatedMovie extends TopRatedEvent {
  final MovieModel movie;
  SelectTopRatedMovie(this.movie);
}


class GetTopRatedMovieDetails extends TopRatedEvent {
  final int movieId;

  GetTopRatedMovieDetails(this.movieId);
}
