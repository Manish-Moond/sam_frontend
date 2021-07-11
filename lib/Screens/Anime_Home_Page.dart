import 'package:flutter/material.dart';
import 'package:sam_frontend/Widgets/Anime_Search.dart';
import 'package:sam_frontend/Widgets/Anime_This_Season.dart';
import 'package:sam_frontend/Widgets/Anime_Top_Slider.dart';
import 'package:sam_frontend/Widgets/Anime_For_You.dart';

class AnimeHomePage extends StatefulWidget {
  final String searchParam;

  const AnimeHomePage({Key? key, required this.searchParam}) : super(key: key);

  @override
  _AnimeHomePageState createState() => _AnimeHomePageState();
}

class _AnimeHomePageState extends State<AnimeHomePage> {
  String value = 'This Season';
  void animeToggler(newValue) {
    setState(() {
      value = newValue;
    });
  }

  @override
  Widget build(BuildContext context) {
    return widget.searchParam == ''
        ? Column(
            children: [
              AnimeTopSlider(
                animeToggler: animeToggler,
                selected: value,
              ),
              value == 'This Season'
                  ? Expanded(child: AnimeThisSeason())
                  : Expanded(child: AnimeForYou())
            ],
          )
        : AnimeSearchedByName(search: widget.searchParam);
  }
}

