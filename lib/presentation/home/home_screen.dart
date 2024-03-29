import 'package:ev_charger_app/presentation/home/component/charger_card.dart';
import 'package:ev_charger_app/presentation/home/component/drawer_section.dart';
import 'package:ev_charger_app/presentation/home/component/filter_section.dart';
import 'package:ev_charger_app/presentation/home/component/output_filter_section.dart';
import 'package:ev_charger_app/presentation/home/component/status_filter_section.dart';
import 'package:ev_charger_app/presentation/home/component/type_filter_section.dart';
import 'package:ev_charger_app/presentation/home/home_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    final viewModel = context.watch<HomeViewModel>();

    return Scaffold(
      drawer: DrawerSection(
        state: viewModel.state,
        callback: viewModel.onEvent,
      ),
      appBar: AppBar(
          title: viewModel.state.userModel == null
              ? const Text('')
              : Text(viewModel.state.userModel!.address ?? 'undefined'),
          titleTextStyle: const TextStyle(
            color: Colors.black,
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
          backgroundColor: Colors.white,
          bottomOpacity: 1.0,
          scrolledUnderElevation: 0),
      body: Column(
        children: [
          FilterSection(
            state: viewModel.state,
            callback: viewModel.onEvent,
          ),
          Expanded(
            child: Stack(
              children: [
                ListView.builder(
                  itemCount: viewModel.state.chargerModels.length,
                  itemBuilder: (context, index) {
                    return ChargerCard(
                      charger: viewModel.state.chargerModels[index],
                      user: viewModel.state.userModel!,
                    );
                  },
                ),
                if (viewModel.state.isToggledStatusFilter)
                  StatusFilterSection(
                    state: viewModel.state,
                    callback: viewModel.onEvent,
                  ),
                if (viewModel.state.isToggledTypeFilter)
                  TypeFilterSection(
                    state: viewModel.state,
                    callback: viewModel.onEvent,
                  ),
                if (viewModel.state.isToggledOutputFilter)
                  OutputFilterSection(
                    state: viewModel.state,
                    callback: viewModel.onEvent,
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
