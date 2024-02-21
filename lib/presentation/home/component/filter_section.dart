import 'package:ev_charger_app/presentation/home/home_event.dart';
import 'package:ev_charger_app/presentation/home/home_state.dart';
import 'package:flutter/material.dart';

class FilterSection extends StatefulWidget {
  final HomeState _state;
  final void Function(HomeEvent event) _callback;

  const FilterSection(
      {super.key,
      required HomeState state,
      required void Function(HomeEvent event) callback})
      : _state = state,
        _callback = callback;

  @override
  State<FilterSection> createState() => _FilterSectionState();
}

class _FilterSectionState extends State<FilterSection> {
  Widget _buildFilterCard(String title, VoidCallback onTap, bool isToggled) {
    return GestureDetector(
      onTap: () => onTap(),
      child: Card(
        elevation: 0.0,
        color: isToggled ? Colors.lightGreen[200] : Colors.white,
        margin: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
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
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final Map<String, Map<String, Object>> filters = {
      'status': {
        'title': '충전 상태',
        'onTap': () =>
            widget._callback.call(const HomeEvent.toggleStatusFilter()),
        'isToggled': widget._state.isToggledStatusFilter,
      },
      'type': {
        'title': '충전기 타입',
        'onTap': () =>
            widget._callback.call(const HomeEvent.toggleTypeFilter()),
        'isToggled': widget._state.isToggledTypeFilter,
      },
      'output': {
        'title': '충전 속도',
        'onTap': () =>
            widget._callback.call(const HomeEvent.toggleOutputFilter()),
        'isToggled': widget._state.isToggledOutputFilter,
      }
    };

    return SizedBox(
      height: 40,
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: filters.keys.map((filter) {
          final filterInfo = filters[filter]!;
          final title = filterInfo['title'] as String;
          final onTap = filterInfo['onTap'] as VoidCallback;
          final isToggled = filterInfo['isToggled'] as bool;

          return _buildFilterCard(
            title,
            onTap,
            isToggled,
          );
        }).toList(),
      ),
    );
  }
}
