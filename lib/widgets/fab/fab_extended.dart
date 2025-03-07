import 'package:flutter/material.dart';

Widget buildExtendedFAB(BuildContext context) {
  final theme = Theme.of(context);
  final colorScheme = theme.colorScheme;

  return AnimatedContainer(
    duration: const Duration(milliseconds: 200),
    curve: Curves.linear,
    width: 150,
    height: 50,
    child: FloatingActionButton.extended(
      onPressed: () {
        Navigator.pushNamed(context, '/compose');
      },
      backgroundColor:
          colorScheme.primaryContainer, // More modern contrast color
      highlightElevation: 2, // Feedback effect for tap
      icon: const Icon(Icons.edit, color: Colors.red),
      label: const Text(
        "Compose",
        style: TextStyle(fontSize: 15, color: Colors.red),
      ),
    ),
  );
}
