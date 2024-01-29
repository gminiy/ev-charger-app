import 'package:ev_charger_app/di/di_setup.dart';
import 'package:ev_charger_app/domain/use_case/kakao_is_login_use_case.dart';
import 'package:ev_charger_app/presentation/auth_status.dart';
import 'package:ev_charger_app/route/router.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: '.env');
  diSetup();
  final isLogin = await getIt<KakaoIsLoginUseCase>().execute();
  getIt<AuthStatus>().setIsLogin(isLogin);

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerConfig: router,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
    );
  }
}
