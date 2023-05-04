import 'package:sam_frontend/Models/Person_Info_Model.dart';
import 'package:http/http.dart' as http;
import 'package:sam_frontend/Models/Person_Work_Model.dart';
import 'package:sam_frontend/Constant/api_key.dart' as apiKey;
import 'package:sam_frontend/Models/Person_Popular_Model.dart';

class HttpPersonServices {
  Future<PersonWorkModel> getPersonWork(personId) async {
    print("Person id $personId");
    final res = await http.get(Uri.parse(
        "https://api.themoviedb.org/3/person/$personId/movie_credits?api_key=${apiKey.tbdbApiKey}&language=en-US"));
    if (res.statusCode == 200) {
      return personWorkModelFromJson(res.body);
    }

    throw 'Error during fetching person work';
  }

  Future<PersonInfoModel> getPersonInfo(personId) async {
    final res = await http.get(Uri.parse(
        "https://api.themoviedb.org/3/person/$personId?api_key=${apiKey.tbdbApiKey}&language=en-US"));
    if (res.statusCode == 200) {
      return personInfoModelFromJson(res.body);
    }

    throw 'Error during fetching person work';
  }

  Future<PersonPopularModel> getPopularPerson(page) async {
    final res = await http.get(Uri.parse(
        "https://api.themoviedb.org/3/person/popular?api_key=${apiKey.tbdbApiKey}&language=en-US&page=$page"));
    if (res.statusCode == 200) {
      return popularPersonModelFromJson(res.body);
    }

    throw 'Error during fetching person popular';
  }
}
