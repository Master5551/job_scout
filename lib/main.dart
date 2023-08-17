import 'package:flutter/material.dart';
import 'package:job_scout/Authentication/login_page.dart';

import 'Authentication/home_page.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: HomePage(),
    );
  }
}
