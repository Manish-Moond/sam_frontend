import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:sam_frontend/Constant/Colors.dart';
import 'package:sam_frontend/Provider/Google_Signin_Provider.dart';

class SignInPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kPrimaryColor,
      body: SafeArea(
        child: Container(
            child: Center(
          child: Container(
            padding: EdgeInsets.all(40),
            child: ElevatedButton.icon(
              style: ElevatedButton.styleFrom(
                primary: kSecondaryColor,
                onPrimary: kPrimaryColor,
                minimumSize: Size(double.infinity, 50),
              ),
              icon: FaIcon(
                FontAwesomeIcons.google,
                color: Colors.red,
              ),
              label: Text("Sign Up With Google"),
              onPressed: () {
                final provider =
                    Provider.of<GoogleSignInProvider>(context, listen: false);
                provider.googleLogin();
              },
            ),
          ),
        )),
      ),
    );
  }
}
