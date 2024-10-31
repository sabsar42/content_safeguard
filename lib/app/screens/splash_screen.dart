import 'package:content_safeguard/app/widgets/button_widget.dart';
import 'package:flutter/material.dart';
import 'bottom_nav_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});
  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 1, 40, 40),
      body: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: screenSize.width * 0.06,
            vertical: screenSize.height * 0.04,
          ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(height: 25,),
            const Text(
              "CONTENT GUARDIAN",
              style: TextStyle(
                color: Colors.white,
                fontSize: 27,
                fontWeight: FontWeight.w200,
              ),
            ),
            SizedBox(height: screenSize.height * 0.02),
            Padding(
              padding: const EdgeInsets.fromLTRB(10,20,30,40),
              child: Image.asset('assets/images/digital-marketing.png'),
            ),
            SizedBox(height: screenSize.height * 0.02),
            ButtonWidget(title: 'CONTINUE', onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (context)=> const BottomNavScreen()
              )
              );
            },
                color:const Color.fromARGB(255, 33, 63, 63),),
          ],

        ),
      ),

    );
  }
}
