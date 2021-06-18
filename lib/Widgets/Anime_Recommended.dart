import 'package:flutter/material.dart';
import 'package:sam_frontend/Constant/Colors.dart';
import 'package:sam_frontend/Models/Anime_RR_Model.dart';
import 'package:sam_frontend/Services/Anime_Servies.dart';
import 'package:sam_frontend/Widgets/Anime_RR.dart';

class RecommendedAnime extends StatelessWidget {
  final int malId;
  RecommendedAnime({Key? key, required this.malId}) : super(key: key);

  final HttpAnimeServices _httpAnimeServices = HttpAnimeServices();

  @override
  Widget build(BuildContext context) {
    return Container(
      child: FutureBuilder(
        future: _httpAnimeServices.getRRAnime(malId: malId),
        builder: (context, AsyncSnapshot<AnimeRRModel> snapshot) {
          if (snapshot.hasData) {
            AnimeRRModel? _list = snapshot.data;
            _list!.recommendedList.asMap().forEach((key, value) => RRAnime(malId: value));
          }
          return Container(
            color: kPrimaryColor,
            child: Center(
              child: CircularProgressIndicator(),
            ),
          );
        },
      ),
    );
  }
}
