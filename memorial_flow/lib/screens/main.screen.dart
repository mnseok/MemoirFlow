import 'package:flutter/material.dart';
import 'package:memorial_flow/widgets/memorial.widget.dart';

class FirstScreen extends StatelessWidget {
  FirstScreen({super.key});
  final List<String> entries = <String>['a', 'b', 'c', 'd'];
  final List<int> colorCodes = <int>[600, 500, 100, 200];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: ListView.builder(
            padding: const EdgeInsets.all(8),
            itemCount: entries.length,
            itemBuilder: (BuildContext context, int index) {
              return Memorial(content: entries[index]);
            }));
  }
}
