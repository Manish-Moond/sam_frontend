import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:sam_frontend/Screens/About.dart';
import 'package:sam_frontend/Screens/Anime_Home_Page.dart';
import 'package:sam_frontend/Screens/My_List_Home_Page.dart';
import 'package:sam_frontend/Screens/Tv_Series_Home_Page.dart';
import 'package:sam_frontend/Widgets/Custom_App_Bar.dart';

import 'Constant/Colors.dart';
import 'Screens/Movie_Home_Page.dart';

class HomePage extends StatefulWidget {
  HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _index = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(),
      bottomNavigationBar: CurvedNavigationBar(
        backgroundColor: kPrimaryColor,
        color: kSecondaryColor,
        // index: 4,
        items: <Widget>[
          Icon(Icons.movie, size: 30),
          Icon(Icons.tv, size: 30),
          Icon(Icons.compare_arrows, size: 30),
          Icon(Icons.list, size: 30),
          Icon(Icons.more_horiz, size: 30)
        ],
        onTap: (index) {
          //Handle button tap
          _index = index;
          setState(() {
            _index = index;
          });
        },
      ),
      body: (() {
        switch (_index) {
          case 0:
            return MovieHomePage();
          case 1:
            return AnimeHomePage();
          case 2:
            return TvSeriesHomePage();
          case 3:
            return MyListHomePage();
          case 4:
            return About();
          default:
        }
      }()),
    );
  }
}
