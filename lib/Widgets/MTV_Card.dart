import 'package:flutter/material.dart';
import 'package:sam_frontend/Constant/Colors.dart';
import 'package:sam_frontend/Screens/Movie_Descripetion.dart';

class MTVCard extends StatelessWidget {
  final bool searcedOrNot;
  final List<int> genres;
  final int id;
  final String originalTitle;
  final String originalLanguage;
  final String overview;
  final String posterPath;
  final DateTime releaseDate;
  final String title;
  final double voteAverage;
  final String backdropPath;

  const MTVCard(
      {Key? key,
      this.searcedOrNot = false,
      required this.genres,
      required this.id,
      required this.originalTitle,
      required this.originalLanguage,
      required this.overview,
      required this.posterPath,
      required this.backdropPath,
      required this.releaseDate,
      required this.title,
      required this.voteAverage})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Container(
        child: Card(
      elevation: 2,
      clipBehavior: Clip.hardEdge,
      semanticContainer: true,
      color: kPrimaryColor,
      child: InkWell(
        onTap: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (BuildContext context) => MovieDescripation(
                        genres: genres,
                        id: id,
                        originalTitle: originalTitle,
                        originalLanguage: originalLanguage,
                        overview: overview,
                        backdropPath: backdropPath,
                        posterPath: posterPath,
                        releaseDate: releaseDate,
                        title: title,
                        voteAverage: voteAverage,
                      )));
        },
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
                height: searcedOrNot ? size.height * 0.28 : size.height * 0.27,
                width: searcedOrNot ? size.width * 0.48 : size.width * 0.41,
                child: FadeInImage(
                  placeholder: AssetImage('assets/images/movieplaceholder.jpg'),
                  image: NetworkImage(
                      'https://image.tmdb.org/t/p/w500/$posterPath'),
                  fit: BoxFit.cover,
                )),
            Container(
              margin: EdgeInsets.fromLTRB(6, 6, 0, 6),
              child: SizedBox(
                width: size.width * 0.38,
                child: Text(
                  title,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(color: kSecondaryColor),
                ),
              ),
            ),
            Row(
              children: [
                Container(
                  padding: EdgeInsets.fromLTRB(10, 0, 0, 0),
                  child: Text(
                    '$voteAverage',
                    style: TextStyle(color: kSecondaryColor),
                  ),
                ),
                SizedBox(
                  width: size.width * 0.02,
                ),
                Container(
                  child: Icon(
                    Icons.star,
                    color: kSecondaryColor,
                    size: 14,
                  ),
                ),
                SizedBox(
                  width: size.width * 0.16,
                ),
                Container(
                  child: Text(
                    '${releaseDate.year.toString()}',
                    style: TextStyle(color: kSecondaryColor),
                  ),
                )
              ],
            )
          ],
        ),
      ),
    ));
  }
}
