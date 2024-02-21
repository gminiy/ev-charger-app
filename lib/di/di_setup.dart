import 'package:dio/dio.dart';
import 'package:ev_charger_app/data/data_source/remote/kakao_api.dart';
import 'package:ev_charger_app/data/data_source/remote/server_api.dart';
import 'package:ev_charger_app/data/repository/address_repository_impl.dart';
import 'package:ev_charger_app/data/repository/auth_repository_impl.dart';
import 'package:ev_charger_app/data/repository/charger_repository_impl.dart';
import 'package:ev_charger_app/data/repository/kakao_auth_repository_impl.dart';
import 'package:ev_charger_app/domain/repository/address_repository.dart';
import 'package:ev_charger_app/domain/repository/auth_repository.dart';
import 'package:ev_charger_app/domain/repository/charger_repository.dart';
import 'package:ev_charger_app/domain/repository/kakao_auth_repository.dart';
import 'package:ev_charger_app/domain/use_case/filter_charger_output_use_case.dart';
import 'package:ev_charger_app/domain/use_case/filter_charger_status_use_case.dart';
import 'package:ev_charger_app/domain/use_case/filter_charger_type_use_case.dart';
import 'package:ev_charger_app/domain/use_case/find_addresses_use_case.dart';
import 'package:ev_charger_app/domain/use_case/get_chargers_use_case.dart';
import 'package:ev_charger_app/domain/use_case/get_user_model_use_case.dart';
import 'package:ev_charger_app/domain/use_case/kakao_is_login_use_case.dart';
import 'package:ev_charger_app/domain/use_case/kakao_login_use_case.dart';
import 'package:ev_charger_app/domain/use_case/logout_use_case.dart';
import 'package:ev_charger_app/domain/use_case/update_user_use_case.dart';
import 'package:ev_charger_app/presentation/auth_status.dart';
import 'package:ev_charger_app/presentation/home/home_view_model.dart';
import 'package:ev_charger_app/presentation/login/login_view_model.dart';
import 'package:ev_charger_app/presentation/profile/profile_view_model.dart';
import 'package:ev_charger_app/presentation/register_address/register_address_view_model.dart';
import 'package:get_it/get_it.dart';

final getIt = GetIt.instance;

void diSetup() async {
  final dio = Dio();

  getIt.registerSingleton<ServerApi>(ServerApi(dio: dio));
  getIt.registerSingleton<KakaoApi>(KakaoApi());
  getIt.registerSingleton<AuthRepository>(AuthRepositoryImpl(api: getIt()));
  getIt.registerSingleton<KakaoAuthRepository>(
      KakaoAuthRepositoryImpl(api: getIt()));
  getIt.registerSingleton<AddressRepository>(
      AddressRepositoryImpl(api: getIt()));
  getIt.registerSingleton<ChargerRepository>(
      ChargerRepositoryImpl(api: getIt()));
  getIt.registerSingleton<KakaoLoginUseCase>(
      KakaoLoginUseCase(kakaoAuthRepository: getIt(), authRepository: getIt()));
  getIt.registerSingleton<KakaoIsLoginUseCase>(
      KakaoIsLoginUseCase(kakaoAuthRepository: getIt()));
  getIt.registerSingleton<GetUserModelUseCase>(GetUserModelUseCase(
      kakaoAuthRepository: getIt(), authRepository: getIt()));
  getIt.registerSingleton<LogoutUseCase>(
      LogoutUseCase(kakaoAuthRepository: getIt()));
  getIt.registerSingleton<FindAddressesUseCase>(
      FindAddressesUseCase(addressRepository: getIt()));
  getIt.registerSingleton<UpdateUserUseCase>(
      UpdateUserUseCase(authRepository: getIt(), getUserModelUseCase: getIt()));
  getIt.registerSingleton<GetChargersUseCase>(
      GetChargersUseCase(repository: getIt()));
  getIt.registerSingleton<FilterChargerStatusUseCase>(
      FilterChargerStatusUseCase());
  getIt.registerSingleton<FilterChargerTypeUseCase>(FilterChargerTypeUseCase());
  getIt.registerSingleton<FilterChargerOutputUseCase>(
      FilterChargerOutputUseCase());

  getIt.registerSingleton<AuthStatus>(AuthStatus());

  getIt.registerFactory<LoginViewModel>(
    () => LoginViewModel(kakaoLoginUseCase: getIt(), authStatus: getIt()),
  );
  getIt.registerFactory<RegisterAddressViewModel>(
    () => RegisterAddressViewModel(
      authStatus: getIt(),
      findAddressesUseCase: getIt(),
      updateUserUseCase: getIt(),
      getUserModelUseCase: getIt(),
    ),
  );
  getIt.registerFactory<HomeViewModel>(
    () => HomeViewModel(
      logoutUseCase: getIt(),
      getChargersUseCase: getIt(),
      getUserModelUseCase: getIt(),
      filterChargerStatusUseCase: getIt(),
      filterChargerTypeUseCase: getIt(),
      filterChargerOutputUseCase: getIt(),
    ),
  );
  getIt.registerFactory<ProfileViewModel>(
    () => ProfileViewModel(
      getUserModelUseCase: getIt(),
      updateUserUseCase: getIt(),
    ),
  );
}
