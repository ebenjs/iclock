import 'package:flutter/material.dart';

class Separator extends StatelessWidget {
  String defaultSeparator;
  Separator({super.key, this.defaultSeparator = ":"});

  @override
  Widget build(BuildContext context) {
    return Text(
      defaultSeparator,
      style: const TextStyle(
        fontSize: 100,
        fontWeight: FontWeight.bold,
        color: Colors.white,
      ),
    );
  }
}
