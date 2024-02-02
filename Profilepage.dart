import 'package:firebase_chat_app_with_opps/GoogleSignIn.dart';
import 'package:firebase_chat_app_with_opps/LoginScreen.dart';
import 'package:firebase_chat_app_with_opps/MixinforUI.dart';
import 'package:firebase_chat_app_with_opps/Provider.dart';
import 'package:firebase_chat_app_with_opps/Settings.dart';
import 'package:firebase_chat_app_with_opps/SignupScreen.dart';
import 'package:firebase_chat_app_with_opps/Splashscreen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Profilepage extends StatefulWidget {
  const Profilepage({super.key});

  @override
  State<Profilepage> createState() => ProfilepageState();
}

class ProfilepageState extends State<Profilepage> with ForUI {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: dark(),
      appBar: AppBar(
        automaticallyImplyLeading: false,
        leading: IconButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            icon: Icon(
              Icons.arrow_back,
              color: text(),
            )),
        backgroundColor: background(),
        title: Fun('Profile', 20, FontWeight.normal, a: text()),
        actions: [
          IconButton(
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => Setting(),
                ));
              },
              icon: Icon(
                Icons.settings,
                color: seconddark(),
              )),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.only(left: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 60,
            ),
            Fun("Email  you loged in with ", 22, FontWeight.bold, a: text()),
            SizedBox(
              height: 20,
            ),
            Consumer<NameProvider>(
              builder: (context, provider, child) {
                return Fun("Email: ${provider.email}", 22, FontWeight.bold,
                    a: text());
              },
            ),
            SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Fun("Log Out", 25, FontWeight.bold, a: text()),
                IconButton(
                    onPressed: () async {
                      if (auth.currentUser != null) {
                        await auth.signOut();
                      } else {
                        await GoogleHelper().logout();
                      }
                      final prefs = await SharedPreferences.getInstance();
                      prefs.setBool(SplashscreenState.KEYLOGIN, false);
                    },
                    icon: Icon(
                      Icons.login_outlined,
                      size: 30,
                      color: text(),
                    )),
              ],
            ),
            SizedBox(
              height: 20,
            ),
            Center(
              child: TextButton(
                  onPressed: () {
                    Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => SignupScreen(),
                    ));
                  },
                  child: Fun("Create New Account ", 25, FontWeight.bold,
                      a: text())),
            ),
            SizedBox(
              height: 20,
            ),
            Center(
              child: TextButton(
                  onPressed: () {
                    Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => LoginScreen(),
                    ));
                  },
                  child: Fun("Log in with other Account ", 25, FontWeight.bold,
                      a: text())),
            ),
          ],
        ),
      ),
    );
  }
}
