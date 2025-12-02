import 'package:flutter/material.dart';

class Preparedtravel extends StatefulWidget {
  final String country;
  final String imagePath;
  final String price;

  const Preparedtravel({
    super.key,
    required this.country,
    required this.imagePath,
    required this.price,
  });

  @override
  State<Preparedtravel> createState() => _PreparedtravelState();
}

class _PreparedtravelState extends State<Preparedtravel> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: 170,
          margin: EdgeInsets.all(20),
          width: double.infinity,
          decoration: BoxDecoration(
            color: Color(0xffFFFFFF),
            borderRadius: BorderRadius.circular(40),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.1),
                spreadRadius: 2,
                blurRadius: 8,
                offset: Offset(0, 4),
              ),
            ],
          ),
          child: Column(
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Travel prepared",
                    style: TextStyle(
                      color: Colors.grey,
                      fontWeight: FontWeight.bold,
                      fontSize: 15,
                    ),
                  ),
                  SizedBox(width: 7),
                  Icon(Icons.airplanemode_active, color: Colors.grey),
                ],
              ),

              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircleAvatar(
                    backgroundImage: AssetImage(widget.imagePath),
                    backgroundColor: Colors.transparent,
                  ),
                  SizedBox(width: 7),
                  Text(
                    "kOONECTI For ${widget.country}",
                    //United States",
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              Text(
                "Get the best eSIM for ${widget.country} travel from eSIMCard. Enjoy\n seamless connectivity and affordable unlimited data plans. Stay \n connected wherever you go.",
                style: TextStyle(color: Colors.black),
              ),
            ],
          ),
        ),
        SizedBox(height: 20),
        Text(
          "Pick the Best kONNECTI Plans for ${widget.country} Travel",
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
            fontSize: 17,
          ),
        ),
      ],
    );
  }
}
