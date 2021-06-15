// @dart=2.9

import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:sam_frontend/Constant/Colors.dart';
import 'package:sam_frontend/Models/Anime_Model.dart';
import 'package:sam_frontend/Models/Anime_Top_Model.dart';
import 'package:sam_frontend/Services/Anime_Servies.dart';
import 'package:sam_frontend/Widgets/Anime_Card.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final HttpAnimeServices _httpTopAnimeServices = HttpAnimeServices();
  Future<AnimeTopModel> _topAnime;
  var _isSearching = false;
  @override
  void initState() {
    super.initState();
    _topAnime = _httpTopAnimeServices.getTopAnime();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    /*24 is for notification bar on Android*/
    final double itemHeight = (size.height - size.height * 0.14) / 2;
    final double itemWidth = size.width / 2;

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: kPrimaryColor,
        title: !_isSearching
            ? Text(
                "Anime",
                style: TextStyle(
                    color: kSecondaryColor,
                    fontSize: 25,
                    fontWeight: FontWeight.bold),
              )
            : TextField(
                style: TextStyle(color: kFourthColor),
                decoration: InputDecoration(
                    enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: kSecondaryColor)),
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: kSecondaryColor),
                    ),
                    hintText: "anime search",
                    hintStyle: TextStyle(
                      color: kFourthColor.withOpacity(0.3),
                    )),
              ),
        actions: [
          _isSearching
              ? IconButton(
                  onPressed: () {
                    setState(() {
                      this._isSearching = !this._isSearching;
                    });
                  },
                  icon: Icon(
                    Icons.cancel_outlined,
                    color: kSecondaryColor,
                    size: 30,
                  ))
              : IconButton(
                  onPressed: () {
                    setState(() {
                      this._isSearching = !this._isSearching;
                    });
                  },
                  icon: Icon(
                    Icons.search,
                    color: kSecondaryColor,
                    size: 30,
                  ))
        ],
      ),
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
        },
      ),
      body: FutureBuilder(
        future: _topAnime,
        builder: (BuildContext context, AsyncSnapshot<AnimeTopModel> snapshot) {
          if (snapshot.hasData) {
            AnimeTopModel anime = snapshot.data;
            List<Top> erer = anime.top;
            return Container(
              color: kPrimaryColor,
              child: GridView.count(
                  childAspectRatio: (itemWidth / itemHeight),
                  crossAxisSpacing: 5,
                  mainAxisSpacing: 5,
                  crossAxisCount: 2,
                  children: [
                    ...erer.map((Top ani) => AnimeCard(
                          topOrNot: true,
                          imageUrl: ani.imageUrl,
                          malId: ani.malId,
                          rank: ani.rank,
                          title: ani.title,
                          score: ani.score,
                          episodes: ani.episodes,
                          genres: [],
                          aired: [ani.startDate],
                          status: '',
                          related: Related(adaptation: [
                            Genre(malId: 1, type: '', name: '', url: '')
                          ], alternativeVersion: [
                            Genre(malId: -1, type: '', name: '', url: '')
                          ], sideStory: [
                            Genre(malId: -1, type: '', name: '', url: '')
                          ], spinOff: [
                            Genre(malId: -1, type: '', name: '', url: '')
                          ], alternativeSetting: [
                            Genre(malId: -1, type: '', name: '', url: '')
                          ], sequel: [
                            Genre(malId: -1, type: '', name: '', url: '')
                          ], other: [
                            Genre(malId: -1, type: '', name: '', url: '')
                          ], prequel: [
                            Genre(malId: -1, type: '', name: '', url: '')
                          ], summary: [
                            Genre(malId: -1, type: '', name: '', url: '')
                          ], character: [
                            Genre(malId: -1, type: '', name: '', url: '')
                          ], parentStory: [
                            Genre(malId: -1, type: '', name: '', url: '')
                          ], fullStory: [
                            Genre(malId: -1,type: '', name: '', url: '')
                          ]),
                        )),
                  ]),
            );
          } else if (snapshot.hasError) {
            return Text('No Anime');
          }
          return Container(
            color: kPrimaryColor,
            child: Center(
              child: CircularProgressIndicator(),
            ),
          );
        },
      ),
    );
  }
}
