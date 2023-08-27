import 'package:flutter/material.dart';

class SecondScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: const Text("Second Screen"),
      // ),
      body: Center(
        child: TextButton(
          onPressed: () {
            // 클릭하면 첫 번째 화면으로 돌아갑니다!
          },
          child: const Text('Go back!'),
        ),
      ),
    );
  }
}
