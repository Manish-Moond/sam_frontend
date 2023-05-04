import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:sam_frontend/Constant/Colors.dart';

class AnimeModal extends StatefulWidget {
  final int? malId;
  final String name;
  final String? imageUrl;
  final bool doUpdateOrNot;
  const AnimeModal({
    Key? key,
    required this.name,
     this.imageUrl,
     this.malId = 0,
    this.doUpdateOrNot = false,
  }) : super(key: key);

  @override
  _AnimeModalState createState() => _AnimeModalState();
}

class _AnimeModalState extends State<AnimeModal> {
  addData(String _status) async {
    !widget.doUpdateOrNot
        ? await FirebaseFirestore.instance
            .collection('users')
            .doc(FirebaseAuth.instance.currentUser!.uid)
            .set({'name': 'anime'}).then((value) {
            FirebaseFirestore.instance
                .collection('users')
                .doc(FirebaseAuth.instance.currentUser!.uid)
                .collection('anime')
                .doc('${widget.malId}')
                .set({
                  'malId': widget.malId,
                  'name': widget.name,
                  'image': widget.imageUrl,
                  'status': _status
                })
                .then((value) => print('object'))
                .catchError(throw 'Error');
          })
        : await FirebaseFirestore.instance
            .collection('users')
            .doc(FirebaseAuth.instance.currentUser!.uid)
            .collection('anime')
            .doc('${widget.malId}')
            .update({'status': _status});
  }

  final ratingList = List<String>.generate(10, (index) => '${index + 1}');
  String dropDownValue = '-1';

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Container(
      color: kSecondaryColor,
      child: Padding(
        padding: const EdgeInsets.all(18.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text(
              '${widget.name}',
              style: TextStyle(fontSize: 20, color: kPrimaryColor),
            ),
            SizedBox(
              height: size.height * 0.08,
            ),
            Wrap(
              direction: Axis.horizontal,
              spacing: 10.0,
              children: [
                ElevatedButton(
                    onPressed: () {
                      addData('Watching');
                    },
                    style: ElevatedButton.styleFrom(backgroundColor: kPrimaryColor),
                    child: Text(
                      "Watching",
                      style: TextStyle(color: kSecondaryColor),
                    )),
                ElevatedButton(
                    onPressed: () {
                      addData('Watched');
                    },
                    style: ElevatedButton.styleFrom(backgroundColor: kPrimaryColor),
                    child: Text(
                      "Watched",
                      style: TextStyle(color: kSecondaryColor),
                    )),
                ElevatedButton(
                    onPressed: () {
                      addData('On Hold');
                    },
                    style: ElevatedButton.styleFrom(backgroundColor: kPrimaryColor),
                    child: Text(
                      "On Hold",
                      style: TextStyle(color: kSecondaryColor),
                    )),
                ElevatedButton(
                    onPressed: () {
                      addData('Drop');
                    },
                    style: ElevatedButton.styleFrom(backgroundColor: kPrimaryColor),
                    child: Text(
                      "Drop",
                      style: TextStyle(color: kSecondaryColor),
                    )),
                ElevatedButton(
                    onPressed: () {
                      addData('Plan To Watch');
                    },
                    style: ElevatedButton.styleFrom(backgroundColor: kPrimaryColor),
                    child: Text(
                      "Plan To Watch",
                      style: TextStyle(color: kSecondaryColor),
                    )),
              ],
            ),
            // Container(
            ScrollConfiguration(
              behavior: ScrollBehavior(),
              child: GlowingOverscrollIndicator(
                axisDirection: AxisDirection.down,
                color: kSecondaryColor,
                child: SingleChildScrollView(
                  child: Container(
                    child: TextField(
                      cursorColor: kPrimaryColor,
                      maxLines: 5,
                      decoration: InputDecoration(
                        enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: kPrimaryColor)),
                        focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: kPrimaryColor)),
                        border: OutlineInputBorder(),
                        labelText: 'Thoughts',
                        hintText:
                            'You want to write some thing? like what you enjoyed or what you have learn',
                        labelStyle: TextStyle(color: kPrimaryColor),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(backgroundColor: kPrimaryColor),
                    child: Text(
                      "Save",
                      style: TextStyle(color: kSecondaryColor),
                    )),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
