import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Center(
            child: Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              child: Image.asset(
                'assets/images/startpage.png', 
                fit: BoxFit.cover, 
              ),
            ),
          ),
          Positioned(
            bottom: 20.0,
            right: 20.0,
            child: Row(
              children: [
                Text(
                  'Next',
                  style: TextStyle(
                    color:
                        Colors.green[800], 
                    fontSize: 18, 
                  ),
                ),
                SizedBox(
                    width: 10), 
                Icon(Icons.arrow_forward),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
