import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:quiz_app/model/sharedclass.dart';
import 'package:quiz_app/pages/home_page.dart';
import 'package:quiz_app/screens/admin/admin_page.dart';
import 'package:quiz_app/screens/info.dart';

import 'package:shared_preferences/shared_preferences.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    checkAdminloggedIn(context);
   SharedPref().sharedisntancefucniton();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
     
    log(SharedPref().sharedInstanceUSer);
    return Scaffold(
      body: Container(
        height: double.infinity,
        width: double.infinity,
        decoration:const BoxDecoration(
            gradient: LinearGradient(colors: [
              Color(0xffB81736),
              Color(0xff281537),
            ]),
            image: DecorationImage(
                image: AssetImage('assets/Union-removebg-preview.png'))),
      ),
    );
  }

  Future<void> gotoLogin(BuildContext context) async {
    await Future.delayed(const Duration(seconds: 3));

    // ignore: use_build_context_synchronously
    Navigator.of(context)
        .pushReplacement(MaterialPageRoute(builder: (ctx) => const InfoScreen()));
  }

  Future<void> checkAdminloggedIn(BuildContext context) async {
    // ignore: no_leading_underscores_for_local_identifiers
    final _sharedPrefs = await SharedPreferences.getInstance();
    final adminloggedin = _sharedPrefs.getString('login_status');
    FirebaseAuth user = FirebaseAuth.instance;
    if (user.currentUser != null && user.currentUser!.uid.isNotEmpty) {
      // ignore: use_build_context_synchronously
      Navigator.of(context)
          .push(MaterialPageRoute(builder: (ctx) => HomePage()));
      return;
    }

    if (adminloggedin == null) {
      // ignore: use_build_context_synchronously
      gotoLogin(context);
    } else if (adminloggedin == 'admin') {
      // ignore: use_build_context_synchronously
      Navigator.of(context)
          .pushReplacement(MaterialPageRoute(builder: (ctx) => const AdminPage()));
    }
  }
}
