import 'package:ev_charger_app/presentation/home/component/charger_card.dart';
import 'package:ev_charger_app/presentation/home/component/drawer_section.dart';
import 'package:ev_charger_app/presentation/home/component/filter_section.dart';
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
      drawer: const DrawerSection(),
      body: Padding(
        padding: const EdgeInsets.all(8),
        child: CustomScrollView(
          slivers: [
            SliverAppBar(
              floating: true,
              backgroundColor: Colors.white,
              centerTitle: false,
              expandedHeight: 44,
              title: viewModel.state.userModel == null
                  ? const Text('')
                  : Text(viewModel.state.userModel!.address ?? 'undefined'),
              titleTextStyle: const TextStyle(
                color: Colors.black,
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
              bottom: const PreferredSize(
                preferredSize: Size.fromHeight(30),
                child: FilterSection(),
              ),
            ),
            if (viewModel.state.userModel != null)
              SliverList(
                delegate: SliverChildListDelegate(
                  viewModel.state.chargerModels
                      .map(
                        (e) => ChargerCard(
                          charger: e,
                          user: viewModel.state.userModel!,
                        ),
                      )
                      .toList(),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
