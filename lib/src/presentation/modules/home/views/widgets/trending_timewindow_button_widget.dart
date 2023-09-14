import 'package:flutter/material.dart';

import '../../../../../domain/enums.dart';

class TrendingTimewindowButtonWidget extends StatelessWidget {
  const TrendingTimewindowButtonWidget({
    required this.dropDownFunction,
    required this.timeWindow,
    super.key,
  });
  final void Function(TimeWindow?) dropDownFunction;
  final TimeWindow timeWindow;
  @override
  Widget build(BuildContext context) {
    return DropdownButton<TimeWindow>(
      borderRadius: BorderRadius.circular(10.0),
      padding: const EdgeInsets.symmetric(horizontal: 5.0),
      autofocus: true,
      isDense: true,
      underline: const SizedBox.shrink(),
      items: const <DropdownMenuItem<TimeWindow>>[
        DropdownMenuItem<TimeWindow>(
          value: TimeWindow.day,
          child: Text('Last 24H'),
        ),
        DropdownMenuItem<TimeWindow>(
          value: TimeWindow.week,
          child: Text('Last Week'),
        ),
      ],
      onChanged: dropDownFunction,
      value: timeWindow,
    );
  }
}
