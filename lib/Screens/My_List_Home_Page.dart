import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttericon/font_awesome_icons.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:sam_frontend/Constant/Colors.dart';

class MyListHomePage extends StatelessWidget {
  const MyListHomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: TabBarView(
        children: [UserMovie(), UserAnime(), Icon(Icons.tv)],
      ),
    );
  }
}

class UserMovie extends StatefulWidget {
  const UserMovie({Key? key}) : super(key: key);

  @override
  _UserMovieState createState() => _UserMovieState();
}

class _UserMovieState extends State<UserMovie> {
  List _movie = [];
  bool _loading = true;
  // funt() {
  //   FirebaseFirestore.instance
  //       .collection('users')
  //       .doc(FirebaseAuth.instance.currentUser!.uid)
  //       .collection('anime')
  //       .get()
  //       .then((QuerySnapshot querySnapshot) {
  //     querySnapshot.docs.forEach((doc) {
  //       print(doc["name"]);
  //       _movie.add(doc['name']);
  //     });
  //   });
  //   return _movie;
  // }

  filler(val) {
    val.docs.forEach((doc) {
      _movie.add(doc['name']);
    });
    setState(() {
      _loading = false;
    });
  }

  @override
  void initState() {
    super.initState();
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
    return _loading
        ? Center(
            child: CircularProgressIndicator(),
          )
        : Container(
            child: ListView.builder(
              itemCount: _movie.length,
              itemBuilder: (BuildContext context, index) {
                return UserSAMCard(
                  name: _movie[index].name,
                  imageUrl: _movie[index].imageUrl,
                );
              },
            ),
          );
  }
}

class UserAnime extends StatefulWidget {
  const UserAnime({Key? key}) : super(key: key);

  @override
  _UserAnimeState createState() => _UserAnimeState();
}

class _UserAnimeState extends State<UserAnime> {
  List _anime = [];
  bool _loading = true;

  filler(val) {
    val.docs.forEach((doc) {
      print(doc['name']);
      _anime.add({'name': doc['name'], 'imageUrl': doc['image']});
    });
    print(_anime);
    setState(() {
      _loading = false;
    });
  }

  @override
  void initState() {
    super.initState();
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
    return _loading
        ? Center(
            child: CircularProgressIndicator(),
          )
        : Container(
            color: kPrimaryColor,
            child: GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                crossAxisSpacing: 4,
                mainAxisSpacing: 3,
                childAspectRatio: MediaQuery.of(context).size.width /
                    (MediaQuery.of(context).size.height / 1.25),
              ),
              itemCount: _anime.length,
              itemBuilder: (BuildContext context, index) {
                print(_anime[index]['name']);
                return UserSAMCard(
                  name: _anime[index]['name'],
                  imageUrl: _anime[index]['imageUrl'],
                );
              },
            ),
          );
  }
}

// class UserAnimeTabs extends StatefulWidget {
//   const UserAnimeTabs({Key? key}) : super(key: key);

//   @override
//   _UserAnimeTabsState createState() => _UserAnimeTabsState();
// }

// class _UserAnimeTabsState extends State<UserAnimeTabs>
//     with SingleTickerProviderStateMixin {
//   late TabController _tabController;

//   // @override
//   // void initState() {
//   //   super.initState();
//   //   _tabController = new TabController(vsync: this, length: 6);
//   //   // _tabController.addListener(_handleTabSelection);
//   // }

//   // void _handleTabSelection() {
//   //   setState(() {
//   //     widget.colorVal = 0xffff5722;
//   //   });
//   // }

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       child: DefaultTabController(
//         length: 5,
//         child: Scaffold(
//           appBar: AppBar(
//             bottom: TabBar(
//               controller: _tabController,
//               isScrollable: true,
//               tabs: [
//                 Tab(icon: Icon(FontAwesomeIcons.),),
              
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }

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
