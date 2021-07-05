import 'dart:convert';

AnimeSearchByNameModel animeSearchByNameModelFromJson(String str) =>
    AnimeSearchByNameModel.fromJson(json.decode(str));


class AnimeSearchByNameModel {
  AnimeSearchByNameModel({
    required this.searchAnimeResult,
  });

  final List<SearchAnimeResult> searchAnimeResult;

  factory AnimeSearchByNameModel.fromJson(Map<String, dynamic> json) =>
      AnimeSearchByNameModel(
        searchAnimeResult: List<SearchAnimeResult>.from(
            json["searchAnimeResult"]
                .map((x) => SearchAnimeResult.fromJson(x))),
      );


}

class SearchAnimeResult {
  SearchAnimeResult({
    required this.episodes,
    required this.imageUrl,
    required this.malId,
    required this.score,
    required this.startDate,
    required this.title,
    required this.type,
  });

  final int episodes;
  final String imageUrl;
  final int malId;
  final double score;
  final DateTime startDate;
  final String title;
  final String type;

  factory SearchAnimeResult.fromJson(Map<String, dynamic> json) =>
      SearchAnimeResult(
        episodes: json["episodes"],
        imageUrl: json["image_url"],
        malId: json["mal_id"],
        score: json["score"].toDouble(),
        startDate: DateTime.parse(json["start_date"]),
        title: json["title"],
        type: json["type"],
      );

}