import 'package:flutter/material.dart';
import 'package:sam_frontend/Constant/Colors.dart';
import 'package:sam_frontend/Models/Anime_This_Season_Model.dart';
import 'package:sam_frontend/Services/Anime_Servies.dart';

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

  String? convertToMonth(int date) {
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
    return _mon[date];
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    /*24 is for notification bar on Android*/
    final double itemHeight = (size.height - size.height * 0.25) / 2;
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
                      (Anime ani) => Card(
                        color: kSecondaryColor,
                        semanticContainer: true,
                        clipBehavior: Clip.hardEdge,
                        // child: InkWell(
                        //   splashColor: Colors.blue.withAlpha(30),
                        //   onTap: () {
                        //     Navigator.push(
                        //       context,
                        //       MaterialPageRoute(
                        //           builder: (BuildContext context) =>
                        //               AnimeDescripation(
                        //                   topOrNot: topOrNot,
                        //                   title: title,
                        //                   malId: malId,
                        //                   imageUrl: imageUrl,
                        //                   type: type,
                        //                   score: score,
                        //                   episodes: episodes,
                        //                   status: status,
                        //                   source: source,
                        //                   rank: rank,
                        //                   popularity: popularity,
                        //                   synopsis: synopsis,
                        //                   aired: aired,
                        //                   related: related,
                        //                   genres: genres)),
                        //     );
                        //   },
                        child: Column(
                          children: [
                            Container(
                              height: size.height * 0.30,
                              width: size.width * 0.475,
                              child: Image.network(
                                ani.imageUrl,
                                fit: BoxFit.fill,
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.fromLTRB(2, 4, 0, 0),
                              child: Container(
                                child: Row(
                                  children: [
                                    Column(
                                      children: [
                                        SizedBox(
                                          width: size.width * 0.35,
                                          child: Text(
                                            ani.title,
                                            maxLines: 1,
                                            overflow: TextOverflow.fade,
                                            softWrap: false,
                                            style: TextStyle(
                                                color: Colors.black,
                                                fontWeight: FontWeight.w400,
                                                fontSize: 14.0),
                                          ),
                                        ),
                                        SizedBox(
                                          height: size.height * 0.01,
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              "${convertToMonth(ani.airingStart.month)} ${ani.airingStart.day}" +
                                                  '  (${ani.episodes})',
                                              style: TextStyle(fontSize: 12),
                                            ),
                                            SizedBox(
                                              width: size.width * 0.04,
                                            ),
                                            Text(
                                              '${ani.score == -1 ? 'N' : ani.score}',
                                              style: TextStyle(fontSize: 12),
                                            ),
                                            Icon(
                                              Icons.star_rate,
                                              size: 12,
                                            )
                                          ],
                                        ),
                                      ],
                                    ),
                                    Column(
                                      children: [
                                        SizedBox(
                                          height: 40,
                                          width: 40,
                                          child: DecoratedBox(
                                            decoration: BoxDecoration(
                                              color: kPrimaryColor,
                                              shape: BoxShape.circle,
                                            ),
                                            child: IconButton(
                                              onPressed: () {
                                                showModalBottomSheet<void>(
                                                  context: context,
                                                  builder:
                                                      (BuildContext context) {
                                                    return AnimeModal(
                                                        name: ani.title);
                                                  },
                                                );
                                              },
                                              icon: Icon(
                                                Icons.add,
                                                color: Colors.white,
                                                size: 24,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    )
                                  ],
                                ),
                              ),
                            )
                          ],
                        ),
                        // shape: RoundedRectangleBorder(
                        //   borderRadius: BorderRadius.circular(4.0),
                        // ),
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
