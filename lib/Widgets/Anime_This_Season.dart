import 'package:flutter/material.dart';
import 'package:sam_frontend/Constant/Colors.dart';
import 'package:sam_frontend/Models/Anime_Model.dart';
import 'package:sam_frontend/Services/Anime_Servies.dart';

import 'Anime_Card.dart';

class AnimeThisSeason extends StatefulWidget {
  const AnimeThisSeason({Key? key}) : super(key: key);

  @override
  _AnimeThisSeasonState createState() => _AnimeThisSeasonState();
}

class _AnimeThisSeasonState extends State<AnimeThisSeason> {
  AnimeHTTPServices _animeHTTPServices = AnimeHTTPServices();
  final ScrollController _scrollController = ScrollController();
  List<AnimeDataList> _anime = [];
  bool _isLodingMore = false;
  bool _hasMore = true;
  int _page = 1;
  bool _isAnotherSeasonCalling = false;
  DateTime now = DateTime.now();
  List<int> years = <int>[];
  static const List<String> seasons = <String>[
    "winter",
    "spring",
    "summer",
    "fall"
  ];
  String dropDownValueSeason = seasons[0];
  int dropdownValueYear = DateTime.now().year;

  void filler({value, thisSeasonOrNot = false}) {
    if (thisSeasonOrNot) {
      setState(() {
        _hasMore = true;
        _anime = value.data;
        _isLodingMore = false;
      });
    } else {
      setState(() {
        _hasMore = value.pagination.hasNextPage!;
        _anime.addAll(value.data);
        _isLodingMore = false;
      });
    }
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
      if (_isAnotherSeasonCalling) {
        await _animeHTTPServices
            .getAnimeBySeason(
                page: _page,
                year: dropdownValueYear,
                season: dropDownValueSeason)
            .then((value) => filler(value: value));
      } else {
        await _animeHTTPServices
            .getAnimeBySeason(page: _page)
            .then((value) => filler(value: value));
      }
    }
  }

  @override
  void initState() {
    super.initState();
    _animeHTTPServices
        .getAnimeBySeason(page: _page)
        .then((value) => filler(value: value));
    _scrollController.addListener(_scrolleListener);

    for (int i = now.year; i >= 1920; i--) {
      years.add(i);
    }
  }

  Future<void> getAnimeBySeason() async {
    setState(() {
      _anime = [];
    });
    await _animeHTTPServices
        .getAnimeBySeason(
            page: _page, year: dropdownValueYear, season: dropDownValueSeason)
        .then((value) => filler(value: value, thisSeasonOrNot: true));
  }

// make genre list from List<Map>
  List<String?> _convertGenreToList(List<Demographic> genres) {
    List<String?> _gList = [];
    for (int i = 0; i < genres.length; i++) {
      _gList.add(genres[i].name);
    }
    return _gList;
  }

  @override
  Widget build(BuildContext context) {
    print(dropDownValueSeason);
    var size = MediaQuery.of(context).size;
    final double itemHeight = (size.height - size.height * 0.14) / 2;
    final double itemWidth = size.width / 2;

    return Container(
      color: kPrimaryColor,
      height: 200,
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(5, 10, 5, 10),
            child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Container(
                    child: DropdownButton(
                      value: dropDownValueSeason,
                      dropdownColor: kPrimaryColor,
                      items:
                          seasons.map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem(
                          child: Text(
                            value,
                            style: TextStyle(color: Colors.white),
                          ),
                          value: value,
                        );
                      }).toList(),
                      onChanged: (String? value) {
                        setState(() {
                          dropDownValueSeason = value!;
                        });
                      },
                    ),
                  ),
                  Container(
                    child: DropdownButton(
                      menuMaxHeight: 200,
                      value: dropdownValueYear,
                      dropdownColor: kPrimaryColor,
                      items: years.map<DropdownMenuItem<int>>((int year) {
                        return DropdownMenuItem(
                          child: Text(
                            "$year",
                            style: TextStyle(color: Colors.white),
                          ),
                          value: year,
                        );
                      }).toList(),
                      onChanged: (int? value) {
                        setState(() {
                          dropdownValueYear = value!;
                        });
                      },
                    ),
                  ),
                  Container(
                    width: 60,
                    child: ElevatedButton(
                        style: ButtonStyle(
                            foregroundColor:
                                MaterialStateProperty.all(kPrimaryColor),
                            backgroundColor:
                                MaterialStateProperty.all(kSecondaryColor)),
                        onPressed: () {
                          _page = 1;
                          _isAnotherSeasonCalling = true;
                          getAnimeBySeason();
                        },
                        child: Text(
                          "Go",
                        )),
                  )
                ]),
          ),
          _anime.isEmpty
              ? Expanded(
                  child: Container(
                    color: kPrimaryColor,
                    child: Center(
                      child: CircularProgressIndicator(
                        color: kSecondaryColor,
                      ),
                    ),
                  ),
                )
              : Expanded(
                  child: GlowingOverscrollIndicator(
                    axisDirection: AxisDirection.down,
                    color: kSecondaryColor,
                    child: GridView.builder(
                      controller: _scrollController,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          crossAxisSpacing: 5,
                          mainAxisSpacing: 5,
                          childAspectRatio: (itemWidth / itemHeight)),
                      itemCount:
                          _isLodingMore ? _anime.length + 1 : _anime.length,
                      itemBuilder: (context, index) {
                        if (index < _anime.length) {
                          return AnimeCard(
                            malId: _anime[index].malId,
                            title: _anime[index].title!,
                            imageUrl: _anime[index].images!['jpg']!.imageUrl,
                            score: _anime[index].score!,
                            episodes: _anime[index].episodes!,
                            type: _anime[index].type!,
                            rank: _anime[index].rank!,
                            popularity: _anime[index].popularity!,
                            genres: _convertGenreToList(_anime[index].genres!),
                            aired: [_anime[index].aired?.string],
                            // status:  _anime.status!,
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
        ],
      ),
    );
  }
}
