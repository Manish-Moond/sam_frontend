import 'dart:convert';

PersonInfoModel personInfoModelFromJson(String str) =>
    PersonInfoModel.fromJson(json.decode(str));

class PersonInfoModel {
  PersonInfoModel({
    required this.biography,
    required this.birthday,
    required this.id,
    required this.imdbId,
    required this.knownForDepartment,
    required this.name,
    required this.profilePath,
  });

  final String biography;
  final DateTime birthday;
  final int id;
  final String imdbId;
  final String knownForDepartment;
  final String name;
  final String profilePath;

  factory PersonInfoModel.fromJson(Map<String, dynamic> json) =>
      PersonInfoModel(
        biography: json["biography"],
        birthday: DateTime.parse(json["birthday"]),
        id: json["id"],
        imdbId: json["imdb_id"],
        knownForDepartment: json["known_for_department"],
        name: json["name"],
        profilePath: json["profile_path"],
      );

}
