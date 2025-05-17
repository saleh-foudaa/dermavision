import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../guide_pages/on_pages.dart';

class Splashscreen extends StatefulWidget {
  static const String routeName = '/splash';

  @override
  _SplashscreenState createState() => _SplashscreenState();
}

class _SplashscreenState extends State<Splashscreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(Duration(seconds: 3), () {
      if (mounted) {
        Navigator.pushNamed(context, OnPages.routeName);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    Future.delayed(Duration(seconds: 3), () {
      WidgetsBinding.instance.addPostFrameCallback((_) {});
    });

    return Scaffold(
        body: Image.asset(
      "assets/images/Splash Screen.png",
      fit: BoxFit.fill,
      width: double.infinity,
      height: double.infinity,
    ));
  }
}
