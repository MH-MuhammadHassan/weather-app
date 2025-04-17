import 'package:flutter/material.dart';

class CustomSizedbox extends StatelessWidget {
  final String time;
  final IconData icon;
  final String temperature;

  const CustomSizedbox({
    super.key,
    required this.time,
    required this.icon,
    required this.temperature,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 100,
      child: Card(
        elevation: 10,
        color: const Color(0xff3B3841),
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                time,
                style: const TextStyle(
                    color: Colors.white,
                    fontSize: 15,
                    fontWeight: FontWeight.bold),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
              ),
              Icon(
                icon,
                color: Colors.white,
                size: 20,
              ),
              Text(
                temperature,
                style: const TextStyle(
                  color: Color(0xffE4E1E8),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
