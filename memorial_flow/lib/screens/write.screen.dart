// write.screen.dart
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:memorial_flow/constants.dart';
import 'package:memorial_flow/main.dart';

const double _kItemExtent = 32.0;

class WriteScreen extends StatefulWidget {
  const WriteScreen({super.key, required this.date});
  final DateTime date;
  @override
  State<WriteScreen> createState() => _WriteState();
}

class _WriteState extends State<WriteScreen> {
  final now = DateTime.now();
  late final currentTime = now.hour;
  late int _selectedFruit = Constants.selectedIndexList[currentTime];

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
                  children: List<Widget>.generate(
                      Constants.timePeriodList.length, (int index) {
                    return Center(child: Text(Constants.timePeriodList[index]));
                  }),
                ),
              ),
            ));
  }

  @override
  Widget build(BuildContext context) {
    String content = '';
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
              onPressed: () async {
                await supabase.from('article').insert(
                  {
                    'timeType': _selectedFruit,
                    'content': content,
                    'date': widget.date.toString().split(" ")[0],
                    'userId': supabase.auth.currentUser?.id,
                  },
                );
                Navigator.pop(context, true); // 'true'는 데이터를 전달하는 예시입니다.
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
                Constants.timePeriodList[_selectedFruit],
                style: const TextStyle(
                  fontSize: 30.0,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: TextField(
                onChanged: (text) {
                  content = text;
                },
                decoration: const InputDecoration(
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
