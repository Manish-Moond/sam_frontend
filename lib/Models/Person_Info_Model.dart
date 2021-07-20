// To parse this JSON data, do
//
//     final personInfoModel = personInfoModelFromJson(jsonString);

import 'dart:convert';

PersonInfoModel personInfoModelFromJson(String str) =>
    PersonInfoModel.fromJson(json.decode(str));

class PersonInfoModel {
  PersonInfoModel({
    required this.adult,
    required this.alsoKnownAs,
    required this.biography,
    required this.birthday,
    required this.deathday,
    required this.gender,
    required this.homepage,
    required this.id,
    required this.imdbId,
    required this.knownForDepartment,
    required this.name,
    required this.placeOfBirth,
    required this.popularity,
    required this.profilePath,
  });

  final bool? adult;
  final List<String>? alsoKnownAs;
  final String? biography;
  final DateTime? birthday;
  final dynamic deathday;
  final int? gender;
  final dynamic homepage;
  final int? id;
  final String? imdbId;
  final String? knownForDepartment;
  final String? name;
  final String? placeOfBirth;
  final double? popularity;
  final String? profilePath;

  factory PersonInfoModel.fromJson(Map<String, dynamic> json) =>
      PersonInfoModel(
        adult: json["adult"] == null ? false : json['adult'],
        alsoKnownAs: json['also_known_as'] == null
            ? ['']
            : List<String>.from(json["also_known_as"].map((x) => x)),
        biography: json["biography"] == null ? ' ' : json['biography'],
        birthday: json['birthday'] == null
            ? DateTime.parse('')
            : DateTime.parse(json["birthday"]),
        deathday: json["deathday"] == null ? ' ' : json['deathday'],
        gender: json["gender"] == null ? 0 : json['gender'],
        homepage: json["homepage"] == null ? ' ' : json['homepage'],
        id: json["id"] == null ? 1 : json['id'],
        imdbId: json["imdb_id"] == null ? '' : json['imdb_id'],
        knownForDepartment: json["known_for_department"] == null
            ? ' '
            : json['known_for_department'],
        name: json["name"] == null ? ' ' : json['name'],
        placeOfBirth:
            json["place_of_birth"] == null ? ' ' : json['place_of_birth'],
        popularity:
            json['popularity'] ? 10000.0 : json["popularity"].toDouble(),
        profilePath: json["profile_path"] == null ? ' ' : json['profile_path'],
      );
}
