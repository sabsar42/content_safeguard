import 'package:content_safeguard/app/screens/upload_screen.dart';
import 'package:content_safeguard/app/widgets/button_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});
  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 5, 29, 49),
      body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 70, vertical: 70),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          // crossAxisAlignment: CrossAxisAlignment.center,
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
            const SizedBox(height: 100),
            Padding(
              padding: const EdgeInsets.fromLTRB(10,20,30,40),
              child: Image.asset('assets/images/digital-marketing.png'),
            ),
            const SizedBox(height: 100),
            ButtonWidget(title: 'CONTINUE', onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (context)=> UploadScreen()
              )
              );
            },
                color:const Color.fromARGB(255, 32, 47, 59),),
          ],

        ),
      ),

    );
  }
}
