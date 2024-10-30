import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ButtonWidget extends StatelessWidget {
  final String title;
  final void Function()? onTap;
  final Color? color;
  const ButtonWidget({super.key, required this.title, required this.onTap, this.color});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(40),
      splashColor: Colors.blue.withOpacity(0.5), // Customize splash color
      highlightColor: Colors.blue.withOpacity(0.3), // Customize highlight color
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.all(20),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(40),
          color: color,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
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
