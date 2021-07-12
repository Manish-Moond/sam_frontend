// import 'package:flutter/material.dart';
// import 'package:sam_frontend/Home_Page.dart';
// import 'package:sam_frontend/Sign_Up_widget.dart';

// class NewHomePage extends StatelessWidget {
//   const NewHomePage({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) => Scaffold(
//         body: StreamBuilder(
//           builder: (context, snapshot) {
//             if (snapshot.connectionState == ConnectionState.waiting) {
//               return Center(
//                 child: CircularProgressIndicator(),
//               );
//             } else if (snapshot.hasData) {
//               return HomePage();
//             } else if (snapshot.hasError) {
//               return Text('Error');
//             } else {
//               return SignUpWidget();
//             }
//           },
//         ),
//       );
// }

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sam_frontend/Home_Page.dart';
import 'package:sam_frontend/Provider/Google_Signin_Provider.dart';
import 'package:sam_frontend/Screens/SignIn.dart';

class NewHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          final GoogleSignInProvider provider =
              Provider.of<GoogleSignInProvider>(context);
          if (provider.getIsSigningIn() == true) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.hasData) {
            print(snapshot.data);
            return HomePage();
          } else {
            return SignInPage();
          }
        },
      ),
    );
  }
}
