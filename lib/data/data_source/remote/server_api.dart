import 'dart:io';

import 'package:dio/dio.dart';
import 'package:ev_charger_app/domain/model/user_model.dart';

class ServerApi {
  final String _baseUrl = Platform.isAndroid ? 'http://10.0.2.2:8080' : 'http://192.168.50.116:8080';
  final Dio _dio;

  ServerApi({
    required Dio dio,
  }) : _dio = dio;

  Future<Map<String, dynamic>?> getUser(String userId) async {
    try {
      final response =
          await _dio.get('$_baseUrl/user', queryParameters: {'id': userId});
      return response.data;
    } on DioException catch (e) {
      if (e.response!.statusCode == 404) {
        return null;
      }

      throw Exception();
    }
  }

  Future<Map<String, dynamic>> registerUser(UserModel userModel) async {
    final response = await _dio.post(
      '$_baseUrl/user/register',
      data: {
        'id': userModel.id,
        'nickname': userModel.nickname,
        'addressId': userModel.addressId,
      },
    );

    return response.data;
  }

  Future<Map<String, dynamic>> updateUser(UserModel userModel) async {
    final response = await _dio.post('$_baseUrl/user/update', data: {
      'id': userModel.id,
      'nickname': userModel.nickname,
      'addressId': userModel.addressId,
    });

    return response.data;
  }

  Future<List<dynamic>> findAddresses(String? pattern) async {
    final response = await _dio
        .get('$_baseUrl/address/find', queryParameters: {'pattern': pattern});

    return response.data;
  }

  Future<List<dynamic>> getChargers(String addressId) async {
    final response = await _dio
        .get('$_baseUrl/charger/address', queryParameters: {'addressId': addressId});

    return response.data;
  }
}
