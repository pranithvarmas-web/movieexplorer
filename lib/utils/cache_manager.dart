import 'package:hive/hive.dart';
import 'package:movie_db_assign/models/movie_model.dart';

class CacheManager {
  Future<void> cacheMovies(String boxName, List<MovieModel> movies) async {
    var box = await Hive.openBox<MovieModel>(boxName);
    await box.clear();
    await box.addAll(movies);
  }
  Future<List<MovieModel>?> getCachedMovies(String boxName) async {
    var box = await Hive.openBox<MovieModel>(boxName);
    if (box.isNotEmpty) {
      return box.values.toList().cast<MovieModel>();
    } else {
      return null;
    }
  }
}
