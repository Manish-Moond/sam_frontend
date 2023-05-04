import 'package:http/http.dart' as http;
import 'package:sam_frontend/Constant/api_key.dart';
import 'package:sam_frontend/Models/Movies_Tv_Series_Model.dart';

class HttpTvSeriesServices {
  Future<MoviesTvSeriesModel> getTSTrending({required int page}) async {
    int page = 1;
    final res = await http.get(Uri.parse(
        "https://api.themoviedb.org/3/trending/tv/day?api_key=$tbdbApiKey&page=$page"));
    if (res.statusCode == 200) {
      return moviesTvSeriesModelFromJson(res.body);
    }
    throw Exception("Error from TS trending");
  }

  Future<MoviesTvSeriesModel> getTSTopRated(
      {required int page, bool isRefresh = false}) async {
    final res = await http.get(Uri.parse(
        "https://api.themoviedb.org/3/tv/top_rated?api_key=$tbdbApiKey&language=en-US&page=$page"));
    if (res.statusCode == 200) {
      final result = moviesTvSeriesModelFromJson(res.body);
      return result;
    }
    throw 'Error from now Latest';
  }

  Future<MoviesTvSeriesModel> getTSPopular(page) async {
    final res = await http.get(Uri.parse(
        "https://api.themoviedb.org/3/tv/popular?api_key=$tbdbApiKey&language=en-US&page=$page"));
    if (res.statusCode == 200) {
      return moviesTvSeriesModelFromJson(res.body);
    }
    throw 'Error from now Latest';
  }

  Future<MoviesTvSeriesModel> getTSSearch(
      {required int page, required String name}) async {
    final res = await http.get(Uri.parse(
        "https://api.themoviedb.org/3/search/tv?api_key=$tbdbApiKey&language=en-US&query=$name&page=$page"));
    if (res.statusCode == 200) {
      return moviesTvSeriesModelFromJson(res.body);
    }
    throw 'Error from search';
  }

  Future<MoviesTvSeriesModel> getTSGenreResult({page, genreId}) async {
    final res = await http.get(Uri.parse(
        "https://api.themoviedb.org/3/discover/tv?api_key=$tbdbApiKey&page=$page&with_genres=$genreId"));
    if (res.statusCode == 200) {
      return moviesTvSeriesModelFromJson(res.body);
    }
    throw 'Error from search';
  }
}
