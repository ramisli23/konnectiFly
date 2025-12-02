import 'package:flutter/material.dart';

class Localesims extends StatefulWidget {
  const Localesims({super.key});

  @override
  State<Localesims> createState() => _BuyEsimScreenState();
}

class _BuyEsimScreenState extends State<Localesims> {
  int selectedIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(20),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          _buildOPtion("Local eSIMS", 0),
          const SizedBox(width: 20),
          _buildOPtion("Regional eSIMs", 1),
          const SizedBox(width: 20),
          _buildOPtion("Global eSIMs", 2),
        ],
      ),
    );
  }

  Widget _buildOPtion(String title, int index) {
    bool isSelcted = selectedIndex == index;

    return GestureDetector(
      onTap: () {
        setState(() {
          selectedIndex = index;
        });
      },
      child: Container(
        width: 100,
        height: 40,
        decoration: BoxDecoration(
          color: isSelcted ? Colors.blue : Colors.grey.withOpacity(0.15),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Center(
          child: Text(
            title,
            style: TextStyle(
              color: isSelcted ? Colors.white : Colors.black,
              fontWeight: FontWeight.bold,
              fontSize: 13,
            ),
          ),
        ),
      ),
    );
  }
}
