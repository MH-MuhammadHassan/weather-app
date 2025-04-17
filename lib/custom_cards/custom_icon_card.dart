import 'package:flutter/material.dart';

class CustomIconCard extends StatelessWidget {
  final IconData icon;
  final String text;

  final String time;

  const CustomIconCard({
    super.key,
    required this.icon,
    required this.text,
    required this.time,
  });

  @override
  Widget build(BuildContext context) {
    return // 3 boxes after additional information
        Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        SizedBox(
          child: Card(
            elevation: 0,
            color: Color(0xff29292B),
            child: Padding(
              padding: const EdgeInsets.all(15.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    icon,
                    color: Colors.white,
                    size: 20,
                  ),
                  Text(
                    text,
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 15,
                        fontWeight: FontWeight.bold),
                  ),
                  Text(
                    time,
                    style: TextStyle(
                      color: Color(0xffE4E1E8),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
