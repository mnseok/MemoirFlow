import 'package:flutter/material.dart';
import 'package:memorial_flow/constants.dart';

const int widgetOpenTime = 500; //milisecond
const widgetCurve = Curves.decelerate;

class MemorialWidget extends StatefulWidget {
  const MemorialWidget({
    Key? key,
    required this.content,
    required this.timeType,
    required this.date,
  }) : super(key: key);

  final String content;
  final int timeType;
  final String date;

  @override
  MemorialWidgetState createState() => MemorialWidgetState();
}

class MemorialWidgetState extends State<MemorialWidget> {
  double _height = 150;
  bool _expanded = false;

  void _toggleHeight() {
    setState(() {
      _expanded = !_expanded;
      _height = _expanded ? 300 : 150; // 높이를 토글
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        _toggleHeight();
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: widgetOpenTime), // 애니메이션 지속 시간
        curve: widgetCurve,
        width: 500,
        height: _height, // 높이가 토글됩니다.
        margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30),
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Theme.of(context).colorScheme.primary.withOpacity(0.1),
              spreadRadius: 5,
              blurRadius: 7,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Column(
          children: [
            SizedBox(
              height: 20,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    widget.date.toString(),
                    style: const TextStyle(
                        fontSize: 15, fontWeight: FontWeight.w200),
                  ),
                  Row(
                    children: [
                      Text(
                        Constants.timePeriodList[widget.timeType].toString(),
                        style: const TextStyle(
                            fontSize: 15, fontWeight: FontWeight.w200),
                      ),
                      const Icon(Icons.more_vert)
                    ],
                  )
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 15),
              child: Align(
                alignment: Alignment.topLeft,
                child: LayoutBuilder(
                  builder: (context, constraints) {
                    return AnimatedContainer(
                      duration: const Duration(milliseconds: widgetOpenTime),
                      curve: widgetCurve,
                      height: _expanded ? 200 : 60,
                      constraints: BoxConstraints(
                        maxWidth: constraints.maxWidth,
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                            widget.content.toString(),
                            style: const TextStyle(
                                fontFamily: 'PretendardExtraLight',
                                fontSize: 20,
                                fontWeight: FontWeight.w500),
                            overflow: TextOverflow.ellipsis,
                            maxLines: _expanded ? 5 : 2, // 높이에 따라 maxLines 조절
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
