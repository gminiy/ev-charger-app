import 'package:dio/dio.dart';
import 'package:ev_charger_app/data/data_source/remote/kakao_api.dart';
import 'package:ev_charger_app/data/data_source/remote/server_api.dart';
import 'package:ev_charger_app/data/repository/auth_repository_impl.dart';
import 'package:ev_charger_app/data/repository/kakao_auth_repository_impl.dart';
import 'package:ev_charger_app/domain/repository/auth_repository.dart';
import 'package:ev_charger_app/domain/repository/kakao_auth_repository.dart';
import 'package:ev_charger_app/domain/use_case/get_user_model_use_case.dart';
import 'package:ev_charger_app/domain/use_case/kakao_is_login_use_case.dart';
import 'package:ev_charger_app/domain/use_case/kakao_login_use_case.dart';
import 'package:ev_charger_app/domain/use_case/logout_use_case.dart';
import 'package:ev_charger_app/presentation/auth_status.dart';
import 'package:ev_charger_app/presentation/login/login_view_model.dart';
import 'package:get_it/get_it.dart';

final getIt = GetIt.instance;

void diSetup() async {
  final dio = Dio();

  getIt.registerSingleton<ServerAPi>(ServerAPi(dio: dio));
  getIt.registerSingleton<KakaoApi>(KakaoApi());
  getIt.registerSingleton<AuthRepository>(AuthRepositoryImpl(api: getIt()));
  getIt.registerSingleton<KakaoAuthRepository>(
      KakaoAuthRepositoryImpl(api: getIt()));
  getIt.registerSingleton<KakaoLoginUseCase>(
      KakaoLoginUseCase(kakaoAuthRepository: getIt(), authRepository: getIt()));
  getIt.registerSingleton<KakaoIsLoginUseCase>(
      KakaoIsLoginUseCase(kakaoAuthRepository: getIt()));
  getIt.registerSingleton<GetUserModelUseCase>(GetUserModelUseCase(
      kakaoAuthRepository: getIt(), authRepository: getIt()));
  getIt.registerSingleton<LogoutUseCase>(
      LogoutUseCase(kakaoAuthRepository: getIt()));
  getIt.registerSingleton<AuthStatus>(AuthStatus());
  getIt.registerFactory<LoginViewModel>(
    () => LoginViewModel(kakaoLoginUseCase: getIt(), authStatus: getIt()),
  );
}
