import 'package:flutter/material.dart';

class Write extends StatefulWidget {
  const Write({super.key, required this.data});

  final String data;

  @override
  State<Write> createState() => _WriteState();
}

class _WriteState extends State<Write> {
  BuildContext? _context;

  String content = '';
  String time = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
            backgroundColor: Theme.of(context).colorScheme.inversePrimary,
            title: Text(
              '글쓰기',
              style: const TextStyle(
                  fontFamily: 'OoohBaby',
                  fontSize: 20,
                  fontWeight: FontWeight.w700),
            ),
            leading: IconButton(
              icon: const Icon(Icons.arrow_back),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
            actions: [
              IconButton(
                icon: const Icon(Icons.check),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
            ]),
        body: Padding(
          padding: EdgeInsets.all(20),
          // child: loadBuilder(),
        ));
  }
}
