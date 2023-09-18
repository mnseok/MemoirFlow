import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

const double _kItemExtent = 32.0;
const List<String> _timeperiod = <String>[
  '00:00 ~ 02:00',
  '02:00 ~ 04:00',
  '04:00 ~ 06:00',
  '06:00 ~ 08:00',
  '08:00 ~ 10:00',
  '10:00 ~ 12:00',
  '12:00 ~ 14:00',
  '14:00 ~ 16:00',
  '16:00 ~ 18:00',
  '18:00 ~ 20:00',
  '20:00 ~ 22:00',
  '22:00 ~ 24:00',
];

const List<int> _selectedIndexList = <int>[
  0,
  0,
  1,
  1,
  2,
  2,
  3,
  3,
  4,
  4,
  5,
  5,
  6,
  6,
  7,
  7,
  8,
  8,
  9,
  9,
  10,
  10,
  11,
  11,
];

class Write extends StatefulWidget {
  const Write({super.key, required this.data});
  final String data;
  @override
  State<Write> createState() => _WriteState();
}

class _WriteState extends State<Write> {
  final currentTime = DateTime.now().hour;
  late int _selectedFruit = _selectedIndexList[currentTime];

  // class를 생성할때 순차적으로 코드가 읽히는게 아니라 다 각자 실행되기 때문에 currentTime이 initialize
  // 된 상태가 아니다. late로 순서대로 변수가 초기화 될 수 있도록 했다.

  void _showDialog() {
    // 시간 보여주는 표 함수

    showCupertinoModalPopup<void>(
        context: context,
        builder: (BuildContext context) => Container(
              height: 216,
              padding: const EdgeInsets.only(top: 6.0),
              // The Bottom margin is provided to align the popup above the system navigation bar.
              margin: EdgeInsets.only(
                bottom: MediaQuery.of(context).viewInsets.bottom,
              ),
              // Provide a background color for the popup.
              color: CupertinoColors.systemBackground.resolveFrom(context),
              // Use a SafeArea widget to avoid system overlaps.
              child: SafeArea(
                top: false,
                child: CupertinoPicker(
                  magnification: 1.22,
                  squeeze: 1.2,
                  useMagnifier: true,
                  itemExtent: _kItemExtent,
                  // This sets the initial item.
                  scrollController: FixedExtentScrollController(
                    initialItem: _selectedFruit,
                  ),
                  // This is called when selected item is changed.
                  onSelectedItemChanged: (int selectedItem) {
                    setState(() {
                      _selectedFruit = selectedItem;
                    });
                  },
                  children:
                      List<Widget>.generate(_timeperiod.length, (int index) {
                    return Center(child: Text(_timeperiod[index]));
                  }),
                ),
              ),
            ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
          backgroundColor: Theme.of(context).colorScheme.inversePrimary,
          title: const Text(
            '글쓰기',
            style: TextStyle(
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
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            const Text('Selected time: '),
            CupertinoButton(
              padding: EdgeInsets.zero,
              // Display a CupertinoPicker with list of time.
              onPressed: () => _showDialog(),
              // This displays the selected time interval.
              child: Text(
                _timeperiod[_selectedFruit],
                style: const TextStyle(
                  fontSize: 30.0,
                ),
              ),
            ),
            const Padding(
              padding: EdgeInsets.all(20.0),
              child: TextField(
                decoration: InputDecoration(
                  labelText: 'Input',
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
