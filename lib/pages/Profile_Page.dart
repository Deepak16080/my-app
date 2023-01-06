import 'package:flutter/material.dart';
import 'package:myapp/pages/HomePage.dart';
import 'package:myapp/pages/auth/Login_page.dart';
import 'package:myapp/services/auth_Services.dart';
import 'package:myapp/widgets/widgets.dart';

class ProfilePage extends StatefulWidget {
  String Email;
  String userName;
   
   ProfilePage({Key?key,required this.Email,required this.userName}):super (key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
   AuthService authService = AuthService();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
    appBar: AppBar(
      backgroundColor: Theme.of(context).primaryColor,
      elevation: 0,
      title: const Text('Profile',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 27,color: Colors.white)),
    ),
    drawer: Drawer(
      child: ListView(
          padding: const EdgeInsets.symmetric(vertical: 50),
          children: <Widget>[
            Icon(Icons.account_circle, size: 150, color: Colors.grey[700]),
            SizedBox(
              height: 15,
            ),
            Text(
              widget.userName,
              textAlign: TextAlign.center,
              style: const TextStyle(
                  fontWeight: FontWeight.bold, color: Colors.black),
            ),
            const SizedBox(
              height: 30,
            ),
            const Divider(
              height: 2,
            ),
            ListTile(
              onTap: () {
                nextScreen(context, const HomePage());
              },
              selectedColor: Theme.of(context).primaryColor,
              selected: true,
              contentPadding:
                  const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
              leading: const Icon(Icons.groups),
              title: const Text(
                'Groups',
                style: TextStyle(color: Colors.black),
              ),
            ),
            ListTile(
              onTap: () {},
              selectedColor: Theme.of(context).primaryColor,
              selected: true,
              contentPadding:
                  const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
              leading: const Icon(Icons.groups),
              title: const Text(
                'Profile',
                style: TextStyle(color: Colors.black),
              ),
            ),
            ListTile(
              onTap: () async {
                showDialog(
                    context: context,
                    builder: (context) {
                      return AlertDialog(
                        title: const Text('Logout'),
                        content: const Text('Are you sure you want to Logout?'),
                        actions: [
                          IconButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              icon: Icon(
                                Icons.cancel,
                                color: Colors.red,
                              )),
                          IconButton(
                              onPressed: () async {
                                await authService.signOut();
                                Navigator.of(context).pushAndRemoveUntil(
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            const LoginPage()),
                                    (route) => false);
                              },
                              icon: Icon(Icons.done))
                        ],
                      );
                    });
                authService.signOut().whenComplete(() {
                  nextScreenReplace(context, const LoginPage());
                });
              },
              selectedColor: Theme.of(context).primaryColor,
              selected: true,
              contentPadding:
                  const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
              leading: const Icon(Icons.exit_to_app),
              title: const Text(
                'LogOut',
                style: TextStyle(color: Colors.black),
              ),
            )
          ],
        ),
      ),
     body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 40,vertical: 170),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
             Icon(Icons.account_circle,
             size: 100,
             color: Colors.grey[700],),
             const SizedBox(height: 15,),
             Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text('Full Name',style: TextStyle(fontSize: 17),),
                Text(widget.userName,style: const TextStyle(fontSize: 17),)
              ], 
             ),
             const Divider(
              height: 20,
             ),
             Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text('Email',style: TextStyle(fontSize: 17),),
                Text(widget.Email,style: const TextStyle(fontSize: 17),)
              ], 
             ),
          ],
        ),
      ),
    );
  }
}