import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:news_app/screen/home_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  @override
  void initState() {
    super.initState();

    Timer(Duration(seconds: 10), () {
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => HomePage()));
    });
    
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset('images/splash.png',
            // width: MediaQuery.of(context).size.width/1,
            // height: MediaQuery.of(context).size.height/1.5 ,
            fit: BoxFit.cover,
            ),
            SizedBox(height: 70),

            Text('Top Headlines', style: GoogleFonts.aDLaMDisplay( letterSpacing: 3, color: Colors.grey.shade800, fontSize: 20) ),
            SizedBox(height: 70),

            SpinKitFadingCube(
              color: Colors.blueAccent,
              size: 50,
            )

          ],
        ),
      ),
    );
  }
}