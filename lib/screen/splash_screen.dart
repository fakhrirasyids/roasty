import 'dart:async';

import 'package:flutter/material.dart';
import 'package:roasty2/screen/home_page.dart';
import 'package:roasty2/screen/home_screen.dart';

class SplashScreen extends StatefulWidget {
  static const routeName = '/splash_screen';

  const SplashScreen({super.key});

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    startTime();
  }

  startTime() {
    var duration = const Duration(seconds: 2);
    return Timer(duration, navigationRoute);
  }

  void navigationRoute() {
    Navigator.pushReplacement(
        context,
        MaterialPageRoute(
            builder: (BuildContext context) => const HomePage()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SizedBox(
          width: 200,
          height: 200,
          child: Center(
            child: Image.asset('assets/images/roasty.png'),
          ),
        ),
      ),
    );
  }
}
