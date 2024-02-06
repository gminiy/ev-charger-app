import 'package:ev_charger_app/di/di_setup.dart';
import 'package:ev_charger_app/presentation/auth_status.dart';
import 'package:ev_charger_app/presentation/charger_detail/charger_detail_screen.dart';
import 'package:ev_charger_app/presentation/home/home_screen.dart';
import 'package:ev_charger_app/presentation/home/home_view_model.dart';
import 'package:ev_charger_app/presentation/login/login_screen.dart';
import 'package:ev_charger_app/presentation/login/login_view_model.dart';
import 'package:ev_charger_app/presentation/profile/profile_screen.dart';
import 'package:ev_charger_app/presentation/register_address/register_address_screen.dart';
import 'package:ev_charger_app/presentation/register_address/register_address_view_model.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

final router = GoRouter(
  initialLocation: '/',
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => ChangeNotifierProvider(
        create: (context) => getIt<HomeViewModel>(),
        child: const HomeScreen(),
      ),
    ),
    GoRoute(
      path: '/register-address',
      builder: (context, state) => ChangeNotifierProvider(
        create: (context) => getIt<RegisterAddressViewModel>(),
        child: const RegisterAddressScreen(),
      ),
    ),
    GoRoute(
      path: '/login',
      builder: (context, state) => ChangeNotifierProvider(
        create: (context) => getIt<LoginViewModel>(),
        child: const LoginScreen(),
      ),
    ),
    GoRoute(
      path: '/charger-detail',
      builder: (context, state) {
        final userId = state.uri.queryParameters['userId'];
        final chargerId = state.uri.queryParameters['chargerId'];
        final location = state.uri.queryParameters['location'];

        return ChargerDetailScreen(chargerId: chargerId!, location: location!, userId: userId!);
      },
    ),
    GoRoute(
      path: '/profile',
      builder: (context, state) => ProfileScreen()
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
