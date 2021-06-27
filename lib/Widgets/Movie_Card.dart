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
      required this.title, required this.voteAverage})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Container(
        child: Card(
      clipBehavior: Clip.hardEdge,
      semanticContainer: true,
      color: kSecondaryColor,
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
          children: [
            Container(
              height: size.height * 0.288,
              width: size.width * 0.373,
              child: FadeInImage(
                placeholder: AssetImage('assets/images/movieplaceholder.jpg'),
                image:
                    NetworkImage('https://image.tmdb.org/t/p/w500/$posterPath'),
                fit: BoxFit.fill,
              ),
            )
          ],
        ),
      ),
    ));
  }
}
