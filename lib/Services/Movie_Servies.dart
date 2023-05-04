import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:sam_frontend/Constant/api_key.dart' as apiKey;
import 'package:sam_frontend/Models/Movies_Model.dart';

class HttpMoviesServices {
  Future<MoviesModel> getTrending(type, page) async {
    final res = await http.get(Uri.parse(
        "https://api.themoviedb.org/3/trending/movie/day?api_key=${apiKey.tbdbApiKey}"));
    if (res.statusCode == 200) {
      return moviesModelFromJson(res.body);
    }
    throw Exception("Error from movies trending");
  }

  Future<MoviesModel> getGenresMovies(genresId, page) async {
    final res = await http.get(Uri.parse(
        "https://api.themoviedb.org/3/discover/movie?api_key=${apiKey.tbdbApiKey}&language=en-US&with_genres=$genresId&page=$page"));
    if (res.statusCode == 200) {
      MoviesModel result = MoviesModel.fromJson(json.decode(res.body));
      return result;
    }
    throw 'Error from now Latest';
  }

  Future<MoviesModel> getTopMovies({int page = 0}) async {
    final res = await http.get(Uri.parse(
        "https://api.themoviedb.org/3/movie/top_rated?api_key=${apiKey.tbdbApiKey}&language=en-US&page=$page"));
    if (res.statusCode == 200) {
      return moviesModelFromJson(res.body);
    }
    throw Exception("Error from movies top rated");
  }

  Future<MoviesModel> getNowPlaing(page) async {
    final res = await http.get(Uri.parse(
        "https://api.themoviedb.org/3/movie/now_playing?api_key=${apiKey.tbdbApiKey}&language=en-US&page=$page"));
    if (res.statusCode == 200) {
      return moviesModelFromJson(res.body);
    }
    throw 'Error from now playing';
  }

  Future<MoviesModel> getPopular(page) async {
    final res = await http
        .get(Uri.https('sam-api-flask.herokuapp.com', '/movie/popular/$page'));
    if (res.statusCode == 200) {
      MoviesModel result = MoviesModel.fromJson(json.decode(res.body));
      return result;
    }
    throw 'Error from POPULAR movies';
  }

  Future<MoviesModel> getSearched(page, search) async {
    final res = await http.get(Uri.parse(
        "https://api.themoviedb.org/3/search/tv?api_key=${apiKey.tbdbApiKey}&language=en-US&query=$search&page=$page"));
    if (res.statusCode == 200) {
      return moviesModelFromJson(res.body);
    }
    throw 'Error from searched';
  }
}
