import 'package:ev_charger_app/presentation/home/component/charger_status_filter.dart';
import 'package:ev_charger_app/presentation/home/home_event.dart';
import 'package:ev_charger_app/presentation/home/home_state.dart';
import 'package:flutter/material.dart';

class StatusFilterSection extends StatelessWidget {
  final HomeState _state;
  final void Function(HomeEvent event) _callback;

  const StatusFilterSection({
    super.key,
    required HomeState state,
    required void Function(HomeEvent event) callback,
  })  : _state = state,
        _callback = callback;

  Widget _buildStatusCard(
      ChargerStatusFilter statusFilter, VoidCallback onTap) {
    return GestureDetector(
      onTap: () => onTap(),
      child: Card(
        color: statusFilter.isSelected ? Colors.green : Colors.white,
        elevation: 0.0,
        margin: const EdgeInsets.symmetric(horizontal: 4.0, vertical: 4.0),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(24.0),
          side: const BorderSide(color: Color(0xFFDEE1E4), width: 1.0),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
          child: Center(
            child: Text(
              statusFilter.label,
              style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 128,
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              '충전 상태',
              style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
            ),
            const SizedBox(
              height: 8,
            ),
            Expanded(
              child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  childAspectRatio: 3 / 1,
                  crossAxisSpacing: 16.0,
                  mainAxisSpacing: 3.0,
                ),
                itemCount: _state.statusFilters.length,
                itemBuilder: (context, index) {
                  return _buildStatusCard(
                    _state.statusFilters[index],
                    () {
                      _callback.call(
                        HomeEvent.handleStatusFilter(
                          _state.statusFilters[index],
                        ),
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
