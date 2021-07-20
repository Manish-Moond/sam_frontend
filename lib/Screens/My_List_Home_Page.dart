import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:sam_frontend/Constant/Colors.dart';
import 'package:sam_frontend/Widgets/Anime_Modal.dart';
import 'package:sam_frontend/Widgets/Movie_Modal.dart';
import 'package:sam_frontend/Widgets/TvSeries_Modal.dart';

class MyListHomePage extends StatelessWidget {
  const MyListHomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: ScrollConfiguration(
        behavior: ScrollBehavior(),
        child: GlowingOverscrollIndicator(
          axisDirection: AxisDirection.right,
          color: kSecondaryColor,
          child: TabBarView(
            children: [UserMovieTabs(), UserAnimeTabs(), UserTvSeriesTabs()],
          ),
        ),
      ),
    );
  }
}

class UserMovie extends StatelessWidget {
  final String status;

  const UserMovie({Key? key, required this.status}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: kPrimaryColor,
      child: StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection('users')
            .doc(FirebaseAuth.instance.currentUser!.uid)
            .collection('movies')
            .where('status', isEqualTo: status)
            .snapshots(),
        builder: (BuildContext context,
            AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot) {
          if (snapshot.hasError) {
            return Text('Error: ' + '${snapshot.error}');
          }
          switch (snapshot.connectionState) {
            case ConnectionState.waiting:
              return Center(
                child: CircularProgressIndicator(
                  color: kSecondaryColor,
                ),
              );
            default:
              return ScrollConfiguration(
                behavior: ScrollBehavior(),
                child: GlowingOverscrollIndicator(
                  axisDirection: AxisDirection.down,
                  color: kSecondaryColor,
                  child: GridView.count(
                    crossAxisCount: 3,
                    crossAxisSpacing: 4,
                    mainAxisSpacing: 3,
                    childAspectRatio: MediaQuery.of(context).size.width /
                        (MediaQuery.of(context).size.height / 1.25),
                    children: snapshot.data!.docs.map(
                      (snap) {
                        return UserSAMCard(
                          malOrMTVId: snap['mtvId'],
                          who: 'movie',
                          name: snap['name'],
                          imageUrl: snap['image'],
                        );
                      },
                    ).toList(),
                  ),
                ),
              );
          }
        },
      ),
    );
  }
}

class UserAnime extends StatelessWidget {
  final String status;
  UserAnime({
    Key? key,
    required this.status,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: kPrimaryColor,
      child: StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection('users')
            .doc(FirebaseAuth.instance.currentUser!.uid)
            .collection('anime')
            .where('status', isEqualTo: status)
            .snapshots(),
        builder: (BuildContext context,
            AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot) {
          if (snapshot.hasError) {
            return Text('Error: ' + '${snapshot.error}');
          }
          switch (snapshot.connectionState) {
            case ConnectionState.waiting:
              return Center(
                child: CircularProgressIndicator(
                  color: kSecondaryColor,
                ),
              );
            default:
              return ScrollConfiguration(
                behavior: ScrollBehavior(),
                child: GlowingOverscrollIndicator(
                  axisDirection: AxisDirection.down,
                  color: kSecondaryColor,
                  child: GridView.count(
                    crossAxisCount: 3,
                    crossAxisSpacing: 4,
                    mainAxisSpacing: 3,
                    childAspectRatio: MediaQuery.of(context).size.width /
                        (MediaQuery.of(context).size.height / 1.25),
                    children: snapshot.data!.docs.map(
                      (snap) {
                        return UserSAMCard(
                          malOrMTVId: snap['malId'],
                          who: 'anime',
                          name: snap['name'],
                          imageUrl: snap['image'],
                        );
                      },
                    ).toList(),
                  ),
                ),
              );
          }
        },
      ),
    );
  }
}

class UserTvSeries extends StatelessWidget {
  final String status;
  const UserTvSeries({Key? key, required this.status}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: kPrimaryColor,
      child: StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection('users')
            .doc(FirebaseAuth.instance.currentUser!.uid)
            .collection('tvseries')
            .where('status', isEqualTo: status)
            .snapshots(),
        builder: (BuildContext context,
            AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot) {
          if (snapshot.hasError) {
            return Text('Error: ' + '${snapshot.error}');
          }
          switch (snapshot.connectionState) {
            case ConnectionState.waiting:
              return Center(
                child: CircularProgressIndicator(
                  color: kSecondaryColor,
                ),
              );
            default:
              return ScrollConfiguration(
                behavior: ScrollBehavior(),
                child: GlowingOverscrollIndicator(
                  axisDirection: AxisDirection.down,
                  color: kSecondaryColor,
                  child: GridView.count(
                    crossAxisCount: 3,
                    crossAxisSpacing: 4,
                    mainAxisSpacing: 3,
                    childAspectRatio: MediaQuery.of(context).size.width /
                        (MediaQuery.of(context).size.height / 1.25),
                    children: snapshot.data!.docs.map(
                      (snap) {
                        return UserSAMCard(
                          malOrMTVId: snap['mtvId'],
                          who: 'tvseries',
                          name: snap['name'],
                          imageUrl: snap['image'],
                        );
                      },
                    ).toList(),
                  ),
                ),
              );
          }
        },
      ),
    );
  }
}

