import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:sam_frontend/Constant/Colors.dart';
import 'package:sam_frontend/Widgets/Anime_Modal.dart';

class MyListHomePage extends StatelessWidget {
  const MyListHomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: TabBarView(
        children: [UserMovieTabs(), UserAnimeTabs(), UserTvSeriesTabs()],
      ),
    );
  }
}

class UserMovie extends StatelessWidget {
  final List movie;
  final List totalMovie;
  const UserMovie({Key? key, required this.movie, required this.totalMovie})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: kPrimaryColor,
      child: GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          crossAxisSpacing: 4,
          mainAxisSpacing: 3,
          childAspectRatio: MediaQuery.of(context).size.width /
              (MediaQuery.of(context).size.height / 1.25),
        ),
        itemCount: movie.length,
        itemBuilder: (BuildContext context, index) {
          print(movie[index]['name']);
          return UserSAMCard(
            name: movie[index]['name'],
            imageUrl: movie[index]['imageUrl'],
            id: movie[index]['id'],
          );
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
              return GridView.count(
                crossAxisCount: 3,
                crossAxisSpacing: 4,
                mainAxisSpacing: 3,
                childAspectRatio: MediaQuery.of(context).size.width /
                    (MediaQuery.of(context).size.height / 1.25),
                children: snapshot.data!.docs.map(
                  (snap) {
                    return UserSAMCard(
                      name: snap['name'],
                      imageUrl: snap['image'],
                      id: snap.id,
                    );
                  },
                ).toList(),
              );
          }
        },
      ),
    );
  }
}

class UserTvSeries extends StatelessWidget {
  final List tvSeries;
  final List totalTvSeries;
  const UserTvSeries(
      {Key? key, required this.tvSeries, required this.totalTvSeries})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: kPrimaryColor,
      child: GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          crossAxisSpacing: 4,
          mainAxisSpacing: 3,
          childAspectRatio: MediaQuery.of(context).size.width /
              (MediaQuery.of(context).size.height / 1.25),
        ),
        itemCount: tvSeries.length,
        itemBuilder: (BuildContext context, index) {
          print(tvSeries[index]['name']);
          return UserSAMCard(
            name: tvSeries[index]['name'],
            imageUrl: tvSeries[index]['imageUrl'],
            id: tvSeries[index]['id'],
          );
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
            body: TabBarView(children: [
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
            ])),
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
  List _planTow = [];
  List _watched = [];
  List _all = [];
  bool _loading = true;

  filler(val) {
    val.docs.forEach((doc) {
      _all.add({'name': doc['name'], 'imageUrl': doc['image']});
      if (doc['status'] == 'Plan To Watch') {
        _planTow.add({'name': doc['name'], 'imageUrl': doc['image']});
      } else if (doc['status'] == 'Watched') {
        _watched.add({'name': doc['name'], 'imageUrl': doc['image']});
      }
    });
    setState(() {
      _loading = false;
    });
  }

  @override
  void initState() {
    super.initState();
    print('object');
    FirebaseFirestore.instance
        .collection('users')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .collection('movie')
        .get()
        .then((QuerySnapshot querySnapshot) {
      filler(querySnapshot);
    });
  }

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
        body: TabBarView(
          children: [
            _loading
                ? Center(
                    child: CircularProgressIndicator(
                      color: kSecondaryColor,
                    ),
                  )
                : UserMovie(
                    movie: _watched,
                    totalMovie: _all,
                  ),
            _loading
                ? Center(
                    child: CircularProgressIndicator(
                      color: kSecondaryColor,
                    ),
                  )
                : UserMovie(
                    movie: _planTow,
                    totalMovie: _all,
                  )
          ],
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
  List _watching = [];
  List _planTow = [];
  List _watched = [];
  List _onHold = [];
  List _drop = [];
  bool _loading = true;

  filler(val) {
    val.docs.forEach((doc) {
      if (doc['status'] == 'Watching') {
        _watching.add({'name': doc['name'], 'imageUrl': doc['image']});
      } else if (doc['status'] == 'Plan To Watch') {
        _planTow.add({'name': doc['name'], 'imageUrl': doc['image']});
      } else if (doc['status'] == 'Watched') {
        _watched.add({'name': doc['name'], 'imageUrl': doc['image']});
      } else if (doc['status'] == 'On Hold') {
        _onHold.add({'name': doc['name'], 'imageUrl': doc['image']});
      } else if (doc['status'] == 'Drop') {
        _drop.add({'name': doc['name'], 'imageUrl': doc['image']});
      }
    });
    setState(() {
      _loading = false;
    });
  }

  @override
  void initState() {
    super.initState();
    print('object');
    FirebaseFirestore.instance
        .collection('users')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .collection('tvSeries')
        .get()
        .then((QuerySnapshot querySnapshot) {
      filler(querySnapshot);
    });
  }

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
          body: TabBarView(children: [
            _loading
                ? Center(
                    child: CircularProgressIndicator(
                      color: kSecondaryColor,
                    ),
                  )
                : UserTvSeries(
                    tvSeries: _watching,
                    totalTvSeries: [],
                  ),
            _loading
                ? Center(
                    child: CircularProgressIndicator(
                      color: kSecondaryColor,
                    ),
                  )
                : UserTvSeries(
                    tvSeries: _planTow,
                    totalTvSeries: [],
                  ),
            _loading
                ? Center(
                    child: CircularProgressIndicator(
                      color: kSecondaryColor,
                    ),
                  )
                : UserTvSeries(
                    tvSeries: _watched,
                    totalTvSeries: [],
                  ),
            _loading
                ? Center(
                    child: CircularProgressIndicator(
                      color: kSecondaryColor,
                    ),
                  )
                : UserTvSeries(
                    tvSeries: _onHold,
                    totalTvSeries: [],
                  ),
            _loading
                ? Center(
                    child: CircularProgressIndicator(
                      color: kSecondaryColor,
                    ),
                  )
                : UserTvSeries(
                    tvSeries: _drop,
                    totalTvSeries: [],
                  )
          ]),
        ),
      ),
    );
  }
}

class UserSAMCard extends StatelessWidget {
  final String name;
  final String imageUrl;
  final String status;
  final String id;
  const UserSAMCard({
    Key? key,
    required this.name,
    required this.imageUrl,
    this.status = '',
    required this.id,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onDoubleTap: () {
        showModalBottomSheet<void>(
          context: context,
          builder: (BuildContext context) {
            return AnimeModal(
              name: name,
              imageUrl: imageUrl,
              id: id,
            );
          },
        );
      },
      child: Card(
        color: kSecondaryColor,
        elevation: 5,
        child: Column(
          children: [
            Container(
              height: MediaQuery.of(context).size.height * 0.21,
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
