import 'package:flutter/material.dart';
import 'package:sam_frontend/Constant/Colors.dart';
import 'package:sam_frontend/Models/anime_by_season_model.dart';
import 'package:sam_frontend/Services/Anime_Servies.dart';

import 'Anime_Card.dart';

class AnimeForYou extends StatefulWidget {
  const AnimeForYou({Key? key}) : super(key: key);

  @override
  _AnimeForYouState createState() => _AnimeForYouState();
}

class _AnimeForYouState extends State<AnimeForYou> {
  String selected = 'All';
  int selectedNum = 0;
  void selectFunction({String name = "All", int number = 0}) {
    if (mounted) {
      setState(() {
        selected = name;
        selectedNum = number;
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
                selectedName: selected,
                selectedId: selectedNum,
              ),
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
  final List<Map<String, dynamic>> _geners = [
    {
      "mal_id": 1,
      "name": "Action",
    },
    {
      "mal_id": 2,
      "name": "Adventure",
    },
    {
      "mal_id": 5,
      "name": "Avant Garde",
    },
    {
      "mal_id": 46,
      "name": "Award Winning",
    },
    {
      "mal_id": 28,
      "name": "Boys Love",
    },
    {
      "mal_id": 4,
      "name": "Comedy",
    },
    {
      "mal_id": 8,
      "name": "Drama",
    },
    {
      "mal_id": 10,
      "name": "Fantasy",
    },
    {
      "mal_id": 26,
      "name": "Girls Love",
    },
    {
      "mal_id": 47,
      "name": "Gourmet",
    },
    {
      "mal_id": 14,
      "name": "Horror",
    },
    {
      "mal_id": 7,
      "name": "Mystery",
    },
    {
      "mal_id": 22,
      "name": "Romance",
    },
    {
      "mal_id": 24,
      "name": "Sci-Fi",
    },
    {
      "mal_id": 36,
      "name": "Slice of Life",
    },
    {
      "mal_id": 30,
      "name": "Sports",
    },
    {
      "mal_id": 37,
      "name": "Supernatural",
    },
    {
      "mal_id": 41,
      "name": "Suspense",
    },
    {
      "mal_id": 9,
      "name": "Ecchi",
    },
    {
      "mal_id": 49,
      "name": "Erotica",
    },
    {
      "mal_id": 12,
      "name": "Hentai",
    },
    {
      "mal_id": 50,
      "name": "Adult Cast",
    },
    {
      "mal_id": 51,
      "name": "Anthropomorphic",
    },
    {
      "mal_id": 52,
      "name": "CGDCT",
    },
    {
      "mal_id": 53,
      "name": "Childcare",
    },
    {
      "mal_id": 54,
      "name": "Combat Sports",
    },
    {
      "mal_id": 81,
      "name": "Crossdressing",
    },
    {
      "mal_id": 55,
      "name": "Delinquents",
    },
    {
      "mal_id": 39,
      "name": "Detective",
    },
    {
      "mal_id": 56,
      "name": "Educational",
    },
    {
      "mal_id": 57,
      "name": "Gag Humor",
    },
    {
      "mal_id": 58,
      "name": "Gore",
    },
    {
      "mal_id": 35,
      "name": "Harem",
    },
    {
      "mal_id": 59,
      "name": "High Stakes Game",
    },
    {
      "mal_id": 13,
      "name": "Historical",
    },
    {
      "mal_id": 60,
      "name": "Idols (Female)",
    },
    {
      "mal_id": 61,
      "name": "Idols (Male)",
    },
    {
      "mal_id": 62,
      "name": "Isekai",
    },
    {
      "mal_id": 63,
      "name": "Iyashikei",
    },
    {
      "mal_id": 64,
      "name": "Love Polygon",
    },
    {
      "mal_id": 65,
      "name": "Magical Sex Shift",
    },
    {
      "mal_id": 66,
      "name": "Mahou Shoujo",
    },
    {
      "mal_id": 17,
      "name": "Martial Arts",
    },
    {
      "mal_id": 18,
      "name": "Mecha",
    },
    {
      "mal_id": 67,
      "name": "Medical",
    },
    {
      "mal_id": 38,
      "name": "Military",
    },
    {
      "mal_id": 19,
      "name": "Music",
    },
    {
      "mal_id": 6,
      "name": "Mythology",
    },
    {
      "mal_id": 68,
      "name": "Organized Crime",
    },
    {
      "mal_id": 69,
      "name": "Otaku Culture",
    },
    {
      "mal_id": 20,
      "name": "Parody",
    },
    {
      "mal_id": 70,
      "name": "Performing Arts",
    },
    {
      "mal_id": 71,
      "name": "Pets",
    },
    {
      "mal_id": 40,
      "name": "Psychological",
    },
    {
      "mal_id": 3,
      "name": "Racing",
    },
    {
      "mal_id": 72,
      "name": "Reincarnation",
    },
    {
      "mal_id": 73,
      "name": "Reverse Harem",
    },
    {
      "mal_id": 74,
      "name": "Romantic Subtext",
    },
    {
      "mal_id": 21,
      "name": "Samurai",
    },
    {
      "mal_id": 23,
      "name": "School",
    },
    {
      "mal_id": 75,
      "name": "Showbiz",
    },
    {
      "mal_id": 29,
      "name": "Space",
    },
    {
      "mal_id": 11,
      "name": "Strategy Game",
    },
    {
      "mal_id": 31,
      "name": "Super Power",
    },
    {
      "mal_id": 76,
      "name": "Survival",
    },
    {
      "mal_id": 77,
      "name": "Team Sports",
    },
    {
      "mal_id": 78,
      "name": "Time Travel",
    },
    {
      "mal_id": 32,
      "name": "Vampire",
    },
    {
      "mal_id": 79,
      "name": "Video Game",
    },
    {
      "mal_id": 80,
      "name": "Visual Arts",
    },
    {
      "mal_id": 48,
      "name": "Workplace",
    },
    {
      "mal_id": 43,
      "name": "Josei",
    },
    {
      "mal_id": 15,
      "name": "Kids",
    },
    {
      "mal_id": 42,
      "name": "Seinen",
    },
    {
      "mal_id": 25,
      "name": "Shoujo",
    },
    {
      "mal_id": 27,
      "name": "Shounen",
    }
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
                      selectedFunction(name: 'All');
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
                ..._geners.map((e) => Padding(
                      padding: const EdgeInsets.fromLTRB(0, 0, 12, 6),
                      child: GestureDetector(
                        onTap: () {
                          selectedFunction(
                              name: e["name"], number: e["mal_id"]);
                        },
                        child: Chip(
                          elevation: 0,
                          shadowColor: kPrimaryColor,
                          clipBehavior: Clip.antiAlias,
                          backgroundColor: selectedValue == e["name"]
                              ? kSecondaryColor
                              : kPrimaryColor,
                          label: Text(
                            e["name"],
                            style: TextStyle(
                                color: selectedValue == e["name"]
                                    ? kPrimaryColor
                                    : kSecondaryColor),
                          ),
                        ),
                      ),
                    ))
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class AnimeGenresResults extends StatefulWidget {
  final String selectedName;
  final int selectedId;

  const AnimeGenresResults(
      {Key? key, required this.selectedName, required this.selectedId})
      : super(key: key);
  @override
  _AnimeGenresResultsState createState() => _AnimeGenresResultsState();
}

class _AnimeGenresResultsState extends State<AnimeGenresResults> {
  final AnimeHTTPServices _animeHTTPServices = AnimeHTTPServices();
  ScrollController _scrollController = ScrollController();
  List<AnimeDataList> _anime = [];
  int _page = 1;
  bool _isLodingMore = true;
  bool _hasMore = true;

  void filler(value) {
    setState(() {
      _hasMore = value.pagination.hasNextPage!;
      _anime.addAll(value.data);
      _isLodingMore = false;
    });
  }

  Future<void> _scrolleListener() async {
    if (!_hasMore) return;
    if (_isLodingMore) return;
    if (_scrollController.position.pixels ==
        _scrollController.position.maxScrollExtent) {
      setState(() {
        _isLodingMore = true;
      });
      _page += 1;
      await _animeHTTPServices
          .getAnimeByGenres(genreNum: widget.selectedId, page: _page)
          .then((value) => filler(value));
    }
  }

  @override
  void initState() {
    super.initState();
    _animeHTTPServices
        .getAnimeByGenres(genreNum: widget.selectedId, page: 1)
        .then((value) => filler(value));
    _scrollController.addListener(_scrolleListener);
  }

  @override
  void didUpdateWidget(covariant AnimeGenresResults oldWidget) {
    if (this.widget.selectedName != oldWidget.selectedName) {
      _anime = [];
      _page = 1;
      _isLodingMore = true;
      _animeHTTPServices
          .getAnimeByGenres(genreNum: widget.selectedId, page: 1)
          .then((value) => filler(value));
    }

    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    final double itemHeight = (size.height - size.height * 0.14) / 2;
    final double itemWidth = size.width / 2;
    return Expanded(
      child: GlowingOverscrollIndicator(
        axisDirection: AxisDirection.down,
        color: kSecondaryColor,
        child: Container(
          color: kPrimaryColor,
          child: _anime.isEmpty
              ? Center(
                  child: CircularProgressIndicator(
                    color: kSecondaryColor,
                  ),
                )
              : GridView.builder(
                  controller: _scrollController,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 5,
                      mainAxisSpacing: 5,
                      childAspectRatio: (itemWidth / itemHeight)),
                  itemCount: _isLodingMore ? _anime.length + 1 : _anime.length,
                  itemBuilder: (context, index) {
                    if (index < _anime.length) {
                      return AnimeCard(
                        imageUrl: _anime[index].images!['jpg']!.imageUrl,
                        malId: _anime[index].malId,
                        title: _anime[index].title!,
                        rank: _anime[index].rank!,
                        score: _anime[index].score!,
                        episodes: _anime[index].episodes!,
                        genres: [],
                        aired: [_anime[index].aired!.string],
                        status: '',
                        popularity: _anime[index].popularity!,
                      );
                    } else {
                      return Center(
                        child:
                            CircularProgressIndicator(color: kSecondaryColor),
                      );
                    }
                  },
                ),
        ),
      ),
    );
  }
}

class AnimeTopRated extends StatefulWidget {
  @override
  _AnimeTopRatedState createState() => _AnimeTopRatedState();
}

class _AnimeTopRatedState extends State<AnimeTopRated> {
  final AnimeHTTPServices _animeHTTPServices = AnimeHTTPServices();
  ScrollController _scrollController = ScrollController();
  List<AnimeDataList> _animeList = [];
  bool _isLodingMore = false;
  bool _hasMore = true;
  int _page = 1;

  filler(value) {
    setState(() {
      _hasMore = value.pagination.hasNextPage!;
      _animeList.addAll(value.data);
      _isLodingMore = false;
    });
  }

  Future<void> _scrolleListener() async {
    if (!_hasMore) return;
    if (_isLodingMore) return;
    if (_scrollController.position.pixels ==
        _scrollController.position.maxScrollExtent) {
      setState(() {
        _isLodingMore = true;
      });
      _page += 1;
      await _animeHTTPServices
          .getAnimeTop(page: _page)
          .then((value) => filler(value));
    }
  }

  @override
  void initState() {
    super.initState();
    _animeHTTPServices.getAnimeTop(page: 1).then((value) => filler(value));
    _scrollController.addListener(_scrolleListener);
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    /*24 is for notification bar on Android*/
    final double itemHeight = (size.height - size.height * 0.14) / 2;
    final double itemWidth = size.width / 2;

    return Expanded(
      child: GlowingOverscrollIndicator(
        axisDirection: AxisDirection.down,
        color: kSecondaryColor,
        child: Container(
          color: kPrimaryColor,
          child: _animeList.isEmpty
              ? Center(
                  child: CircularProgressIndicator(color: kSecondaryColor),
                )
              : GridView.builder(
                  controller: _scrollController,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 5,
                      mainAxisSpacing: 5,
                      childAspectRatio: (itemWidth / itemHeight)),
                  itemCount:
                      _isLodingMore ? _animeList.length + 1 : _animeList.length,
                  itemBuilder: (context, index) {
                    if (index < _animeList.length) {
                      return AnimeCard(
                        imageUrl: _animeList[index].images!['jpg']!.imageUrl,
                        malId: _animeList[index].malId,
                        title: _animeList[index].title!,
                        rank: _animeList[index].rank!,
                        score: _animeList[index].score!,
                        episodes: _animeList[index].episodes!,
                        genres: [],
                        aired: [_animeList[index].aired!.string],
                        status: '',
                        popularity: _animeList[index].popularity!,
                      );
                    } else {
                      return Center(
                        child: CircularProgressIndicator(
                          color: kSecondaryColor,
                        ),
                      );
                    }
                  },
                ),
        ),
      ),
    );
  }
}
