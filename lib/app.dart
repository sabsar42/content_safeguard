import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'app/screens/splash_screen.dart';

class ContentSafeguard extends StatelessWidget {
  const ContentSafeguard({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Content Safe Guard',
      debugShowCheckedModeBanner: false,
      color: Colors.black87,
      theme: ThemeData(
        useMaterial3: true,
      ),
      home: const SplashScreen(),
    );
  }
}
