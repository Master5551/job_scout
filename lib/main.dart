import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:job_scout/Controller/home_controller.dart';
import 'package:job_scout/users/view/search.dart';
import 'package:job_scout/users/Authentication/start_page.dart';
import 'package:job_scout/users/Authentication/register_page.dart';
import 'package:job_scout/users/Authentication/login_page.dart';
import 'package:job_scout/users/view/home_page.dart';
import 'package:job_scout/users/view/profile_page.dart'; // Import your LoginPage here

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  
  runApp(MyApp());
}
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      initialBinding: HomeControllerBinding(),
      title: 'Job Scout App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: '/', // Set the initial route here
      routes: {
        '/': (context) => StartPage(), // Define the LoginPage route
        '/login': (context) => LoginPage(), // Define the LoginPage route
        '/register': (context) => RegisterPage(),
        '/searchpage':(context) => SearchUsersPage(),
        '/homepage':(context) => HomePage(),
        '/profilepage':(context) => ProfilePage(),
         // Define the RegisterPage route
      },
    );
  }
}

class HomeControllerBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<HomeController>(() => HomeController());
  }
}