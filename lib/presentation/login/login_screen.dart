import 'package:ev_charger_app/presentation/login/login_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:go_router/go_router.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    final LoginViewModel viewModel = context.watch<LoginViewModel>();

    return Scaffold(
      body: Center(
        child: viewModel.isLoading
            ? const CircularProgressIndicator()
            : GestureDetector(
                child: Image.asset(
                  'assets/kakao/kakao_login_medium_wide.png',
                ),
                onTap: () async {
                  await viewModel.login();

                  if (!mounted) return;

                  context.go('/');
                },
              ),
      ),
    );
  }
}
