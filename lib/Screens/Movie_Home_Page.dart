import 'package:flutter/material.dart';
import 'package:sam_frontend/Constant/Colors.dart';
import 'package:sam_frontend/Widgets/Movie_Genres.dart';
import 'package:sam_frontend/Widgets/Movie_Now_Playing.dart';
import 'package:sam_frontend/Widgets/Movie_Popular.dart';
import 'package:sam_frontend/Widgets/Movie_Top_Rated.dart';
import 'package:sam_frontend/Widgets/Searched_Movie.dart';

class MovieHomePage extends StatefulWidget {
  final String searchParam;
  const MovieHomePage({Key? key, required this.searchParam}) : super(key: key);

  @override
  _MovieHomePageState createState() => _MovieHomePageState();
}

class _MovieHomePageState extends State<MovieHomePage> {
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return
      widget.searchParam == '' ?
     Container(
        color: kPrimaryColor,
        child: Padding(
          padding: const EdgeInsets.all(6.0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                MovieGenres(),
                SizedBox(
                  height: size.height * 0.005,
                ),
                Text(
                  'Top Rated',
                  style: TextStyle(fontSize: 20, color: kSecondaryColor),
                ),
                SizedBox(
                  height: size.height * 0.011,
                ),
                MovieTopRated(),
                SizedBox(
                  height: size.height * 0.005,
                ),
                Text(
                  'Now playing',
                  style: TextStyle(fontSize: 20, color: kSecondaryColor),
                ),
                SizedBox(
                  height: size.height * 0.011,
                ),
                MovieNowPlaying(),
                SizedBox(
                  height: size.height * 0.005,
                ),
                Text(
                  'Popular',
                  style: TextStyle(fontSize: 20, color: kSecondaryColor),
                ),
                SizedBox(
                  height: size.height * 0.011,
                ),
                MoviePopular(),
              ],
            ),
          ),
        ))
        : SearchedMovie(search: widget.searchParam);
  }
}
