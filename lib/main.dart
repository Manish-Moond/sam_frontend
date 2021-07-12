import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';
import 'package:sam_frontend/Provider/Google_Signin_Provider.dart';
import 'New_Home_Page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<GoogleSignInProvider>(
      create: (context) => GoogleSignInProvider(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'SAM',
        theme: ThemeData(
          primaryColor: Colors.blue,
        ),
        initialRoute: '/',
        routes: {
          '/': (context) => NewHomePage(),
        },
      ),
    );
  }
}
