import 'package:expandable_text/expandable_text.dart';
import 'package:flutter/material.dart';
import 'package:sam_frontend/Constant/Colors.dart';
import 'package:sam_frontend/Models/Person_Work_Model.dart';
import 'package:sam_frontend/Services/Person_Servies.dart';
import 'package:sam_frontend/Widgets/MTV_Card.dart';

class PersonDescripetion extends StatefulWidget {
  final int personId;
  final String profilePath;
  const PersonDescripetion(
      {Key? key, required this.personId, required this.profilePath})
      : super(key: key);

  @override
  _PersonDescripetionState createState() => _PersonDescripetionState();
}

class _PersonDescripetionState extends State<PersonDescripetion> {
  HttpPersonServices _httpPersonServices = HttpPersonServices();
  List<String> _personInfo = [];
  bool _infoFetchingDone = false;

  void filler(value) {
    _personInfo.add(value.biography);
    _personInfo.add(value.name);
    _personInfo.add(value.knownForDepartment);
    setState(() {
      _infoFetchingDone = true;
    });
  }

  @override
  void initState() {
    super.initState();
    _httpPersonServices
        .getPersonInfo(widget.personId)
        .then((value) => filler(value));
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      body: Container(
        color: kPrimaryColor,
        child: ScrollConfiguration(
          behavior: ScrollBehavior(),
          child: GlowingOverscrollIndicator(
            axisDirection: AxisDirection.down,
            color: kSecondaryColor,
            child: ListView(
              children: [
                FadeInImage(
                  // height: size.height * 0.6,
                  // width: 150,
                  placeholder: AssetImage('assets/images/movieplaceholder.jpg'),
                  image: NetworkImage(
                    'https://image.tmdb.org/t/p/w500/${widget.profilePath}',
                  ),
                ),
                _infoFetchingDone
                    ? Padding(
                        padding: const EdgeInsets.all(18.0),
                        child: ExpandableText(
                          _personInfo[0],
                          expandText: 'show more',
                          collapseText: 'show less',
                          linkColor: kThiredColor,
                          maxLines: 6,
                          animation: true,
                          collapseOnTextTap: true,
                          style: TextStyle(
                              color: kFourthColor,
                              fontSize: 12,
                              fontWeight: FontWeight.normal),
                        ),
                      )
                    : Center(
                        child: CircularProgressIndicator(
                          color: kSecondaryColor,
                        ),
                      ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    'Know For',
                    style: TextStyle(
                        color: kSecondaryColor,
                        fontSize: 20,
                        fontWeight: FontWeight.bold),
                  ),
                ),
                FutureBuilder(
                  future: _httpPersonServices.getPersonWork(widget.personId),
                  builder: (BuildContext context,
                      AsyncSnapshot<PersonWorkModel> snapshot) {
                    if (snapshot.hasData) {
                      return Container(
                        height: size.height * 0.8,
                        child: Container(
                          padding: EdgeInsets.all(4),
                          child: ScrollConfiguration(
                            behavior: ScrollBehavior(),
                            child: GlowingOverscrollIndicator(
                              axisDirection: AxisDirection.down,
                              color: kSecondaryColor,
                              child: GridView.builder(
                                gridDelegate:
                                    SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 2,
                                  crossAxisSpacing: 8,
                                  childAspectRatio:
                                      MediaQuery.of(context).size.width /
                                          (MediaQuery.of(context).size.height /
                                              1.4),
                                ),
                                itemCount: snapshot.data!.work!.length,
                                itemBuilder: (context, index) {
                                  PersonWorkModel? _personWork = snapshot.data;
                                  print(_personWork!.work![index].releaseDate!);
                                  return MTVCard(
                                    movieOrNot: true,
                                    searcedOrNot: true,
                                    genres: _personWork.work![index].genreIds!,
                                    id: _personWork.id!,
                                    originalTitle:
                                        _personWork.work![index].originalTitle!,
                                    originalLanguage: _personWork
                                        .work![index].originalLanguage!,
                                    overview:
                                        _personWork.work![index].overview!,
                                    posterPath:
                                        _personWork.work![index].posterPath!,
                                    backdropPath:
                                        _personWork.work![index].backdropPath!,
                                    releaseDate:
                                        _personWork.work![index].releaseDate!,
                                    title: _personWork.work![index].title!,
                                    voteAverage:
                                        _personWork.work![index].voteAverage!,
                                  );
                                },
                              ),
                            ),
                          ),
                        ),
                      );
                    } else if (snapshot.hasError) {
                      return Center(child: Text("${snapshot.error}"));
                    } else {
                      return Center(
                        child: CircularProgressIndicator(
                          color: kSecondaryColor,
                        ),
                      );
                    }
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
