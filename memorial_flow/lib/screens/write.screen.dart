import 'package:flutter/material.dart';

class Write extends StatefulWidget {
  const Write({super.key, required this.data});

  final String data;

  @override
  State<Write> createState() => _WriteState();
}

class _WriteState extends State<Write> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
            child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        
        TextButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: const Text('Go back!'),
        ),
        Text(widget.data),
      ],
    )));
  }
}
