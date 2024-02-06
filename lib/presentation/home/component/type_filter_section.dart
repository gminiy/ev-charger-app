import 'package:ev_charger_app/presentation/home/component/charger_type_filter.dart';
import 'package:ev_charger_app/presentation/home/home_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class TypeFilterSection extends StatelessWidget {
  const TypeFilterSection({super.key});

  Widget _buildStatusCard(ChargerTypeFilter typeFilter, Function onTap) {
    return GestureDetector(
      onTap: () => onTap(),
      child: Card(
        color: typeFilter.isSelected ? Colors.green : Colors.white,
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
              typeFilter.label,
              style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final viewModel = context.watch<HomeViewModel>();
    return Container(
      height: 128,
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              '충전 타입',
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
                itemCount: viewModel.state.typeFilters.length,
                itemBuilder: (context, index) {
                  return _buildStatusCard(
                    viewModel.state.typeFilters[index],
                    () {
                      viewModel
                          .handleTypeFilter(viewModel.state.typeFilters[index]);
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
