import 'package:flutter/material.dart';
import 'package:sam_frontend/Constant/Colors.dart';
import 'package:sam_frontend/Screens/Movie_Descripetion.dart';

class MovieSearch extends StatelessWidget {
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
  const MovieSearch(
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
                ),
              ),
            );
          },
          child: Column(
            children: [
              // image
              Container(
                height: size.height * 0.34,
                width: size.width * 0.475,
                child: FadeInImage(
                  placeholder: AssetImage('assets/images/movieplaceholder.jpg'),
                  image: NetworkImage(
                      'https://image.tmdb.org/t/p/w500/$posterPath'),
                  fit: BoxFit.fill,
                ),
              ),
              // Title
              Container(
                padding: EdgeInsets.fromLTRB(12, 12, 0, 0),
                child: SizedBox(
                  child: Text(
                    originalTitle,
                    maxLines: 1,
                    overflow: TextOverflow.fade,
                    softWrap: false,
                    style: TextStyle(color: kPrimaryColor, fontSize: 15),
                  ),
                ),
              ),
              //release date
              Container(
                padding: EdgeInsets.fromLTRB(12, 12, 0, 12),
                child: Text(
                  '${releaseDate.year.toString()}',
                  style: TextStyle(fontSize: 12),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
