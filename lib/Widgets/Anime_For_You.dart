import 'package:flutter/material.dart';
import 'package:sam_frontend/Constant/Colors.dart';
import 'package:sam_frontend/Models/Anime_Model.dart';
import 'package:sam_frontend/Models/Anime_This_Season_Model.dart';
import 'package:sam_frontend/Models/Anime_Top_Model.dart';
import 'package:sam_frontend/Services/Anime_Servies.dart';

import 'Anime_Card.dart';

class AnimeForYou extends StatefulWidget {
  const AnimeForYou({Key? key}) : super(key: key);

  @override
  _AnimeForYouState createState() => _AnimeForYouState();
}

class _AnimeForYouState extends State<AnimeForYou> {
  String selected = 'All';
  void selectFunction(String newValue) {
    if (mounted) {
      setState(() {
        selected = newValue;
        print(selected);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        AnimeGenres(selectedFunction: selectFunction, selectedValue: selected),
        selected == 'All'
            ? AnimeTopRated()
            : AnimeGenresResults(
                selected: selected,
              )
      ],
    );
  }
}

class AnimeGenres extends StatelessWidget {
  final Function selectedFunction;
  final String selectedValue;

  AnimeGenres(
      {Key? key, required this.selectedFunction, required this.selectedValue})
      : super(key: key);
  final List<String> _genre = [
    'Action',
    'Adventure',
    'Cars',
    'Comedy',
    'Dementia',
    'Demons',
    'Mystery',
    'Drama',
    'Ecchi',
    'Fantasy',
    'Game',
    'Hentai',
    'Historical',
    'Horror',
    'Kids',
    'Magic',
    'Martial Arts',
    'Mecha',
    'Music',
    'Parody',
    'Samurai',
    'Romance',
    'School',
    'Sci Fi',
    'Shoujo',
    'Shoujo Ai',
    'Shounen',
    'Shounen Ai',
    'Space',
    'Sports',
    'Super Power',
    'Vampire',
    'Yaoi',
    'Yuri',
    'Harem',
    'Slice Of Life',
    'Supernatural',
    'Military',
    'Police',
    'Psychological',
    'Thriller',
    'Seinen',
    'Josei'
  ];
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Container(
      color: kPrimaryColor,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: size.height * 0.01,
          ),
          Container(
              height: 60,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(0, 0, 12, 6),
                    child: GestureDetector(
                      onTap: () {
                        selectedFunction('All');
                      },
                      child: Chip(
                        label: Text(
                          'All',
                          style: TextStyle(
                              color: selectedValue == 'All'
                                  ? kPrimaryColor
                                  : kSecondaryColor),
                        ),
                        backgroundColor: selectedValue == 'All'
                            ? kSecondaryColor
                            : kPrimaryColor,
                      ),
                    ),
                  ),
                  ..._genre.map((e) => Padding(
                        padding: const EdgeInsets.fromLTRB(0, 0, 12, 6),
                        child: GestureDetector(
                          onTap: () {
                            selectedFunction(e);
                          },
                          child: Chip(
                            elevation: 0,
                            shadowColor: kPrimaryColor,
                            clipBehavior: Clip.antiAlias,
                            backgroundColor: selectedValue == e
                                ? kSecondaryColor
                                : kPrimaryColor,
                            label: Text(
                              e,
                              style: TextStyle(
                                  color: selectedValue == e
                                      ? kPrimaryColor
                                      : kSecondaryColor),
                            ),
                          ),
                        ),
                      ))
                ],
              )),
        ],
      ),
    );
  }
}

class AnimeGenresResults extends StatefulWidget {
  final String selected;

  const AnimeGenresResults({Key? key, required this.selected})
      : super(key: key);
  @override
  _AnimeGenresResultsState createState() => _AnimeGenresResultsState();
}

class _AnimeGenresResultsState extends State<AnimeGenresResults> {
  final HttpAnimeServices _httpAnimeServices = HttpAnimeServices();
  List<Anime> _anime = [];
  ScrollController _scrollController = ScrollController();
  int _page = 1;

  void filler(value) {
    setState(() {
      for (int i = 0; i < value.anime.length; i++) {
        _anime.add(value.anime[i]);
      }
    });
  }

  @override
  void initState() {
    super.initState();
    _httpAnimeServices
        .getGenresResults(genre: widget.selected, page: _page)
        .then((value) => filler(value));
    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        _page += 1;
        _httpAnimeServices
            .getGenresResults(genre: widget.selected, page: _page)
            .then((value) {
          filler(value);
        });
      }
    });
  }

  @override
  void didUpdateWidget(covariant AnimeGenresResults oldWidget) {
    if (this.widget.selected != oldWidget.selected) {
      _anime = [];
      _page = 1;
      _httpAnimeServices
          .getGenresResults(genre: widget.selected, page: _page)
          .then((value) => filler(value));
    }

    super.didUpdateWidget(oldWidget);
  }

  Map<int, String> _mon = {
    1: 'Janua..',
    2: 'Febru..',
    3: 'March',
    4: 'April',
    5: 'May',
    6: 'June',
    7: 'July',
    8: 'August',
    9: 'Sept..',
    10: 'Octob..',
    11: 'Novem..',
    12: 'Decem..'
  };
  convertToMonth({required date}) {
    return _mon[date];
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    final double itemHeight = (size.height - size.height * 0.14) / 2;
    final double itemWidth = size.width / 2;
    return Expanded(
      child: Container(
          color: kPrimaryColor,
          child: _anime.isEmpty
              ? Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [CircularProgressIndicator()],
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
                        genres: _anime[index].genres,
                        status: 'Dont Know',
                        imageUrl: _anime[index].imageUrl,
                        score: _anime[index].score,
                        aired: [
                          convertToMonth(
                                  date: _anime[index].airingStart.month) +
                              ' ${_anime[index].airingStart.year}'
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
                  })),
    );
  }
}

class AnimeTopRated extends StatefulWidget {
  @override
  _AnimeTopRatedState createState() => _AnimeTopRatedState();
}

class _AnimeTopRatedState extends State<AnimeTopRated> {
  final HttpAnimeServices _httpTopAnimeServices = HttpAnimeServices();
  late Future<AnimeTopModel> _topAnime;
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

    return Expanded(
      child: Container(
        child: FutureBuilder(
          future: _topAnime,
          builder:
              (BuildContext context, AsyncSnapshot<AnimeTopModel> snapshot) {
            if (snapshot.hasData) {
              AnimeTopModel? anime = snapshot.data;
              List<Top> erer = anime!.top;
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
                              Genre(malId: -1, type: '', name: '', url: '')
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
      ),
    );
  }
}
