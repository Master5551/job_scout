import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:job_scout/Authentication/home_page.dart';
import 'package:job_scout/Authentication/login_page.dart';
import 'package:job_scout/Authentication/register_page.dart';
import 'package:job_scout/Authentication/verified_page.dart';
import 'package:job_scout/Controller/get_profile.dart';
import 'package:job_scout/Controller/search.dart';
import 'package:job_scout/Home/jobs.dart';
import 'package:job_scout/Home/profile_page.dart';
import 'package:job_scout/firebase_options.dart';
// ignore: unused_import
import 'package:firebase_auth/firebase_auth.dart';

import 'Home/welcome_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MainApp());

  // Lock the app orientation to portrait mode
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SearchUsersPage(),
    );
  }
}
