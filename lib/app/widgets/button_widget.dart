import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ButtonWidget extends StatelessWidget {
  final String title;
  final void Function()? onTap;
  const ButtonWidget({super.key, required this.title, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.all(20),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(40),
          color: const Color.fromARGB(255, 27, 50, 72),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Text(title,
            style: TextStyle(
              fontWeight: FontWeight.w200,
              fontSize: 16,
              color: Colors.white,
            ),),

            SizedBox(width: 50,),

            Icon(
              Icons.arrow_forward_ios,
              color: Colors.white,
            ),

          ],
        ),
      ),
    );
  }
}
