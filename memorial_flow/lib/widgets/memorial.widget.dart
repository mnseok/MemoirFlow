// memorial.widget.dart
import 'package:flutter/material.dart';
import 'package:memorial_flow/constants.dart';

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
      width: 500,
      height: 150,
      margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
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
                    Constants.timePeriodList[timeType].toString(),
                    style: const TextStyle(
                        fontFamily: 'PretendardExtraLight',
                        fontSize: 15,
                        fontWeight: FontWeight.w200),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 15),
              child: Align(
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
                            fontSize: 20,
                            fontWeight: FontWeight.w500),
                        overflow: TextOverflow.ellipsis,
                        maxLines: 2,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
