
import 'package:flutter/material.dart';

class ResultDisplayWidget extends StatelessWidget {
  final String resultText;
  final Color resultColor;

  const ResultDisplayWidget({
    super.key,
    required this.resultText,
    required this.resultColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.6,
      height: MediaQuery.of(context).size.height * 0.08,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: const Color.fromARGB(255, 208, 213, 218),
        border: Border.all(
          color: Colors.white,
          width: 2,
        ),
        boxShadow: [
          BoxShadow(
            color: resultColor.withOpacity(0.3),
            spreadRadius: 2,
            blurRadius: 5,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Center(
        child: Text(
          resultText,
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w600,
            color: resultColor,
          ),
        ),
      ),
    );
  }
}
