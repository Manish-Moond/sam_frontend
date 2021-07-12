import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sam_frontend/Provider/Google_Signin_Provider.dart';

class About extends StatelessWidget {
  const About({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final GoogleSignInProvider provider =
        Provider.of<GoogleSignInProvider>(context);
    return Container(
      child: ElevatedButton(
        child: Text('Log Out'),
        onPressed: () {
          provider.logout();
        },
      ),
    );
  }
}
