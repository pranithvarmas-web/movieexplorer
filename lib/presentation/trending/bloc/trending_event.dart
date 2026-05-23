part of 'trending_bloc.dart';

@immutable
abstract class TrendingEvent {}


class GetMoviesOnScreen extends TrendingEvent {}

class SelectTrendingMovie extends TrendingEvent {
  final MovieModel movie;

  SelectTrendingMovie(this.movie);
}

class GetMovieDetails extends TrendingEvent {
  final int movieId;

  GetMovieDetails(this.movieId);
}


//
//
//
// part of 'trending_bloc.dart';
//
// import 'package:movie_db_assign/models/movie_model.dart';
//
// @immutable
// sealed class TrendingEvent {}
//
//
// // abstract class TrendingEvent {}
//
// class GetMoviesOnScreen extends TrendingEvent {}
//
// class SelectTrendingMovie extends TrendingEvent {
//   final MovieModel movie;
//
//   SelectTrendingMovie(this.movie);
// }
