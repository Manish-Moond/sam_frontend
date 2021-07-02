import 'package:flutter/material.dart';
import 'package:sam_frontend/Constant/Colors.dart';
import 'package:sam_frontend/Models/Anime_Model.dart';
import 'package:sam_frontend/Models/Anime_This_Season_Model.dart';
import 'package:sam_frontend/Services/Anime_Servies.dart';
import 'package:sam_frontend/Widgets/Anime_Card.dart';

import 'Anime_Modal.dart';

class AnimeThisSeason extends StatefulWidget {
  const AnimeThisSeason({Key? key}) : super(key: key);

  @override
  _AnimeThisSeasonState createState() => _AnimeThisSeasonState();
}

class _AnimeThisSeasonState extends State<AnimeThisSeason> {
  final HttpAnimeServices _httpAnimeServices = HttpAnimeServices();
  late Future<AnimeThisSeasonModel> _thisSeason;

  @override
  void initState() {
    super.initState();
    _thisSeason =
        _httpAnimeServices.getThisSeason(year: 2021, season: 'summer');
  }

  Map<int, String> _mon = {
    1: 'January',
    2: 'February',
    3: 'March',
    4: 'April',
    5: 'May',
    6: 'June',
    7: 'July',
    8: 'August',
    9: 'September',
    10: 'October',
    11: 'November',
    12: 'December'
  };
  convertToMonth({required date}) {
    return _mon[date];
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    /*24 is for notification bar on Android*/
    final double itemHeight = (size.height - size.height * 0.14) / 2;
    final double itemWidth = size.width / 2;
    return Container(
      height: 200,
      child: FutureBuilder(
        future: _thisSeason,
        builder: (BuildContext context,
            AsyncSnapshot<AnimeThisSeasonModel> snapshot) {
          if (snapshot.hasData) {
            AnimeThisSeasonModel? anime = snapshot.data;
            List<Anime> erer = anime!.anime;
            return Container(
              color: kPrimaryColor,
              child: GridView.count(
                  childAspectRatio: (itemWidth / itemHeight),
                  crossAxisSpacing: 5,
                  mainAxisSpacing: 5,
                  crossAxisCount: 2,
                  children: [
                    ...erer.map(
                      (Anime ani) => AnimeCard(
                        topOrNot: true,
                        malId: ani.malId,
                        imageUrl: ani.imageUrl,
                        episodes: ani.episodes,
                        aired: [
                          convertToMonth(date: ani.airingStart.month) +
                              ' ${ani.airingStart.day}'
                        ],
                        genres: ani.genres,
                        status: 'Aring',
                        title: ani.title,
                        related: Related(adaptation: [
                          Genre(malId: 1, type: '', name: '', url: '')
                        ], alternativeVersion: [
                          Genre(malId: -1, type: '', name: '', url: '')
                        ], sideStory: [
                          Genre(malId: -1, type: '', name: '', url: '')
                        ], spinOff: [
                          Genre(malId: -1, type: '', name: '', url: '')
                        ], alternativeSetting: [
                          Genre(malId: -1, type: '', name: '', url: '')
                        ], sequel: [
                          Genre(malId: -1, type: '', name: '', url: '')
                        ], other: [
                          Genre(malId: -1, type: '', name: '', url: '')
                        ], prequel: [
                          Genre(malId: -1, type: '', name: '', url: '')
                        ], summary: [
                          Genre(malId: -1, type: '', name: '', url: '')
                        ], character: [
                          Genre(malId: -1, type: '', name: '', url: '')
                        ], parentStory: [
                          Genre(malId: -1, type: '', name: '', url: '')
                        ], fullStory: [
                          Genre(malId: -1, type: '', name: '', url: '')
                        ]),
                      ),
                    )
                  ]),
            );
          } else if (snapshot.hasError) {
            return Text('No Anime');
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
