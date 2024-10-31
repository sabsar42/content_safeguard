import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'app/controllers/content_controller.dart';
import 'app/screens/splash_screen.dart';

class ContentSafeguard extends StatelessWidget {
  const ContentSafeguard({super.key});


  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Content Safe Guard',
      debugShowCheckedModeBanner: false,
      color: Colors.black87,
      theme: ThemeData(
        useMaterial3: true,
      ),
      home: const SplashScreen(),
      initialBinding: BindingsBuilder(() {
        Get.put(ContentController());
      }),
    );
  }
}
