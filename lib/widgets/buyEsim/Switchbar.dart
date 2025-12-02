import 'package:flutter/material.dart';

class Switchbar extends StatelessWidget {
  final bool isUnlimited;
  final ValueChanged<bool> onChanged;

  const Switchbar({
    super.key,
    required this.isUnlimited,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: GestureDetector(
        onTap: () => onChanged(!isUnlimited),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 6),
          width: 200,
          height: 45,
          decoration: BoxDecoration(
            color: Colors.grey.shade200,
            borderRadius: BorderRadius.circular(30),
          ),
          child: Stack(
            children: [
              AnimatedAlign(
                duration: const Duration(milliseconds: 300),
                alignment:
                    isUnlimited ? Alignment.centerRight : Alignment.centerLeft,
                child: Container(
                  width: 90,
                  height: 35,
                  decoration: BoxDecoration(
                    color: isUnlimited ? Colors.green : Colors.blue,
                    borderRadius: BorderRadius.circular(25),
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Center(
                      child: Text(
                        "Limited",
                        style: TextStyle(
                          color: isUnlimited ? Colors.black54 : Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: Center(
                      child: Text(
                        "Unlimited",
                        style: TextStyle(
                          color: isUnlimited ? Colors.white : Colors.black54,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
