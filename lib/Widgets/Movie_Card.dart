import 'package:flutter/material.dart';
import 'package:sam_frontend/Constant/Colors.dart';

class MovieCard extends StatelessWidget {
  final List<int> genres;
  final int id;
  final String originalTitle;
  final String originalLanguage;
  final String overview;
  final String posterPath;
  final DateTime releaseDate;
  final String title;

  const MovieCard(
      {Key? key,
      required this.genres,
      required this.id,
      required this.originalTitle,
      required this.originalLanguage,
      required this.overview,
      required this.posterPath,
      required this.releaseDate,
      required this.title})
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
        child: Column(
          children: [
            Container(
              height: size.height * 0.27,
              width: size.width * 0.373,
              child: Image.network(
                'https://image.tmdb.org/t/p/w500/$posterPath',
                fit: BoxFit.fill,
              ),
            )
          ],
        ),
      ),
    ));
  }
}
