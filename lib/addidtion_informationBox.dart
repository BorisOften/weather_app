import 'package:flutter/material.dart';

class AddidtioniInformationBox extends StatelessWidget {
  final IconData icon;
  final String title;
  final int degree;

  const AddidtioniInformationBox(
      {super.key,
      required this.icon,
      required this.title,
      required this.degree});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Icon(
          icon,
          size: 40,
        ),
        Text(
          title,
          style: const TextStyle(fontSize: 20),
        ),
        Text(
          '$degree',
          style: const TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
        )
      ],
    );
  }
}
