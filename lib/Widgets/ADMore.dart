import 'package:expandable_text/expandable_text.dart';
import 'package:flutter/material.dart';
import 'package:sam_frontend/Constant/Colors.dart';

class ADMore extends StatelessWidget {
  final int rank;
  final String title;
  final int? malId;
  final String imageUrl;
  final String type;
  final int episodes;
  // final List aired;
  final double score;
  final String synopsis;
  final int popularity;
  // final List<String> genre;
  // final Related related;

  const ADMore({
    Key? key,
    this.malId = 0,
    required this.rank,
    required this.title,
    required this.imageUrl,
    required this.type,
    required this.episodes,
    // required this.aired,
    required this.score,
    required this.synopsis,
    required this.popularity,
    required List<String> aired,
    // required this.genre,
    // required this.related,
  }) : super(key: key);

  String _g(genre) {
    String gnere = '';
    for (int i = 0; i < genre.length; i++) {
      gnere += genre[i] + '   ';
    }
    return gnere;
  }

  String _date(_d) {
    return episodes == 1 ? '${_d[0]}' : '${_d[0]}   to   ${_d[1]}';
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return ScrollConfiguration(
      behavior: ScrollBehavior(),
      child: GlowingOverscrollIndicator(
        axisDirection: AxisDirection.down,
        color: kSecondaryColor,
        child: SingleChildScrollView(
          child: Column(children: [
            SizedBox(
              height: size.height * 0.1,
            ),
            Row(
              children: [
                SizedBox(
                  width: size.width * 0.07,
                ),
                Container(
                  height: size.height * 0.38,
                  width: size.width * 0.47,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(8.0),
                    child: Image.network(
                      imageUrl,
                      fit: BoxFit.fill,
                    ),
                  ),
                ),
                Container(
                  height: size.height * 0.38,
                  width: size.width * 0.44,
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(20, 6, 0, 0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.fromLTRB(28, 24, 0, 10),
                          child: Column(
                            children: [
                              Text(
                                'Score',
                                style: TextStyle(
                                    fontSize: 18,
                                    color: kPrimaryColor,
                                    fontWeight: FontWeight.bold),
                              ),
                              Row(
                                children: [
                                  SizedBox(
                                    width: size.width * 0.07,
                                  ),
                                  Icon(
                                    Icons.star,
                                    size: 15,
                                  ),
                                  Text(
                                    '$score',
                                    style: TextStyle(
                                        fontSize: 15,
                                        color: kPrimaryColor,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ],
                              )
                            ],
                          ),
                        ),
                        Text(
                          'Type : $type',
                          style:
                              TextStyle(fontSize: 17, color: kSecondaryColor),
                        ),
                        Text(
                          'Episodes : $episodes',
                          style:
                              TextStyle(fontSize: 17, color: kSecondaryColor),
                        ),
                        Text(
                          'Rank : $rank',
                          style:
                              TextStyle(fontSize: 17, color: kSecondaryColor),
                        ),
                        Text(
                          'Popularity  : $popularity',
                          style:
                              TextStyle(fontSize: 17, color: kSecondaryColor),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            ScrollConfiguration(
              behavior: ScrollBehavior(),
              child: GlowingOverscrollIndicator(
                axisDirection: AxisDirection.down,
                color: kSecondaryColor,
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      SizedBox(
                        height: size.height * 0.07,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          //Title
                          Container(
                            child: SizedBox(
                              width: size.width * 0.8,
                              child: Text(
                                title,
                                overflow: TextOverflow.fade,
                                style: TextStyle(
                                    fontSize: 19,
                                    fontWeight: FontWeight.bold,
                                    color: kSecondaryColor),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: size.height * 0.02,
                          ),
                          // Story
                          Container(
                            child: SizedBox(
                              width: size.width * 0.8,
                              child: ExpandableText(
                                synopsis,
                                expandText: 'show more',
                                collapseText: 'show less',
                                linkColor: kThiredColor,
                                maxLines: 6,
                                animation: true,
                                collapseOnTextTap: true,
                                style: TextStyle(
                                    color: kFourthColor,
                                    fontSize: 12,
                                    fontWeight: FontWeight.normal),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: size.height * 0.02,
                          ),
                          //Genres
                          Container(
                            child: Container(
                              child: SizedBox(
                                width: size.width * 0.8,
                                child: Text(
                                  'Genre',
                                  overflow: TextOverflow.fade,
                                  style: TextStyle(
                                      fontSize: 17,
                                      fontWeight: FontWeight.bold,
                                      color: kSecondaryColor),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: size.height * 0.001,
                          ),
                          Container(
                            child: SizedBox(
                              width: size.width * 0.8,
                              child: Text(
                                _g("genre"),
                                overflow: TextOverflow.fade,
                                style: TextStyle(
                                    fontSize: 13,
                                    fontWeight: FontWeight.normal,
                                    color: kFourthColor),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: size.height * 0.02,
                          ),
                          //Aired
                          Container(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Container(
                                  child: SizedBox(
                                    width: size.width * 0.3,
                                    child: Text(
                                      "Aired",
                                      overflow: TextOverflow.fade,
                                      style: TextStyle(
                                          fontSize: 17,
                                          fontWeight: FontWeight.bold,
                                          color: kSecondaryColor),
                                    ),
                                  ),
                                ),
                                Text(
                                  _date("aired"),
                                  style: TextStyle(
                                      fontSize: 13,
                                      fontWeight: FontWeight.normal,
                                      color: kFourthColor),
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: size.height * 0.02,
                      ),
                      // Related Anime
                      Container(
                        child: Text(
                          "Related Anime",
                          style:
                              TextStyle(fontSize: 24, color: kSecondaryColor),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: ScrollConfiguration(
                          behavior: ScrollBehavior(),
                          child: GlowingOverscrollIndicator(
                            axisDirection: AxisDirection.down,
                            color: kSecondaryColor,
                            child: SingleChildScrollView(
                              scrollDirection: Axis.horizontal,
                              child: Row(
                                  // children: [
                                  //   ...related.adaptation.map((e) => RRAnime(
                                  //       malId: e.type == 'anime' ? e.malId : -1)),
                                  //   ...related.alternativeSetting.map((e) =>
                                  //       RRAnime(
                                  //           malId: e.type == 'anime'
                                  //               ? e.malId
                                  //               : -1)),
                                  //   ...related.alternativeVersion.map((e) =>
                                  //       RRAnime(
                                  //           malId: e.type == 'anime'
                                  //               ? e.malId
                                  //               : -1)),
                                  //   ...related.other.map((e) => RRAnime(
                                  //       malId: e.type == 'anime' ? e.malId : -1)),
                                  //   ...related.character.map((e) => RRAnime(
                                  //       malId: e.type == 'anime' ? e.malId : -1)),
                                  //   ...related.parentStory.map((e) => RRAnime(
                                  //       malId: e.type == 'anime' ? e.malId : -1)),
                                  //   ...related.prequel.map((e) => RRAnime(
                                  //       malId: e.type == 'anime' ? e.malId : -1)),
                                  //   ...related.sequel.map((e) => RRAnime(
                                  //       malId: e.type == 'anime' ? e.malId : -1)),
                                  //   ...related.spinOff.map((e) => RRAnime(
                                  //       malId: e.type == 'anime' ? e.malId : -1)),
                                  //   ...related.sideStory.map((e) => RRAnime(
                                  //       malId: e.type == 'anime' ? e.malId : -1)),
                                  //   ...related.summary.map((e) => RRAnime(
                                  //       malId: e.type == 'anime' ? e.malId : -1)),
                                  //   ...related.fullStory.map((e) => RRAnime(
                                  //       malId: e.type == 'anime' ? e.malId : -1)),
                                  // ],
                                  ),
                            ),
                          ),
                        ),
                      ),
                      Container(
                        child: Text(
                          "Recommended Anime",
                          style:
                              TextStyle(fontSize: 24, color: kSecondaryColor),
                        ),
                      ),
                      // RecommendedAnime(malId:malId),
                    ],
                  ),
                ),
              ),
            ),
          ]),
        ),
      ),
    );
  }
}
