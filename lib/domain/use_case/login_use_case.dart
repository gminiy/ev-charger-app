import 'package:ev_charger_app/domain/model/user_model.dart';

abstract interface class LoginUseCase {
  Future<UserModel> execute();
}