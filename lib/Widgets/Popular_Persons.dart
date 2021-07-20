import 'package:flutter/material.dart';
import 'package:sam_frontend/Constant/Colors.dart';
import 'package:sam_frontend/Models/Popular_Person_Model.dart';
import 'package:sam_frontend/Screens/Person_Descripetion.dart';
import 'package:sam_frontend/Services/Person_Servies.dart';

class PopularPersons extends StatefulWidget {
  const PopularPersons({Key? key}) : super(key: key);

  @override
  _PopularPersonsState createState() => _PopularPersonsState();
}

class _PopularPersonsState extends State<PopularPersons> {
  HttpPersonServices _httpPersonServices = HttpPersonServices();

  List<Result> _person = [];
  ScrollController _scrollController = ScrollController();
  int _page = 1;
  bool _loading = true;

  void filler(value) {
    setState(() {
      for (int i = 0; i < value.results.length; i++) {
        _person.add(value.results[i]);
      }
      _loading = false;
    });
  }

  @override
  void initState() {
    super.initState();
    _loading = true;
    _httpPersonServices.getPopularPerson(_page).then((value) {
      filler(value);
    });
    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        _page += 1;
        _loading = true;
        _httpPersonServices.getPopularPerson(_page).then((value) {
          filler(value);
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          height: size.height * 0.02,
        ),
        Text(
          'Popular',
          style: TextStyle(
              fontSize: 18,
              color: kSecondaryColor,
              fontWeight: FontWeight.w400),
        ),
        SizedBox(
          height: size.height * 0.011,
        ),
        Container(
          height: size.height * 0.32,
          child: _loading
              ? Center(
                  child: CircularProgressIndicator(
                  color: kSecondaryColor,
                ))
              : ScrollConfiguration(
                  behavior: ScrollBehavior(),
                  child: GlowingOverscrollIndicator(
                    axisDirection: AxisDirection.right,
                    color: kSecondaryColor,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      controller: _scrollController,
                      itemCount: _person.length,
                      itemBuilder: (context, index) {
                        return Container(
                          child: Column(
                            children: [
                              GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (BuildContext context) =>
                                              PersonDescripetion(
                                                  personId: _person[index].id,
                                                  profilePath: _person[index]
                                                      .profilePath)));
                                },
                                child: Card(
                                  elevation: 2,
                                  clipBehavior: Clip.hardEdge,
                                  shape: RoundedRectangleBorder(
                                      borderRadius:
                                          BorderRadius.circular(15.0)),
                                  child: FadeInImage(
                                    height: 220,
                                    width: 150,
                                    placeholder: AssetImage(
                                        'assets/images/movieplaceholder.jpg'),
                                    image: NetworkImage(
                                      'https://image.tmdb.org/t/p/w500/${_person[index].profilePath}',
                                    ),
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                              Text(
                                _person[index].name,
                                style: TextStyle(
                                    color: kSecondaryColor,
                                    // fontWeight: FontWeight.bold,
                                    fontSize: 15),
                              )
                            ],
                          ),
                        );
                      },
                    ),
                  ),
                ),
        ),
      ],
    );
  }
}
