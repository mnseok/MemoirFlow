import 'package:flutter/material.dart';

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

class MemorialWidget extends StatelessWidget {
  const MemorialWidget({
    super.key,
    required this.content,
    required this.timeType,
    required this.date,
  });
  final String content;
  final int timeType;
  final String date;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 350,
      height: 150,
      margin: const EdgeInsets.all(5),
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30),
        // color: Theme.of(context).colorScheme.primary,
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Theme.of(context).colorScheme.primary.withOpacity(0.1),
            spreadRadius: 5,
            blurRadius: 7,
            offset: const Offset(0, 3), // changes position of shadow
          ),
        ],
      ),
      // color: Theme.of(context).colorScheme.primary,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 0),
        child: Column(
          children: [
            SizedBox(
              height: 20,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    date.toString(),
                    style: const TextStyle(
                        fontFamily: 'PretendardExtraLight',
                        fontSize: 15,
                        fontWeight: FontWeight.w200),
                  ),
                  Text(
                    _timeperiod[timeType].toString(),
                    style: const TextStyle(
                        fontFamily: 'PretendardExtraLight',
                        fontSize: 15,
                        fontWeight: FontWeight.w200),
                  ),
                ],
              ),
            ),
            Align(
              alignment: Alignment.topLeft,
              child: SizedBox(
                height: 80,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      content.toString(),
                      style: const TextStyle(
                          fontFamily: 'PretendardExtraLight',
                          fontSize: 25,
                          fontWeight: FontWeight.w500),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
