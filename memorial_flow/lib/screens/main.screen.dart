import 'package:flutter/material.dart';
import 'package:memorial_flow/widgets/memorial.widget.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key, required this.date});

  final String date;

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  DateTime _selectedDay = DateTime.now();
  final List<String> entries = <String>['a', 'b', 'c', 'd'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: TextButton(
            onPressed: () async {
              final selectedDate = await showDatePicker(
                context: context,
                initialDate: _selectedDay,
                firstDate: DateTime(2010),
                lastDate: DateTime.now(),
              );

              if (selectedDate != null) {
                setState(() {
                  _selectedDay = selectedDate;
                });
              }
            },
            child: Text(
              _selectedDay.toString().split(" ")[0],
              style: const TextStyle(
                // fontFamily: 'OoohBaby',
                fontSize: 20,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
          leading: IconButton(
            icon: const Icon(Icons.arrow_left),
            onPressed: () {
              setState(() {
                _selectedDay = _selectedDay.subtract(const Duration(days: 1));
              });
            },
          ),
          actions: [
            IconButton(
              icon: const Icon(Icons.arrow_right),
              onPressed: () {
                setState(() {
                  if (_selectedDay
                      .add(const Duration(days: 1))
                      .isBefore(DateTime.now())) {
                    _selectedDay = _selectedDay.add(const Duration(days: 1));
                  }
                });
              },
            ),
          ],
        ),
        body: ListView.builder(
            padding: const EdgeInsets.all(8),
            itemCount: entries.length,
            itemBuilder: (BuildContext context, int index) {
              return MemorialWidget(content: entries[index]);
            }));
  }
}
