import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:sam_frontend/Models/Anime_Model.dart';
import 'package:sam_frontend/Models/Anime_RR_Model.dart';
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
    print(malId);
    final res = await http.get(Uri.http("192.168.43.19:8089", "/$malId"));
    print(res.statusCode);
    if (res.statusCode == 200) {
      print("errer");
      AnimeModel result = AnimeModel.fromJson(json.decode(res.body));
      print(result);
      print('call');
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
}
