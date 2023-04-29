import 'package:flutter/material.dart';
import 'package:sam_frontend/Constant/Colors.dart';
import 'package:sam_frontend/Widgets/Anime_Search.dart';
import 'package:sam_frontend/Widgets/Anime_This_Season.dart';
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
        ? DefaultTabController(
            length: 2,
            child: Scaffold(
              appBar: PreferredSize(
                preferredSize: Size.fromHeight(50),
                child: AppBar(
                  elevation: 0,
                  backgroundColor: kPrimaryColor,
                  bottom: TabBar(
                    indicatorColor: kSecondaryColor,
                    indicatorWeight: 3,
                    tabs: [
                      Tab(
                        text: 'This Season',
                      ),
                      Tab(
                        text: 'For You',
                      )
                    ],
                  ),
                ),
              ),
              body: ScrollConfiguration(
                behavior: ScrollBehavior(),
                child: GlowingOverscrollIndicator(
                  axisDirection: AxisDirection.right,
                  color: kSecondaryColor,
                  child: TabBarView(
                    children: [AnimeThisSeason(), AnimeForYou()],
                  ),
                ),
              ),
            ))
        : AnimeSearchedByName(search: widget.searchParam);
  }
}
