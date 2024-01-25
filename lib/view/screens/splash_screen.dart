import 'package:easy_do/view/screens/login_screen.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  static const id = '/';

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  _gotoNextScreen() {
    Future.delayed(const Duration(milliseconds: 1000)).then((value) {
      Navigator.pushReplacementNamed(context, LoginScreen.id);
    });
  }

  @override
  void initState() {
    _gotoNextScreen();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Container(
        height: size.height,
        width: size.width,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Colors.white,
              Color(0xffD2DDFD),
              Color(0xffF7E1E4),
              Colors.white,
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Center(
          child: Image.asset("assets/logo.png"),
        ),
      ),
    );
  }
}
