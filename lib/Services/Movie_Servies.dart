import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:sam_frontend/Models/Movie_Model.dart';

class HttpMoviesServices {
  Future<MoviesModel> getTopMovie(page) async {
    final res = await http
        .get(Uri.https("sam-api-flask.herokuapp.com", "/topmovie/$page"));
    if (res.statusCode == 200) {
      MoviesModel result = MoviesModel.fromJson(json.decode(res.body));
      return result;
    }
    throw 'Error during fetching top movies';
  }

  Future<MoviesModel> getNowPlaing(page) async {
    final res = await http
        .get(Uri.https('sam-api-flask.herokuapp.com', '/nowplaying/$page'));
    if (res.statusCode == 200) {
      MoviesModel result = MoviesModel.fromJson(json.decode(res.body));
      return result;
    }
    throw 'Error from now playing';
  }

  Future<MoviesModel> getPopular(page) async {
    final res = await http
        .get(Uri.https('sam-api-flask.herokuapp.com', '/popular/$page'));
    if (res.statusCode == 200) {
      MoviesModel result = MoviesModel.fromJson(json.decode(res.body));
      return result;
    }
    throw 'Error from now playing';
  }

  Future<MoviesModel> getSearched(page, search) async {
    final res = await http.get(
        Uri.https('sam-api-flask.herokuapp.com', '/searched/$search/$page'));
    if (res.statusCode == 200) {
      MoviesModel result = MoviesModel.fromJson(json.decode(res.body));
      return result;
    }
    // ignore: todo
    // TODO: handle proper error when there is no movie for given name
    throw 'Error from searched';
  }
}
