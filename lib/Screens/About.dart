import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sam_frontend/Constant/Colors.dart';
import 'package:sam_frontend/Provider/Google_Signin_Provider.dart';

class About extends StatelessWidget {
  const About({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final GoogleSignInProvider provider =
        Provider.of<GoogleSignInProvider>(context);
    final user = FirebaseAuth.instance.currentUser;
    return Container(
      width: double.infinity,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 80,
            height: 80,
            child: CircleAvatar(
              backgroundImage: NetworkImage(user!.photoURL!),
            ),
            // child: Text(user!.displayName!),
          ),
          Container(
            child: Text(user.displayName!),
          ),
          Container(
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                  foregroundColor: kPrimaryColor,
                  backgroundColor: kSecondaryColor),
              child: Text('Log Out'),
              onPressed: () {
                provider.googleLogout();
              },
            ),
          ),
        ],
      ),
    );
  }
}
