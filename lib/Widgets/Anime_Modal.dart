import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:sam_frontend/Constant/Colors.dart';

class AnimeModal extends StatefulWidget {
  final String name;
  final String imageUrl;
  const AnimeModal({Key? key, required this.name, required this.imageUrl})
      : super(key: key);

  @override
  _AnimeModalState createState() => _AnimeModalState();
}

class _AnimeModalState extends State<AnimeModal> {
  addData(String _status) async {
    await FirebaseFirestore.instance
        .collection('users')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .set({'Status': 'Watched'}).then((value) {
      FirebaseFirestore.instance
          .collection('users')
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .collection('anime')
          .add({
            'name': widget.name,
            'image': widget.imageUrl,
            'status': _status
          })
          .then((value) => print('object'))
          .catchError(throw 'Error');
    });
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Container(
      height: 420,
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
            Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ElevatedButton(
                        onPressed: () {
                          addData('Watching');
                        },
                        style: ElevatedButton.styleFrom(primary: kPrimaryColor),
                        child: Text(
                          "Watching",
                          style: TextStyle(color: kSecondaryColor),
                        )),
                    ElevatedButton(
                        onPressed: () {
                          addData('Completed');
                        },
                        style: ElevatedButton.styleFrom(primary: kPrimaryColor),
                        child: Text(
                          "Completed",
                          style: TextStyle(color: kSecondaryColor),
                        )),
                    ElevatedButton(
                        onPressed: () {
                          addData('On Hold');
                        },
                        style: ElevatedButton.styleFrom(primary: kPrimaryColor),
                        child: Text(
                          "On Hold",
                          style: TextStyle(color: kSecondaryColor),
                        )),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ElevatedButton(
                        onPressed: () {
                          addData('Plan To Watch');
                        },
                        style: ElevatedButton.styleFrom(primary: kPrimaryColor),
                        child: Text(
                          "Plan To Watch",
                          style: TextStyle(color: kSecondaryColor),
                        )),
                    ElevatedButton(
                        onPressed: () {
                          addData('Dropped');
                        },
                        style: ElevatedButton.styleFrom(primary: kPrimaryColor),
                        child: Text(
                          "Dropped",
                          style: TextStyle(color: kSecondaryColor),
                        )),
                  ],
                ),
                SizedBox(
                  height: size.height * 0.10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    ElevatedButton(
                        onPressed: () {},
                        style: ElevatedButton.styleFrom(primary: kPrimaryColor),
                        child: Text(
                          "Save",
                          style: TextStyle(color: kSecondaryColor),
                        )),
                  ],
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
