import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:myapp/Helper/Helper_Function.dart';
import 'package:myapp/pages/HomePage.dart';
import 'package:myapp/pages/auth/Login_page.dart';
import 'package:myapp/shared/constant.dart';

Future<void> main() async {
 WidgetsFlutterBinding.ensureInitialized();
  if (kIsWeb) {
    // run the initialztion for the web
    await Firebase.initializeApp(
        options: FirebaseOptions(
            apiKey: Constants.apiKey,
            appId: Constants.appid,
            messagingSenderId: Constants.messagingSenderId,
            projectId: Constants.projectId));
  }

  await Firebase.initializeApp();
  runApp(const myapp());
}

class myapp extends StatefulWidget {
  const myapp({super.key});

  @override
  State<myapp> createState() => _myappState();
}

class _myappState extends State<myapp> {
  bool _isSignedIn = false;
  @override
  void initState() {
    super.initState();
    getUserLoggedInStatus();
  }

  getUserLoggedInStatus() async {
    await HelperFunctions.getUserLoggedInStatus(true).then((value) {
      if (value != null) {
        setState(() {
           _isSignedIn = value;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(primaryColor: Constants().primaryColor),
      debugShowCheckedModeBanner: false,
     home: _isSignedIn ? const HomePage():  const LoginPage(), 
     );
  }
}
