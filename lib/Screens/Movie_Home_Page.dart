import 'package:flutter/material.dart';
import 'package:sam_frontend/Constant/Colors.dart';
import 'package:sam_frontend/Widgets/Movie_Genres.dart';
import 'package:sam_frontend/Widgets/Movie_Now_Playing.dart';
import 'package:sam_frontend/Widgets/Movie_Popular.dart';
import 'package:sam_frontend/Widgets/Movie_Top_Rated.dart';

class MovieHomePage extends StatelessWidget {
  const MovieHomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Container(
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
        ));
  }
}
