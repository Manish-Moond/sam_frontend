import 'package:flutter/material.dart';
import 'package:sam_frontend/Constant/Colors.dart';
import 'package:sam_frontend/Models/anime_by_season_model.dart';
import 'package:sam_frontend/Services/Anime_Servies.dart';

import 'Anime_Card.dart';

class AnimeThisSeason extends StatefulWidget {
  const AnimeThisSeason({Key? key}) : super(key: key);

  @override
  _AnimeThisSeasonState createState() => _AnimeThisSeasonState();
}

class _AnimeThisSeasonState extends State<AnimeThisSeason> {
  final HttpAnimeServices _httpAnimeServices = HttpAnimeServices();
  late Future<AnimeBySeasonModel> _thisSeason;
  // final AnimeHTTPServices animesHTTPServices = AnimeHTTPServices();

  @override
  void initState() {
    super.initState();
    _thisSeason = AnimeHTTPServices().getAnimeBySeason();
    // getData();
  }

  getData() async {
    print(_thisSeason);
    // print(_thisSeason.data![0].title);
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
        builder:
            (BuildContext context, AsyncSnapshot<AnimeBySeasonModel> snapshot) {
          if (snapshot.hasData) {
            List<Datum> animes = snapshot.data!.data!;
            print(animes);
            return Container(
              color: kPrimaryColor,
              child: RefreshIndicator(
                color: kSecondaryColor,
                backgroundColor: kPrimaryColor,
                onRefresh: () {
                  return _httpAnimeServices.getThisSeason(
                      year: 2021, season: 'summer', isRefresh: true);
                },
                child: ScrollConfiguration(
                  behavior: ScrollBehavior(),
                  child: GlowingOverscrollIndicator(
                    axisDirection: AxisDirection.down,
                    color: kSecondaryColor,
                    child: GridView.count(
                      childAspectRatio: (itemWidth / itemHeight),
                      crossAxisSpacing: 5,
                      mainAxisSpacing: 5,
                      crossAxisCount: 2,
                      children: [
                        ...animes.map(
                          (Datum _anime) => AnimeCard(
                            topOrNot: true,
                            malId: _anime.malId,
                            imageUrl: _anime.images!['jpg']!.imageUrl,
                            score: _anime.score!,
                            episodes: _anime.episodes!,
                            aired: [
                              convertToMonth(
                                  date: _anime.aired?.prop?.from?.month),
                              "${_anime.aired?.prop?.from?.day}"
                            ],
                            // genres: ani.genres,
                            // status:  _anime.status!,
                            title: _anime.title!,
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            );
          } else if (snapshot.hasError) {
            return Text('No Anime');
          }
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
