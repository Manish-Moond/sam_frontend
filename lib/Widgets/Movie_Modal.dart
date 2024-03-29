import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:sam_frontend/Constant/Colors.dart';

class MovieModal extends StatefulWidget {
  final String name;
  final String imageUrl;
  final bool doUpdateOrNot;
  final int mtvId;
  const MovieModal(
      {Key? key,
      required this.name,
      required this.imageUrl,
      required this.mtvId,
      this.doUpdateOrNot = false})
      : super(key: key);

  @override
  _MovieModalState createState() => _MovieModalState();
}

class _MovieModalState extends State<MovieModal> {
  addData(String _status) async {
    !widget.doUpdateOrNot
        ? await FirebaseFirestore.instance
            .collection('users')
            .doc(FirebaseAuth.instance.currentUser!.uid)
            .set({'name': 'movies'}).then((value) {
            FirebaseFirestore.instance
                .collection('users')
                .doc(FirebaseAuth.instance.currentUser!.uid)
                .collection('movies')
                .doc('${widget.mtvId}')
                .set({
                  'mtvId': widget.mtvId,
                  'name': widget.name,
                  'image': 'https://image.tmdb.org/t/p/w500/${widget.imageUrl}',
                  'status': _status
                })
                .then((value) => print('succesfully added to Movies'))
                .catchError(throw 'Error');
          })
        : await FirebaseFirestore.instance
            .collection('users')
            .doc(FirebaseAuth.instance.currentUser!.uid)
            .collection('movies')
            .doc('${widget.mtvId}')
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
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  style: ElevatedButton.styleFrom(backgroundColor: kPrimaryColor),
                  onPressed: () {
                    addData('Watched');
                  },
                  child: Text(
                    'Watched',
                    style: TextStyle(color: kSecondaryColor),
                  ),
                ),
                ElevatedButton(
                    style: ElevatedButton.styleFrom(backgroundColor: kPrimaryColor),
                    onPressed: () {
                      addData('Plan To Watch');
                    },
                    child: Text(
                      'Plan To Watched',
                      style: TextStyle(color: kSecondaryColor),
                    ))
              ],
            )
          ],
        ),
      ),
    );
  }
}
