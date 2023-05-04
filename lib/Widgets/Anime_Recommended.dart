import 'package:flutter/material.dart';
import 'package:sam_frontend/Constant/Colors.dart';
import 'package:sam_frontend/Models/Anime_Model.dart';

class RecommendedAnime extends StatelessWidget {
  final int malId;
  RecommendedAnime({Key? key, required this.malId}) : super(key: key);

  // final HttpAnimeServices _httpAnimeServices = HttpAnimeServices();

  @override
  Widget build(BuildContext context) {
    return Container(
      child: FutureBuilder(
        // future: _httpAnimeServices.getRRAnime(malId: malId),
        builder: (context, AsyncSnapshot<AnimeModel> snapshot) {
          // if (snapshot.hasData) {
          //   AnimeRRModel? _list = snapshot.data;
          //   _list!.recommendedList
          //       .asMap()
          //       .forEach((key, value) => RRAnime(malId: value));
          // }
          return Container(
            color: kPrimaryColor,
            child: Center(
              child: CircularProgressIndicator(
                color: kSecondaryColor,
              ),
            ),
          );
        },
      ),
    );
  }
}
