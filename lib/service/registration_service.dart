import 'package:dio/dio.dart';

class RegisterService {
  final String _registerUrl = "https://coursafer.innoeg.com/api/auth/register";
  final Dio _dio = Dio(
    BaseOptions(headers: {"Accept": "application/json"}),
  );

  Future<Response> registerUser({
    required String username,
    required String email,
    required String mobile,
    required String password,
    required String passwordConfirmation,
  }) async {
    if (!_isPhoneNumberValid(mobile)) {
      throw Exception("Mobile number must be 11 digits.");
    }
    if (!_isUsernameValid(username)) {
      throw Exception("Username must be more than 3 characters.");
    }

    try {
      final response = await _dio.post(
        _registerUrl,
        data: {
          "username": username,
          "email": email,
          "mobile": mobile,
          "password": password,
          "password_confirmation": passwordConfirmation,
        },
      );

      if (response.statusCode == 422) {
        print('Validation failed: ${response.data}');
        throw Exception('Validation failed: ${response.data}');
      }

      return response;
    } catch (e) {
      print("Error during request: ${e.toString()}");
      throw Exception("Error during request: ${e.toString()}");
    }
  }

  bool _isPhoneNumberValid(String mobile) {
    return mobile.length == 11 && int.tryParse(mobile) != null;
  }

  bool _isUsernameValid(String username) {
    return username.length > 3;
  }
}
