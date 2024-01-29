import 'package:ev_charger_app/data/data_source/remote/server_api.dart';
import 'package:ev_charger_app/domain/model/user_model.dart';
import 'package:ev_charger_app/domain/repository/auth_repository.dart';

class AuthRepositoryImpl implements AuthRepository {
  final ServerAPi _api;

  const AuthRepositoryImpl({
    required ServerAPi api,
  }) : _api = api;

  @override
  Future<UserModel?> getUserModel(String id) async {
    final response = await _api.getUser(id);

    if (response == null) {
      return null;
    }

    return UserModel(
      id: response['id'],
      nickname: response['nickname'],
      addressId: response['addressId'],
      address: response['address'],
    );
  }

  @override
  Future<UserModel> login(UserModel user) async {
    UserModel? userModel = await getUserModel(user.id);

    if (userModel == null) {
      final response = await _api.registerUser(user);
      userModel = UserModel(
        id: response['id'],
        nickname: response['nickname'],
        addressId: response['addressId'],
        address: response['address'],
      );
    }

    return userModel;
  }

  @override
  Future<UserModel> update(UserModel newUser) async {
    final response = await _api.updateUser(newUser);

    return UserModel(
      id: response['id'],
      nickname: response['nickname'],
      addressId: response['addressId'],
      address: response['address'],
    );
  }

  //Todo: JWT 사용으로 변경시 처리할 것.
  @override
  void logout() {
    return;
  }
}
