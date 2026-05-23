part of 'home_bloc.dart';

@immutable
sealed class HomeEvent {}
class SearchClickEvent extends HomeEvent {
  final String query;

  SearchClickEvent(this.query);
}


class SearchLoadMoviesEvent extends HomeEvent{
  final String query;

  SearchLoadMoviesEvent(this.query);

}

class LoadMoviesEvent extends HomeEvent{

}