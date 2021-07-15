import 'package:flutter/material.dart';
import 'package:sam_frontend/Constant/Colors.dart';
import 'package:sam_frontend/Models/Anime_Model.dart';
import 'package:sam_frontend/Models/Anime_Search_By_Name_Model.dart';
import 'package:sam_frontend/Services/Anime_Servies.dart';
import 'package:sam_frontend/Widgets/Anime_Card.dart';

class AnimeSearchedByName extends StatefulWidget {
  final String search;

  const AnimeSearchedByName({Key? key, required this.search}) : super(key: key);

  @override
  _AnimeSearchedByNameState createState() => _AnimeSearchedByNameState();
}

class _AnimeSearchedByNameState extends State<AnimeSearchedByName> {
  final HttpAnimeServices _httpAnimeServices = HttpAnimeServices();
  List<SearchAnimeResult> _anime = [];
  ScrollController _scrollController = ScrollController();
  int _page = 1;
  void filler(value) {
    setState(() {
      for (int i = 0; i < value.searchAnimeResult.length; i++) {
        _anime.add(value.searchAnimeResult[i]);
      }
    });
  }

  @override
  void initState() {
    super.initState();
    _httpAnimeServices
        .getSearchByName(name: widget.search, page: _page)
        .then((value) => filler(value));
    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        _page += 1;
        _httpAnimeServices
            .getSearchByName(name: widget.search, page: _page)
            .then((value) => filler(value));
      }
    });
  }

  @override
  void didUpdateWidget(covariant AnimeSearchedByName oldWidget) {
    if (this.widget.search != oldWidget.search) {
      _anime = [];
      _page = 1;
      _httpAnimeServices
          .getSearchByName(name: widget.search, page: _page)
          .then((value) => filler(value));
    }
    super.didUpdateWidget(oldWidget);
  }

  Map<int, String> _mon = {
    1: 'Jan',
    2: 'Febr',
    3: 'March',
    4: 'April',
    5: 'May',
    6: 'June',
    7: 'July',
    8: 'August',
    9: 'Sept',
    10: 'Octo',
    11: 'Nove',
    12: 'Dece'
  };
  convertToMonth({required date}) {
    return _mon[date];
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    final double itemHeight = (size.height - size.height * 0.14) / 2;
    final double itemWidth = size.width / 2;
    return Container(
      color: kPrimaryColor,
      child: _anime.length == 0
          ? Container(
              color: kPrimaryColor,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        CircularProgressIndicator(),
                      ]),
                ],
              ),
            )
          : GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                childAspectRatio: (itemWidth / itemHeight),
                crossAxisCount: 2,
              ),
              controller: _scrollController,
              itemCount: _anime.length,
              itemBuilder: (context, index) {
                return AnimeCard(
                    topOrNot: true,
                    malId: _anime[index].malId,
                    title: _anime[index].title,
                    episodes: _anime[index].episodes,
                    genres: [''],
                    status: 'Dont Know',
                    imageUrl: _anime[index].imageUrl,
                    score: _anime[index].score,
                    aired: [
                      convertToMonth(date: _anime[index].startDate.month) +
                          ' ${_anime[index].startDate.year}'
                    ],
                    related: Related(adaptation: [
                      Genre(malId: 1, name: '', type: '', url: '')
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
                      Genre(malId: -1, type: '', name: '', url: '')
                    ]));
              }),
    );
  }
}