import 'package:flutter/material.dart';
import 'package:sam_frontend/Constant/Colors.dart';
import 'package:sam_frontend/Models/anime_by_season_model.dart';
import 'package:sam_frontend/Services/Anime_Servies.dart';

import 'Anime_Card.dart';

class AnimeThisSeason extends StatefulWidget {
  const AnimeThisSeason({Key? key}) : super(key: key);

  @override
  _AnimeThisSeasonState createState() => _AnimeThisSeasonState();
}

class _AnimeThisSeasonState extends State<AnimeThisSeason> {
  final List<AnimeDataList> _data = [];
  final ScrollController _scrollController = ScrollController();
  int _page = 1;
  bool _loading = true;

  Future<AnimeBySeasonModel> getData({isRefreshed = false}) async {
    var res = await AnimeHTTPServices()
        .getAnimeBySeason(page: _page, isRefreshed: isRefreshed);
    _data.addAll(res.data!);
    setState(() {
      _loading = false;
    });
    return res;
  }

  @override
  void initState() {
    super.initState();
    _loading = true;
    getData();
    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        _page += 1;
        _loading = true;
        getData();
      }
    });
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
    var size = MediaQuery.of(context).size;
    final double itemHeight = (size.height - size.height * 0.14) / 2;
    final double itemWidth = size.width / 2;
    return _loading
        ? Container(
            color: kPrimaryColor,
            child: Center(
              child: CircularProgressIndicator(
                color: kSecondaryColor,
              ),
            ),
          )
        : Container(
            color: kPrimaryColor,
            height: 200,
            child: RefreshIndicator(
              color: kSecondaryColor,
              backgroundColor: kPrimaryColor,
              onRefresh: () {
                _page = 1;
                // _loading = true;
                return getData(isRefreshed: true);
              },
              child: ScrollConfiguration(
                behavior: ScrollBehavior(),
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
                    itemCount: _data.length,
                    itemBuilder: (context, index) {
                      return AnimeCard(
                        topOrNot: false,
                        malId: _data[index].malId,
                        title: _data[index].title!,
                        imageUrl: _data[index].images!['jpg']!.imageUrl,
                        score: _data[index].score!,
                        episodes: _data[index].episodes!,
                        type: _data[index].type!,
                        rank: _data[index].rank!,
                        popularity: _data[index].popularity!,
                        genres: _convertGenreToList(_data[index].genres!),
                        aired: [
                          _data[index].aired?.string
                        ],
                        // status:  _anime.status!,
                      );
                    },
                  ),
                ),
              ),
            ),
          );
  }
}
