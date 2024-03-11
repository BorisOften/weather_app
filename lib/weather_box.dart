import 'package:flutter/material.dart';

class WeatherForcast extends StatelessWidget {
  final String temp;

  const WeatherForcast({super.key, required this.temp});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 120,
      child: Card(
        elevation: 20,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        color: Colors.grey,
        child: Column(
          children: [
            Text(
              temp,
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 22),
            ),
            const SizedBox(
              height: 12,
            ),
            const Icon(
              Icons.cloud,
              size: 50,
            ),
            const Text(
              "Rain",
              style: TextStyle(fontSize: 22),
            ),
          ],
        ),
      ),
    );
  }
}
