import 'package:flutter/material.dart';

Widget buildCollapsedFAB(BuildContext context) {
  final theme = Theme.of(context);
  final colorScheme = theme.colorScheme;

  return AnimatedContainer(
    duration: const Duration(milliseconds: 200),
    curve: Curves.linear,
    width: 50,
    height: 50,
    child: FloatingActionButton.extended(
      onPressed: () {
        Navigator.pushNamed(context, '/compose');
      },
      backgroundColor:
          colorScheme.primaryContainer, // More modern contrast color
      highlightElevation: 2, // Feedback effect for tap instead of splashColor
      icon: const Padding(
        padding: EdgeInsets.only(left: 8.0),
        child: Icon(Icons.edit, color: Colors.red),
      ),
      label: const Text(''), // Fixes layout issues
    ),
  );
}
