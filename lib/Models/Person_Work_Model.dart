// To parse this JSON data, do
//
//     final personWorkModel = personWorkModelFromJson(jsonString);

import 'dart:convert';

PersonWorkModel personWorkModelFromJson(String str) =>
    PersonWorkModel.fromJson(json.decode(str));

class PersonWorkModel {
  PersonWorkModel({
    required this.work,
  });

  final List<Work> work;

  factory PersonWorkModel.fromJson(Map<String, dynamic> json) =>
      PersonWorkModel(
        work: List<Work>.from(json["work"].map((x) => Work.fromJson(x))),
      );
}

class Work {
  Work({
    required this.adult,
    required this.backdropPath,
    required this.genreIds,
    required this.id,
    required this.originalLanguage,
    required this.originalTitle,
    required this.overview,
    required this.posterPath,
    required this.releaseDate,
    required this.title,
    required this.voteAverage,
  });

  final bool adult;
  final String backdropPath;
  final List<int> genreIds;
  final int id;
  final String originalLanguage;
  final String originalTitle;
  final String overview;
  final String posterPath;
  final DateTime releaseDate;
  final String title;
  final double voteAverage;

  factory Work.fromJson(Map<String, dynamic> json) => Work(
        adult: json["adult"],
        backdropPath: json["backdrop_path"],
        genreIds: List<int>.from(json["genre_ids"].map((x) => x)),
        id: json["id"],
        originalLanguage: json["original_language"],
        originalTitle: json["original_title"],
        overview: json["overview"],
        posterPath: json["poster_path"],
        releaseDate: DateTime.parse(json["release_date"]),
        title: json["title"],
        voteAverage: json["vote_average"].toDouble(),
      );
}
