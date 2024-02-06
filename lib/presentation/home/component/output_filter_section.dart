import 'package:flutter/material.dart';

class OutputFilterSection extends StatefulWidget {
  const OutputFilterSection({super.key});

  @override
  State<OutputFilterSection> createState() => _OutputFilterSectionState();
}

class _OutputFilterSectionState extends State<OutputFilterSection> {
  RangeValues _currentRangeValues = const RangeValues(0, 4);

  int _mapRangeValueToOutput(int value) {
    switch (value.round()) {
      case 0:
        return 7;
      case 1:
        return 50;
      case 2:
        return 100;
      case 3:
        return 200;
      case 4:
        return 350;
      default:
        return value;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 160,
      width: MediaQuery.of(context).size.width,
      color: Colors.white,
      child: Column(
        children: [
          const Padding(
            padding: EdgeInsets.only(bottom: 16, top: 8, right: 16, left: 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  '충전 속도',
                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                ),
                Text(
                  '완속 ~ 350kW',
                  style: TextStyle(fontSize: 14, color: Colors.green),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 32.0),
            child: Column(
              children: [
                RangeSlider(
                  values: _currentRangeValues,
                  min: 0,
                  max: 4,
                  divisions: 4,
                  onChanged: (RangeValues values) {
                    setState(() {
                      _currentRangeValues = values;
                    });
                  },
                ),
                const Padding(
                  padding: EdgeInsets.symmetric(vertical: 0, horizontal: 10.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        '완속',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      Text(
                        '50',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      Text(
                        '100',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      Text(
                        '200',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      Text(
                        '350',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
