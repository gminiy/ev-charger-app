import 'package:ev_charger_app/presentation/home/home_event.dart';
import 'package:ev_charger_app/presentation/home/home_state.dart';
import 'package:flutter/material.dart';

class OutputFilterSection extends StatefulWidget {
  final HomeState _state;
  final void Function(HomeEvent event) _callback;

  const OutputFilterSection(
      {super.key,
      required HomeState state,
      required void Function(HomeEvent event) callback})
      : _state = state,
        _callback = callback;

  @override
  State<OutputFilterSection> createState() => _OutputFilterSectionState();
}

class _OutputFilterSectionState extends State<OutputFilterSection> {
  double _mapOutputToRangeValue(int value) {
    final outputValues = {0: 0.0, 50: 1.0, 100: 2.0, 200: 3.0, 350: 4.0};
    return outputValues[value] ?? 0.0;
  }

  int _mapRangeValueToOutput(double value) {
    final rangeValues = {0.0: 0, 1.0: 50, 2.0: 100, 3.0: 200, 4.0: 350};
    return rangeValues[value.roundToDouble()] ?? 7;
  }

  @override
  Widget build(BuildContext context) {
    final currentRangeValues = RangeValues(
      _mapOutputToRangeValue(widget._state.outputFilter!.minOutput),
      _mapOutputToRangeValue(widget._state.outputFilter!.maxOutput),
    );

    return Container(
      height: 160,
      color: Colors.white,
      child: Column(
        children: [
          _buildHeader(),
          _buildRangeSlider(
            currentRangeValues,
            widget._callback,
          ),
          _buildLabels(),
        ],
      ),
    );
  }

  Padding _buildHeader() {
    return const Padding(
      padding: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text('충전 속도',
              style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold)),
          Text('완속 ~ 350kW',
              style: TextStyle(fontSize: 14, color: Colors.green)),
        ],
      ),
    );
  }

  Padding _buildRangeSlider(RangeValues currentRangeValues,
      void Function(HomeEvent event) onChanged) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 32.0),
      child: RangeSlider(
        values: currentRangeValues,
        min: 0,
        max: 4,
        divisions: 4,
        onChanged: (RangeValues values) {
          onChanged.call(
            HomeEvent.handleOutputFilter(
              _mapRangeValueToOutput(values.start),
              _mapRangeValueToOutput(values.end),
            ),
          );
        },
      ),
    );
  }

  Padding _buildLabels() {
    return const Padding(
      padding: EdgeInsets.symmetric(horizontal: 42.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text('완속', style: TextStyle(fontWeight: FontWeight.bold)),
          Text('50', style: TextStyle(fontWeight: FontWeight.bold)),
          Text('100', style: TextStyle(fontWeight: FontWeight.bold)),
          Text('200', style: TextStyle(fontWeight: FontWeight.bold)),
          Text('350', style: TextStyle(fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }
}
