// To parse this JSON data, do
//
//     final personInfoModel = personInfoModelFromJson(jsonString);

import 'dart:convert';

PersonInfoModel personInfoModelFromJson(String str) =>
    PersonInfoModel.fromJson(json.decode(str));

class PersonInfoModel {
  bool? adult;
  List<String>? alsoKnownAs;
  String? biography;
  DateTime? birthday;
  dynamic deathday;
  int? gender;
  dynamic homepage;
  int? id;
  String? imdbId;
  String? knownForDepartment;
  String? name;
  String? placeOfBirth;
  double? popularity;
  String? profilePath;

  PersonInfoModel({
    this.adult,
    this.alsoKnownAs,
    this.biography,
    this.birthday,
    this.deathday,
    this.gender,
    this.homepage,
    this.id,
    this.imdbId,
    this.knownForDepartment,
    this.name,
    this.placeOfBirth,
    this.popularity,
    this.profilePath,
  });

  factory PersonInfoModel.fromJson(Map<String, dynamic> json) =>
      PersonInfoModel(
        adult: json["adult"],
        alsoKnownAs: json["also_known_as"] == null
            ? []
            : List<String>.from(json["also_known_as"]!.map((x) => x)),
        biography: json["biography"],
        birthday:
            json["birthday"] == null ? null : DateTime.parse(json["birthday"]),
        deathday: json["deathday"],
        gender: json["gender"],
        homepage: json["homepage"],
        id: json["id"],
        imdbId: json["imdb_id"],
        knownForDepartment: json["known_for_department"],
        name: json["name"],
        placeOfBirth: json["place_of_birth"],
        popularity: json["popularity"]?.toDouble(),
        profilePath: json["profile_path"],
      );

}
