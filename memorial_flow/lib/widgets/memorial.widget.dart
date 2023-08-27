import 'package:flutter/material.dart';

class Memorial extends StatelessWidget {
  const Memorial({
    super.key,
    required this.content,
  });

  final String content;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 350,
      height: 150,
      margin: const EdgeInsets.all(10),
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30),
        color: Theme.of(context).colorScheme.primary,
      ),
      // color: Theme.of(context).colorScheme.primary,
      child: Text(
        content,
        style: const TextStyle(
            fontFamily: 'OoohBaby', fontSize: 30, fontWeight: FontWeight.w700),
      ),
    );
  }
}
