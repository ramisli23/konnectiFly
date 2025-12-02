import 'package:flutter/material.dart';

class Switchbar extends StatefulWidget {
  final bool isUnlimited; // ✅ الحالة (جايّة من الأب)
  final ValueChanged<bool> onChanged; // ✅ كولباك للتغيير

  const Switchbar({
    super.key,
    required this.isUnlimited,
    required this.onChanged,
  });
  @override
  State<Switchbar> createState() => _SwitchbarState();
}

class _SwitchbarState extends State<Switchbar> {
  bool isUnlimited = false; // état du switch

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        children: [
          Text(
            "Standard Plan",
            style: TextStyle(
              color: isUnlimited ? Colors.grey : Colors.black,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(width: 8),
          Switch(
            value: widget.isUnlimited,
            onChanged: (value) {
              setState(() {
                isUnlimited = value;
              });
            },
            activeColor: Colors.blue,
            inactiveThumbColor: Colors.blue,
          ),
          Text(
            "Unlimited Data",
            style: TextStyle(
              color: isUnlimited ? Colors.black : Colors.grey,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
