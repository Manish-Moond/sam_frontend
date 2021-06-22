import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:sam_frontend/Models/Movie_Top_Model.dart';

class HttpMoviesServices {
  Future<TopRatedMoviesModel> getTopMovie(page) async {
    final res = await http.get(Uri.http("192.168.43.19:8089", "/topmovie/$page"));
    if (res.statusCode == 200) {
      TopRatedMoviesModel result =
          TopRatedMoviesModel.fromJson(json.decode(res.body));
      return result;
    }
    throw 'Error during fetching top movies';
  }
}
