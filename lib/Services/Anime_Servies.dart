import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:sam_frontend/Models/Anime_Model.dart';
import 'package:sam_frontend/Models/Anime_RR_Model.dart';
import 'package:sam_frontend/Models/Anime_Search_By_Genres.dart';
import 'package:sam_frontend/Models/Anime_This_Season_Model.dart';
import 'package:sam_frontend/Models/Anime_Top_Model.dart';

class HttpAnimeServices {
  Future<AnimeTopModel> getTopAnime() async {
    final res = await http.get(Uri.https('api.jikan.moe', '/v3/top/anime'));
    if (res.statusCode == 200) {
      AnimeTopModel resser = AnimeTopModel.fromJson(json.decode(res.body));
      return resser;
    } else {
      throw Exception("Failed to fetch Anime");
    }
  }

  Future<AnimeModel> getAnime({required int malId}) async {
    final res = await http
        .get(Uri.https("sam-api-flask.herokuapp.com", "anime/$malId"));
    if (res.statusCode == 200) {
      AnimeModel result = AnimeModel.fromJson(json.decode(res.body));
      return result;
    }
    throw Exception('Error');
  }

  Future<AnimeRRModel> getRRAnime({required int malId}) async {
    final res = await http.get(Uri.https('api.jikan.moe', '/v3/anime/$malId'));
    if (res.statusCode == 200) {
      AnimeRRModel result = AnimeRRModel.fromJson(json.decode(res.body));
      return result;
    }
    throw Exception('Error');
  }

  Future<AnimeSearchByGenres> getSearchByGenreAnime(
      {required String genre, required int page}) async {
    final res = await http.get(Uri.https(
        'sam-api-flask.herokuapp.com', 'anime/search/anime/$genre/$page'));
    if (res.statusCode == 200) {
      AnimeSearchByGenres result =
          AnimeSearchByGenres.fromJson(json.decode(res.body));
      return result;
    }
    throw Exception('Error');
  }

  Future<AnimeSearchByGenres> getAnimeSearch(
      {required String name, required int page}) async {
    final res = await http.get(
        Uri.https('sam-api-flask.herokuapp.com', '/anime/search/$name/$page'));
    if (res.statusCode == 200) {
      AnimeSearchByGenres result =
          AnimeSearchByGenres.fromJson(json.decode(res.body));
      return result;
    }
    throw Exception('Error');
  }

  Future<AnimeThisSeasonModel> getThisSeason(
      {required int year, required String season}) async {
    final res = await http.get(Uri.https(
        'sam-api-flask.herokuapp.com', '/anime/byseason/$year/$season'));
    if (res.statusCode == 200) {
      AnimeThisSeasonModel result =
          AnimeThisSeasonModel.fromJson(json.decode(res.body));
      print('Done');
      return result;
    }
    throw Exception('Error');
  }

  Future<AnimeThisSeasonModel> getGenresResults(
      {required String genre, required int page}) async {
    print('call hi');
    final res = await http.get(
        Uri.https('sam-api-flask.herokuapp.com', '/anime/genre/$genre/$page'));
    if (res.statusCode == 200) {
      AnimeThisSeasonModel result =
          AnimeThisSeasonModel.fromJson(json.decode(res.body));
      print('Done');
      return result;
    }
    throw Exception('Error');
  }
}
