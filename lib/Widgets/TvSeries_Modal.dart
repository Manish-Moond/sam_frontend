import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:sam_frontend/Constant/Colors.dart';

class TvSeriesModal extends StatefulWidget {
  final String name;
  final String imageUrl;
  final String id;
  const TvSeriesModal({
    Key? key,
    required this.name,
    required this.imageUrl,
    this.id = '',
  }) : super(key: key);

  @override
  _TvSeriesModalState createState() => _TvSeriesModalState();
}

class _TvSeriesModalState extends State<TvSeriesModal> {
  addData(String _status) async {
    widget.id == ''
        ? await FirebaseFirestore.instance
            .collection('users')
            .doc(FirebaseAuth.instance.currentUser!.uid)
            .set({'name': 'tvseries'}).then((value) {
            FirebaseFirestore.instance
                .collection('users')
                .doc(FirebaseAuth.instance.currentUser!.uid)
                .collection('tvseries')
                .add({
                  'name': widget.name,
                  'image': 'https://image.tmdb.org/t/p/w500/${widget.imageUrl}',
                  'status': _status
                })
                .then((value) => print('succesfully added to tv series'))
                .catchError(throw 'Error');
          })
        : await FirebaseFirestore.instance
            .collection('users')
            .doc(FirebaseAuth.instance.currentUser!.uid)
            .collection('tvseries')
            .doc(widget.id)
            .update({'status': _status});
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
                          addData('Watched');
                        },
                        style: ElevatedButton.styleFrom(primary: kPrimaryColor),
                        child: Text(
                          "Watched",
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
                          addData('Drop');
                        },
                        style: ElevatedButton.styleFrom(primary: kPrimaryColor),
                        child: Text(
                          "Drop",
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