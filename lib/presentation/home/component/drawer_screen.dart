import 'package:ev_charger_app/presentation/home/component/drawer_view_model.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class DrawerScreen extends StatefulWidget {
  const DrawerScreen({super.key});

  @override
  State<DrawerScreen> createState() => _DrawerScreenState();
}

class _DrawerScreenState extends State<DrawerScreen> {
  @override
  Widget build(BuildContext context) {
    final viewModel = context.watch<DrawerViewModel>();
    return Drawer(
      child: Column(
        children: [
          Expanded(
            child: ListView(
              children: [
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Text(
                    viewModel.user == null ? '' : viewModel.user!.nickname,
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
          ListTile(
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
        ],
      ),
    );
  }
}
