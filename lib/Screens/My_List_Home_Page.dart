import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:sam_frontend/Constant/Colors.dart';

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
  const UserMovie({Key? key, required this.movie}) : super(key: key);

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
          );
        },
      ),
    );
  }
}

class UserAnime extends StatelessWidget {
  final List anime;
  const UserAnime({Key? key, required this.anime}) : super(key: key);

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
        itemCount: anime.length,
        itemBuilder: (BuildContext context, index) {
          print(anime[index]['name']);
          return UserSAMCard(
            name: anime[index]['name'],
            imageUrl: anime[index]['imageUrl'],
          );
        },
      ),
    );
  }
}

class UserTvSeries extends StatelessWidget {
  final List tvSeries;
  const UserTvSeries({Key? key, required this.tvSeries}) : super(key: key);

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
      print('object');
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
        .collection('anime')
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
                : UserAnime(
                    anime: _watching,
                  ),
            _loading
                ? Center(
                    child: CircularProgressIndicator(
                      color: kSecondaryColor,
                    ),
                  )
                : UserAnime(
                    anime: _planTow,
                  ),
            _loading
                ? Center(
                    child: CircularProgressIndicator(
                      color: kSecondaryColor,
                    ),
                  )
                : UserAnime(
                    anime: _watched,
                  ),
            _loading
                ? Center(
                    child: CircularProgressIndicator(
                      color: kSecondaryColor,
                    ),
                  )
                : UserAnime(
                    anime: _onHold,
                  ),
            _loading
                ? Center(
                    child: CircularProgressIndicator(
                      color: kSecondaryColor,
                    ),
                  )
                : UserAnime(
                    anime: _drop,
                  )
          ]),
        ),
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
  bool _loading = true;

  filler(val) {
    val.docs.forEach((doc) {
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
                : UserMovie(movie: _watched),
            _loading
                ? Center(
                    child: CircularProgressIndicator(
                      color: kSecondaryColor,
                    ),
                  )
                : UserMovie(movie: _planTow)
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
                  ),
            _loading
                ? Center(
                    child: CircularProgressIndicator(
                      color: kSecondaryColor,
                    ),
                  )
                : UserTvSeries(
                    tvSeries: _planTow,
                  ),
            _loading
                ? Center(
                    child: CircularProgressIndicator(
                      color: kSecondaryColor,
                    ),
                  )
                : UserTvSeries(
                    tvSeries: _watched,
                  ),
            _loading
                ? Center(
                    child: CircularProgressIndicator(
                      color: kSecondaryColor,
                    ),
                  )
                : UserTvSeries(
                    tvSeries: _onHold,
                  ),
            _loading
                ? Center(
                    child: CircularProgressIndicator(
                      color: kSecondaryColor,
                    ),
                  )
                : UserTvSeries(
                    tvSeries: _drop,
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
  const UserSAMCard({Key? key, required this.name, required this.imageUrl})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
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
    );
  }
}
