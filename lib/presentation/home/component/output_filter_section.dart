import 'package:ev_charger_app/presentation/home/home_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class OutputFilterSection extends StatefulWidget {
  const OutputFilterSection({super.key});

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
    final viewModel = context.watch<HomeViewModel>();
    final currentRangeValues = RangeValues(
      _mapOutputToRangeValue(viewModel.state.outputFiler!.minOutput),
      _mapOutputToRangeValue(viewModel.state.outputFiler!.maxOutput),
    );

    return Container(
      height: 160,
      color: Colors.white,
      child: Column(
        children: [
          _buildHeader(),
          _buildRangeSlider(currentRangeValues, viewModel),
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

  Padding _buildRangeSlider(
      RangeValues currentRangeValues, HomeViewModel viewModel) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 32.0),
      child: RangeSlider(
        values: currentRangeValues,
        min: 0,
        max: 4,
        divisions: 4,
        onChanged: (RangeValues values) {
          viewModel.handleOutputFilter(
            _mapRangeValueToOutput(values.start),
            _mapRangeValueToOutput(values.end),
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
