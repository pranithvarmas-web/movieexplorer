import 'dart:convert';
import 'package:movie_db_assign/constants/constants.dart';
import 'package:movie_db_assign/models/movie_model.dart';
import 'package:http/http.dart' as http;
import 'package:movie_db_assign/utils/cache_manager.dart';

class RepoApi{
  final CacheManager cacheManager=CacheManager();
  static const _moviesOnScreenUrl='https://api.themoviedb.org/3/movie/now_playing?api_key=${Constants.apiKey}';
  static const _favoriteMoviesUrl='https://api.themoviedb.org/3/movie/popular?api_key=${Constants.apiKey}';
  static const _topPicksUrl='https://api.themoviedb.org/3/movie/top_rated?api_key=${Constants.apiKey}';
  static const _comingMoviesUrl='https://api.themoviedb.org/3/movie/upcoming?api_key=${Constants.apiKey}';
  final List<String> _apiUrls = [_moviesOnScreenUrl,_favoriteMoviesUrl,_topPicksUrl,_comingMoviesUrl];



  Future<List<MovieModel>> getMoviesOnScreen() async {
    List<MovieModel>? cachedMovies = await cacheManager.getCachedMovies('nowPlayingMovies');

    if (cachedMovies != null && cachedMovies.isNotEmpty) {
      return cachedMovies;
    }
    else{
      final response= await http.get(Uri.parse(_moviesOnScreenUrl));
      if(response.statusCode==200){
        final decodedData=json.decode(response.body)["results"] as List;
        List<MovieModel> movies = decodedData.map((movie) {
          MovieModel movieModel = MovieModel.fromJson(movie);
          return movieModel;
        }).toList();
        await cacheManager.cacheMovies('nowPlayingMovies', movies);
        return movies;
      }
      else{
        throw Exception("Failed to load Movies on screen");
      }
    }

  }

  Future<MovieModel> getMovieDetails(int movieId) async {
    final response = await http.get(Uri.parse('$_moviesOnScreenUrl/$movieId'));
    if (response.statusCode == 200) {
      final decodedData = json.decode(response.body);
      return MovieModel.fromJson(decodedData);
    } else {
      throw Exception('Failed to fetch playing movies details');
    }
  }





  Future<List<MovieModel>> favoriteMovies() async {
    List<MovieModel>? cachedMovies = await cacheManager.getCachedMovies('favoriteMovies');
    if (cachedMovies != null && cachedMovies.isNotEmpty) {
      return cachedMovies;
    }
    final response = await http.get(Uri.parse(_favoriteMoviesUrl));

    if (response.statusCode == 200) {
      final decodedData = json.decode(response.body)["results"] as List;
      List<MovieModel> movies = decodedData.map((movie) => MovieModel.fromJson(movie)).toList();
      await cacheManager.cacheMovies('favoriteMovies', movies);
      return movies;
    } else {
      throw Exception("Failed to load favorite movies");
    }
  }

  Future<MovieModel> getPopularMovieDetails(int movieId) async {
    final response = await http.get(Uri.parse('$_favoriteMoviesUrl/$movieId'));
    if (response.statusCode == 200) {
      final decodedData = json.decode(response.body);
      return MovieModel.fromJson(decodedData);
    } else {
      throw Exception('Failed to fetch popular movies details');
    }
  }






  Future<List<MovieModel>> topPicks() async {
    List<MovieModel>? cachedTopPicks = await cacheManager.getCachedMovies('topPicks');
    if (cachedTopPicks != null && cachedTopPicks.isNotEmpty) {
      return cachedTopPicks;
    }
    final response = await http.get(Uri.parse(_topPicksUrl));

    if (response.statusCode == 200) {
      final decodedData = json.decode(response.body)["results"] as List;
      List<MovieModel> topPicksMovies = decodedData.map((movie) => MovieModel.fromJson(movie)).toList();
      await cacheManager.cacheMovies('topPicks', topPicksMovies);
      return topPicksMovies;
    } else {
      throw Exception("Failed to load top picks");
    }
  }

  Future<MovieModel> getTopRatedMovieDetails(int movieId) async {
    final response = await http.get(Uri.parse('$_topPicksUrl/$movieId'));
    if (response.statusCode == 200) {
      final decodedData = json.decode(response.body);
      return MovieModel.fromJson(decodedData);
    } else {
      throw Exception('Failed to fetch top rated movies details');
    }
  }






  Future<List<MovieModel>> comingMovies() async {
    List<MovieModel>? cachedComingMovies = await cacheManager.getCachedMovies('comingMovies');
    if (cachedComingMovies != null && cachedComingMovies.isNotEmpty) {
      return cachedComingMovies;
    }
    final response = await http.get(Uri.parse(_comingMoviesUrl));
    if (response.statusCode == 200) {
      final decodedData = json.decode(response.body)["results"] as List;
      List<MovieModel> comingMoviesList = decodedData.map((movie) => MovieModel.fromJson(movie)).toList();
      await cacheManager.cacheMovies('comingMovies', comingMoviesList);
      return comingMoviesList;
    } else {
      throw Exception("Failed to load coming movies");
    }
  }

  Future<MovieModel> getUpcomingMovieDetails(int movieId) async {
    final response = await http.get(Uri.parse('$_comingMoviesUrl/$movieId'));
    if (response.statusCode == 200) {
      final decodedData = json.decode(response.body);
      return MovieModel.fromJson(decodedData);
    } else {
      throw Exception('Failed to fetch upcoming movie details');
    }
  }






  //to search the movies from apis

  Future<List<MovieModel>> fetchAllMovies() async {
    List<MovieModel>? cachedMovies = await cacheManager.getCachedMovies('allMovies');
    if (cachedMovies != null && cachedMovies.isNotEmpty) {
      return cachedMovies;
    }

    List<MovieModel> movies = [];
    Set<int> movieIds = {};

    for (String url in _apiUrls) {
      final response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        final decodedData = json.decode(response.body)["results"] as List;
        List<MovieModel> moviesFromApi = decodedData
            .map((movie) => MovieModel.fromJson(movie))
            .where((movie) => movieIds.add(movie.id))
            .toList();
        movies.addAll(moviesFromApi);
      }
    }

    await cacheManager.cacheMovies('allMovies', movies);
    return movies;
  }

}






