import 'package:hive/hive.dart';

part 'movie_model.g.dart';

@HiveType(typeId: 0)
class MovieModel {
  @HiveField(0)
  final int id;
  @HiveField(1)
  final String title;
  @HiveField(2)
  final String original_title;
  @HiveField(3)
  final String? backdrop_path;
  @HiveField(4)
  final String original_language;
  @HiveField(5)
  final String overview;
  @HiveField(6)
  final String? poster_path;
  @HiveField(7)
  final String release_date;
  @HiveField(8)
  final double vote_average;

  MovieModel({
    required this.id,
    required this.title,
    required this.original_title,
    this.backdrop_path,
    required this.original_language,
    required this.overview,
    this.poster_path,
    required this.release_date,
    required this.vote_average,
  });


  factory MovieModel.fromJson(Map<String, dynamic> json) {
    return MovieModel(
      id: json['id'] ?? 0,
      title: json['title'] ?? '',
      original_title: json['original_title'] ?? '',
      backdrop_path: json['backdrop_path'],
      original_language: json['original_language'] ?? '',
      overview: json['overview'] ?? '',
      poster_path: json['poster_path'],
      release_date: json['release_date'] ?? '',
      vote_average: (json['vote_average'] ?? 0).toDouble(),
    );
  }

  Map<String, dynamic> toJson() => {
    "id": id,
    "title": title,
    "original_title": original_title,
    "backdrop_path": backdrop_path,
    "original_language": original_language,
    "overview": overview,
    "poster_path": poster_path,
    "release_date": release_date,
    "vote_average": vote_average,
  };

  @override
  String toString() {
    return 'MovieModel(id: $id, title: $title, original_title: $original_title, backdrop_path: $backdrop_path, original_language: $original_language, overview: $overview, poster_path: $poster_path, release_date: $release_date, vote_average: $vote_average)';
  }
}




// "adult": false,
// "backdrop_path": "/mKOBdgaEFguADkJhfFslY7TYxIh.jpg",
// "genre_ids": [5 items],
// "id": 365177,
// "original_language": "en",
// "original_title": "Borderlands",
// "overview": "Returning to her home planet, an infamous bounty hunter forms an unexpected alliance with a team of unlikely heroes. Together, they battle monsters and dangerous bandits to protect a young girl who holds the key to unimaginable power.",
// "popularity": 1584.1,
// "poster_path": "/865DntZzOdX6rLMd405R0nFkLmL.jpg",
// "release_date": "2024-08-07",
// "title": "Borderlands",
// "video": false,
// "vote_average": 5.809,
// "vote_count": 517