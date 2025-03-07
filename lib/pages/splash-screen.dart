import 'dart:async';

import 'package:flutter/material.dart';
import 'package:gmail/pages/home-page.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(
      const Duration(seconds: 3),
      () => Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const HomePage()),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      backgroundColor: colorScheme.primary,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Spacer(),
          Image.asset(
            'assets/icon.webp',
            width: MediaQuery.of(context).size.width * 0.3,
            fit: BoxFit.fitWidth,
          ),
          const Spacer(),
          Container(
            alignment: Alignment.bottomCenter,
            margin: const EdgeInsets.all(14),
            child: const Text(
              'Google',
              style: TextStyle(
                fontFamily: 'Catull',
                decoration: TextDecoration.none,
                color: Colors.grey,
                fontSize: 30,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
