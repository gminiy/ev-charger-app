import 'package:flutter/material.dart';

class FilterSection extends StatelessWidget {
  final _filters = ["충전 상태"];

  Widget _buildFilterCard(String title) {
    return Card(
      elevation: 0.0,
      margin: const EdgeInsets.symmetric(horizontal: 4.0, vertical: 4.0),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(24.0),
        side: const BorderSide(color: Color(0xFFDEE1E4), width: 1.0),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
        child: Text(
          title,
          style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
        ),
      ),
    );
  }

  FilterSection({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 40,
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: _filters.map(_buildFilterCard).toList(),
      ),
    );
  }
}
