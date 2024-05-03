import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(
      const Duration(seconds: 2),
          () {
        Get.offAllNamed('home');
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
          body: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Center(
                child: Image.asset(
                  "assets/logo/logo.png",
                  height: 100,
                  width: 100,
                ),
              ),
              const Center(
                child:Text("Gemini",
                style: TextStyle(
                    fontSize: 25, fontWeight: FontWeight.bold,
                  ),)
              ),
            ],
          ),
        ));
  }
}
