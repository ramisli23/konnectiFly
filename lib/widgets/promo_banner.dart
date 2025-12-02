import 'package:flutter/material.dart';

class PromoBanner extends StatelessWidget {
  const PromoBanner({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 80,
      margin: EdgeInsets.all(20),

      decoration: BoxDecoration(borderRadius: BorderRadius.circular(12)),

      child: Image.asset('assets/images/png/pub.png', height: 60),
    );
  }
}
