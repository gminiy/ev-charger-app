import 'package:ev_charger_app/di/di_setup.dart';
import 'package:ev_charger_app/presentation/auth_status.dart';
import 'package:ev_charger_app/presentation/login/login_screen.dart';
import 'package:ev_charger_app/presentation/login/login_view_model.dart';
import 'package:ev_charger_app/presentation/register_address/register_address_screen.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

final router = GoRouter(
  initialLocation: '/',
  routes: [
    GoRoute(
        path: '/register-address',
        builder: (context, state) => const RegisterAddressScreen()),
    GoRoute(
      path: '/login',
      builder: (context, state) => ChangeNotifierProvider(
        create: (context) => getIt<LoginViewModel>(),
        child: const LoginScreen(),
      ),
    ),
  ],
  refreshListenable: getIt<AuthStatus>(),
  redirect: (context, state) {
    if (state.fullPath == '/login') {
      return null;
    }

    if (!(getIt<AuthStatus>().isLogin)) {
      return '/login';
    }

    if (getIt<AuthStatus>().addressId == null) {
      return '/register-address';
    }

    return null;
  },
);