class UserAnimeTabs extends StatefulWidget {
  @override
  _UserAnimeTabsState createState() => _UserAnimeTabsState();
}

class _UserAnimeTabsState extends State<UserAnimeTabs> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: DefaultTabController(
        length: 5,
        child: Scaffold(
            appBar: PreferredSize(
              preferredSize: Size.fromHeight(50),
              child: AppBar(
                backgroundColor: kPrimaryColor,
                bottom: TabBar(
                  indicatorColor: kSecondaryColor,
                  isScrollable: true,
                  tabs: [
                    Tab(
                      text: 'Wacthing',
                    ),
                    Tab(
                      text: 'Plan to watch',
                    ),
                    Tab(
                      text: 'Watched',
                    ),
                    Tab(
                      text: 'On Hold',
                    ),
                    Tab(
                      text: 'Drop',
                    ),
                  ],
                ),
              ),
            ),
            body: ScrollConfiguration(
              behavior: ScrollBehavior(),
              child: GlowingOverscrollIndicator(
                axisDirection: AxisDirection.right,
                color: kSecondaryColor,
                child: TabBarView(children: [
                  UserAnime(
                    status: 'Watching',
                  ),
                  UserAnime(
                    status: 'Plan To Watch',
                  ),
                  UserAnime(
                    status: 'Watched',
                  ),
                  UserAnime(
                    status: 'On Hold',
                  ),
                  UserAnime(
                    status: 'Drop',
                  )
                ]),
              ),
            )),
      ),
    );
  }
}

class UserMovieTabs extends StatefulWidget {
  const UserMovieTabs({Key? key}) : super(key: key);

  @override
  _UserMovieTabsState createState() => _UserMovieTabsState();
}

class _UserMovieTabsState extends State<UserMovieTabs> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(50),
          child: AppBar(
            backgroundColor: kPrimaryColor,
            bottom: TabBar(
              indicatorColor: kSecondaryColor,
              tabs: [
                Tab(
                  text: 'Watched',
                ),
                Tab(
                  text: 'Plan To Watched',
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
              children: [
                UserMovie(
                  status: 'Watched',
                ),
                UserMovie(
                  status: 'Plan To Watch',
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class UserTvSeriesTabs extends StatefulWidget {
  const UserTvSeriesTabs({Key? key}) : super(key: key);

  @override
  _UserTvSeriesTabsState createState() => _UserTvSeriesTabsState();
}

class _UserTvSeriesTabsState extends State<UserTvSeriesTabs> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: DefaultTabController(
        length: 5,
        child: Scaffold(
          appBar: PreferredSize(
            preferredSize: Size.fromHeight(50),
            child: AppBar(
              backgroundColor: kPrimaryColor,
              bottom: TabBar(
                indicatorColor: kSecondaryColor,
                isScrollable: true,
                tabs: [
                  Tab(
                    text: 'Wacthing',
                  ),
                  Tab(
                    text: 'Plan to watch',
                  ),
                  Tab(
                    text: 'Watched',
                  ),
                  Tab(
                    text: 'On Hold',
                  ),
                  Tab(
                    text: 'Drop',
                  ),
                ],
              ),
            ),
          ),
          body: ScrollConfiguration(
            behavior: ScrollBehavior(),
            child: GlowingOverscrollIndicator(
              axisDirection: AxisDirection.right,
              color: kSecondaryColor,
              child: TabBarView(children: [
                UserTvSeries(
                  status: 'Watching',
                ),
                UserTvSeries(
                  status: 'Plan To Watch',
                ),
                UserTvSeries(
                  status: 'Watched',
                ),
                UserTvSeries(
                  status: 'On Hold',
                ),
                UserTvSeries(
                  status: 'Drop',
                )
              ]),
            ),
          ),
        ),
      ),
    );
  }
}

class UserSAMCard extends StatelessWidget {
  final int malOrMTVId;
  final String name;
  final String imageUrl;
  final String who;
  const UserSAMCard({
    Key? key,
    required this.name,
    required this.imageUrl,
    required this.who,
    required this.malOrMTVId,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onDoubleTap: () {
        showModalBottomSheet<void>(
          context: context,
          builder: (BuildContext context) {
            if (who == 'movie') {
              return MovieModal(
                mtvId: malOrMTVId,
                name: name,
                imageUrl: imageUrl,
                doUpdateOrNot: true,
              );
            } else if (who == 'anime') {
              return AnimeModal(
                malId: malOrMTVId,
                name: name,
                imageUrl: imageUrl,
                doUpdateOrNot: true,
              );
            } else {
              return TvSeriesModal(
                name: name,
                imageUrl: imageUrl,
                mtvId: malOrMTVId,
                doUpdateOrNot: true,
              );
            }
          },
        );
      },
      child: Card(
        color: kSecondaryColor,
        elevation: 5,
        child: Column(
          children: [
            Container(
              height: MediaQuery.of(context).size.height * 0.205,
              width: Size.infinite.width,
              child: Image.network(
                imageUrl,
                fit: BoxFit.cover,
              ),
            ),
            Text(
              name,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(color: kPrimaryColor, fontSize: 12),
            )
          ],
        ),
      ),
    );
  }
}
