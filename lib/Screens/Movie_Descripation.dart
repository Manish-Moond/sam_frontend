import 'package:expandable_text/expandable_text.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:sam_frontend/Constant/Colors.dart';
import 'package:sam_frontend/Screens/Anime_Descripation.dart';

class MovieDescripation extends StatefulWidget {
  final List<int> genres;
  final int id;
  final String originalTitle;
  final String originalLanguage;
  final String overview;
  final String posterPath;
  final DateTime releaseDate;
  final String title;
  final double voteAverage;
  MovieDescripation(
      {Key? key,
      required this.genres,
      required this.id,
      required this.originalTitle,
      required this.originalLanguage,
      required this.overview,
      required this.posterPath,
      required this.releaseDate,
      required this.title,
      required this.voteAverage})
      : super(key: key);

  @override
  _MovieDescripationState createState() => _MovieDescripationState();
}

class _MovieDescripationState extends State<MovieDescripation> {
  bool _checked = false;
  Map<int, String> _genre = {
    28: 'Action',
    12: 'Adventure',
    16: 'Animation',
    35: 'Comedy',
    80: 'Crime',
    99: 'Decumentry',
    18: 'Drame',
    10751: 'Family',
    14: 'Fantasy',
    36: 'History',
    27: 'Horror',
    10402: 'Music',
    9648: 'Mystery',
    10749: 'Romance',
    878: 'Science Finction',
    10770: 'TV Movie',
    53: 'Thriller',
    10752: 'War',
    37: 'Western'
  };

  String _g(genre) {
    String res = '';
    for (int i = 0; i < genre.length; i++) {
      var re = _genre[genre[i]];
      res += re!;
      res += ' ';
    }
    return res;
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      body: CustomPaint(
        painter: BackgroundPainter(size),
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: size.height * 0.1,
              ),
              Row(
                children: [
                  SizedBox(
                    width: size.width * 0.05,
                  ),
                  //Image

                  Container(
                    height: size.height * 0.38,
                    width: size.width * 0.50,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(8.0),
                      child: FadeInImage(
                        placeholder:
                            AssetImage('assets/images/movieplaceholder.jpg'),
                        image: NetworkImage(
                            'https://image.tmdb.org/t/p/w500/${widget.posterPath}'),
                        fit: BoxFit.fill,
                      ),
                    ),
                  ),
                  SizedBox(
                    width: size.width * 0.02,
                  ),
                  //score
                  Container(
                    height: size.height * 0.38,
                    width: size.width * 0.40,
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(0, 6, 0, 0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.fromLTRB(0, 14, 10, 10),
                            child: Column(
                              children: [
                                Row(
                                  children: [
                                    SizedBox(
                                      width: size.width * 0.07,
                                    ),
                                    Icon(
                                      Icons.star,
                                      size: 25,
                                    ),
                                    Text(
                                      '${widget.voteAverage}',
                                      style: TextStyle(
                                          fontSize: 25,
                                          color: kPrimaryColor,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ],
                                )
                              ],
                            ),
                          ),
                          //cheaklist
                          Container(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(50),
                                color: kSecondaryColor),
                            child: CheckboxListTile(
                                title: Text(
                                  "Watched",
                                ),
                                controlAffinity:
                                    ListTileControlAffinity.leading,
                                value: _checked,
                                onChanged: (bool) {
                                  setState(() {
                                    _checked = !_checked;
                                  });
                                }),
                          ),
                          Container(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(50),
                                color: kSecondaryColor),
                            child: CheckboxListTile(
                                title: Text(
                                  "Wish",
                                ),
                                controlAffinity:
                                    ListTileControlAffinity.leading,
                                value: _checked,
                                onChanged: (bool) {
                                  setState(() {
                                    _checked = !_checked;
                                  });
                                }),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              //Descripation
              Column(
                children: [
                  SizedBox(
                    height: size.height * 0.07,
                  ),
                  Container(
                    child: SizedBox(
                      width: size.width * 0.8,
                      child: Text(
                        widget.originalTitle,
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
                  Container(
                    child: SizedBox(
                      width: size.width * 0.8,
                      child: ExpandableText(
                        widget.overview,
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
                        _g(widget.genres),
                        overflow: TextOverflow.fade,
                        style: TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.normal,
                            color: kFourthColor),
                      ),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
