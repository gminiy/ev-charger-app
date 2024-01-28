import 'package:ev_charger_app/domain/model/user_model.dart';

abstract interface class AuthRepository {
  Future<UserModel> login();
  Future<void> logout();
  Future<UserModel> update(UserModel newUser);
  Future<UserModel> getUserModel(String id);
}