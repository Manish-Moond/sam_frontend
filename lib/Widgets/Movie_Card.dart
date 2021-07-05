import 'package:flutter/material.dart';
import 'package:sam_frontend/Constant/Colors.dart';
import 'package:sam_frontend/Screens/Movie_Descripetion.dart';

class MovieCard extends StatelessWidget {
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

  const MovieCard(
      {Key? key,
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
          elevation: 12,
      clipBehavior: Clip.hardEdge,
      semanticContainer: true,
      color: kPrimaryColor,
      child: InkWell(
        onTap: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (BuildContext context) => MovieD(
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
              height: size.height * 0.27,
              width: size.width * 0.40,
              child: FadeInImage(
                placeholder: AssetImage('assets/images/movieplaceholder.jpg'),
                image: posterPath == ''
                    ? NetworkImage('http://placeimg.com/640/360/any.jpg')
                    : NetworkImage(
                        'https://image.tmdb.org/t/p/w500/$posterPath'),
                fit: BoxFit.cover,
              ),
            ),
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
