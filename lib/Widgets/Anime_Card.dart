import 'package:flutter/material.dart';
import 'package:sam_frontend/Constant/Colors.dart';
import 'package:sam_frontend/Models/Anime_Model.dart';
import 'package:sam_frontend/Screens/Anime_Descripation.dart';
import 'package:sam_frontend/Widgets/Anime_Modal.dart';

class AnimeCard extends StatelessWidget {
  final bool topOrNot;
  final int malId;
  final String url;
  final String imageUrl;
  final String trailerUrl;
  final String title;
  final String titleEnglish;
  final String titleJapanese;
  final List<String> titleSynonyms;
  final String type;
  final String source;
  final int episodes;
  final String status;
  final bool airing;
  final Aired aired;
  final String duration;
  final String rating;
  final double score;
  final int scoredBy;
  final int rank;
  final int popularity;
  final int members;
  final int favorites;
  final String synopsis;
  final String premiered;
  final String broadcast;
  final Related related;
  final List<Genre> producers;
  final List<Genre> licensors;
  final List<Genre> studios;
  final List<Genre> genres;
  const AnimeCard(
      {this.topOrNot = false,
      required this.malId,
      this.url = '',
      this.imageUrl = '',
      this.trailerUrl = '',
      this.title = '',
      this.titleEnglish = '',
      this.titleJapanese = '',
      this.titleSynonyms = const [""],
      this.type = '',
      this.source = '',
      required this.episodes,
      this.status = '',
      this.airing = false,
      required this.aired,
      this.duration = '',
      this.rating = '',
      this.score = -1.0,
      this.scoredBy = -1,
      this.rank = -1,
      this.popularity = -1,
      this.members = -1,
      this.favorites = -1,
      this.synopsis = '',
      this.premiered = '',
      this.broadcast = '',
      required this.related,
      required this.producers,
      required this.licensors,
      required this.studios,
      required this.genres});

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    print(imageUrl);
    return Container(
        child: Card(
      color: kSecondaryColor,
      semanticContainer: true,
      clipBehavior: Clip.hardEdge,
      child: InkWell(
        splashColor: Colors.blue.withAlpha(30),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (BuildContext context) => AnimeDescripation(
                    topOrNot: topOrNot,
                    malId: malId,
                    url: url,
                    imageUrl: imageUrl,
                    trailerUrl: trailerUrl,
                    titleEnglish: titleEnglish,
                    titleJapanese: titleJapanese,
                    titleSynonyms: titleSynonyms,
                    type: type,
                    score: score,
                    episodes: episodes,
                    status: status,
                    airing: airing,
                    duration: duration,
                    rating: rating,
                    source: source,
                    scoredBy: scoredBy,
                    rank: rank,
                    popularity: popularity,
                    members: members,
                    favorites: favorites,
                    synopsis: synopsis,
                    premiered: premiered,
                    aired: aired,
                    related: related,
                    producers: producers,
                    licensors: licensors,
                    studios: studios,
                    genres: genres)),
          );
        },
        child: Column(
          children: [
            Container(
              height: size.height * 0.34,
              width: size.width * 0.475,
              child: Image.network(
                imageUrl,
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
                            title,
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
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          // crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            Text(
                              "${aired.prop.from.year}" + '($episodes)',
                              style: TextStyle(fontSize: 12),
                            ),
                            SizedBox(
                              width: size.width * 0.08,
                            ),
                            Text(
                              '$score',
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
                              // border: Border.all(width: 1.0, color: kPrimaryColor),
                            ),
                            child: IconButton(
                              onPressed: () {
                                showModalBottomSheet<void>(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return AnimeModal(name: title);
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
    ));
  }
}
