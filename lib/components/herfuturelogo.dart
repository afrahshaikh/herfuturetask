import 'package:flutter/material.dart';

Widget logoherFuture() {
  return RichText(
    text: TextSpan(
      style: const TextStyle(fontSize: 24,fontWeight: FontWeight.w500), // Optional: set a default style
      children: const [
        TextSpan(
          text: 'her',
          style: TextStyle(color: Color.fromARGB(255, 229, 129, 163)),
        ),
        TextSpan(
          text: 'future',
          style: TextStyle(color: Color.fromARGB(255, 38, 49, 59)),
        ),
        TextSpan(
          text: '.',
          style: TextStyle(color: Color.fromARGB(255, 229, 129, 163)),
        ),
      ],
    ),
  );
}
