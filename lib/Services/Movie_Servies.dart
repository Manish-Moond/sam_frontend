import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:sam_frontend/Models/Movie_Model.dart';

class HttpMoviesServices {
  Future<MoviesModel> getTopMovie(page) async {
    final res =
        await http.get(Uri.http("192.168.43.19:8089", "/topmovie/$page"));
    if (res.statusCode == 200) {
      MoviesModel result = MoviesModel.fromJson(json.decode(res.body));
      return result;
    }
    throw 'Error during fetching top movies';
  }

  Future<MoviesModel> getNowPlaing(page) async {
    final res =
        await http.get(Uri.http('192.168.43.19:8089', '/nowplaying/$page'));
    if (res.statusCode == 200) {
      MoviesModel result = MoviesModel.fromJson(json.decode(res.body));
      return result;
    }
    throw 'Error from now playing';
  }

  Future<MoviesModel> getPopular(page) async {
    final res =
        await http.get(Uri.http('192.168.43.19:8089', '/popular/$page'));
    if (res.statusCode == 200) {
      print(res);
      MoviesModel result = MoviesModel.fromJson(json.decode(res.body));
      print(result);
      return result;
    }
    throw 'Error from now playing';
  }
}
