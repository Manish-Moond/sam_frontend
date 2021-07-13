import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:sam_frontend/Constant/Colors.dart';

class AnimeModal extends StatefulWidget {
  final String name;
  const AnimeModal({Key? key, required this.name}) : super(key: key);

  @override
  _AnimeModalState createState() => _AnimeModalState();
}

class _AnimeModalState extends State<AnimeModal> {
  addData(user) async {
    Map<String, dynamic> demoData = {'name': "${widget.name}", "image": 21};

    CollectionReference collectionReference = FirebaseFirestore.instance
        .collection('data')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .collection('anime');
    collectionReference.add(demoData);
  }

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;
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
                          addData(user);
                        },
                        style: ElevatedButton.styleFrom(primary: kPrimaryColor),
                        child: Text(
                          "Watching",
                          style: TextStyle(color: kSecondaryColor),
                        )),
                    ElevatedButton(
                        onPressed: () {},
                        style: ElevatedButton.styleFrom(primary: kPrimaryColor),
                        child: Text(
                          "Completed",
                          style: TextStyle(color: kSecondaryColor),
                        )),
                    ElevatedButton(
                        onPressed: () {},
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
                        onPressed: () {},
                        style: ElevatedButton.styleFrom(primary: kPrimaryColor),
                        child: Text(
                          "Plan To Watch",
                          style: TextStyle(color: kSecondaryColor),
                        )),
                    ElevatedButton(
                        onPressed: () {},
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
