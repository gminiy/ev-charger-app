import 'package:ev_charger_app/domain/model/user_model.dart';
import 'package:ev_charger_app/presentation/home/charger_card.dart';
import 'package:ev_charger_app/presentation/home/home_view_model.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

final _filters = [
  "filter1",
  "filter2333333",
  "filter3222",
  "filt",
  "filter5444",
  "filter6",
];

class _HomeScreenState extends State<HomeScreen> {
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

  @override
  Widget build(BuildContext context) {
    final viewModel = context.watch<HomeViewModel>();

    Widget buildDrawer(UserModel user) {
      return Drawer(
        child: Column(
          children: [
            Expanded(
              child: ListView(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Text(
                      user.nickname,
                      style: const TextStyle(
                          fontSize: 16.0, fontWeight: FontWeight.bold),
                    ),
                  ),
                  ListTile(title: const Text('내 정보'), onTap: () {}),
                  ListTile(title: const Text('고객센터'), onTap: () {}),
                  ListTile(title: const Text('이용 약관 및 정책'), onTap: () {}),
                  ListTile(title: const Text('버전 정보'), onTap: () {}),
                ],
              ),
            ),
            Container(
              child: ListTile(
                leading: const Icon(
                  Icons.exit_to_app, // 로그아웃 아이콘
                  color: Colors.grey, // 아이콘 색상
                ),
                title: const Text(
                  '로그아웃',
                  style: TextStyle(
                    color: Colors.grey, // 텍스트 색상
                    fontWeight: FontWeight.bold,
                  ),
                ),
                onTap: () async {
                  await viewModel.logout();

                  if (!mounted) return;

                  context.go('/login');
                },
              ),
            ),
          ],
        ),
      );
    }

    return Scaffold(
      drawer: viewModel.state.userModel == null
          ? null
          : buildDrawer(viewModel.state.userModel!),
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
                  fontWeight: FontWeight.bold),
              bottom: PreferredSize(
                preferredSize: const Size.fromHeight(30),
                child: SizedBox(
                  height: 40,
                  child: ListView(
                    scrollDirection: Axis.horizontal,
                    children: _filters.map(_buildFilterCard).toList(),
                  ),
                ),
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
