import 'package:flutter/material.dart';

class Dataoptions extends StatelessWidget {
  final int selectedIndex;
  final ValueChanged<int> onSelected;

  const Dataoptions({
    super.key,
    required this.selectedIndex,
    required this.onSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          _buildOption("DATA-ONLY", 0),
          const SizedBox(width: 20),
          _buildOption("DATA-VOICE-SMS", 1),
        ],
      ),
    );
  }

  Widget _buildOption(String title, int index) {
    bool isSelected = selectedIndex == index;

    return GestureDetector(
      onTap: () => onSelected(index),
      child: Container(
        width: 170,
        height: 40,
        decoration: BoxDecoration(
          color: isSelected ? Colors.blue : Colors.grey.withOpacity(0.15),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Center(
          child: Text(
            title,
            style: TextStyle(
              color: isSelected ? Colors.white : Colors.black,
              fontWeight: FontWeight.bold,
              fontSize: 13,
            ),
          ),
        ),
      ),
    );
  }
}
