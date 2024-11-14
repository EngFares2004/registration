import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../service/registration_service.dart';
import 'app_state/registration_state.dart';

class RegisterCubit extends Cubit<RegisterState> {
  final RegisterService _registerService;

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController mobileController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController = TextEditingController();

  RegisterCubit(this._registerService) : super(RegisterInitial());

  void registerUser() async {
    if (!formKey.currentState!.validate()) return;

    emit(RegisterLoading());
    try {
      final response = await _registerService.registerUser(
        username: usernameController.text,
        email: emailController.text,
        mobile: mobileController.text,
        password: passwordController.text,
        passwordConfirmation: confirmPasswordController.text,
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        emit(RegisterSuccess());
      } else if (response.statusCode == 302) {
        print("Redirect detected. Status Code: ${response.statusCode}");
        print("Redirect location: ${response.headers['location']}");
        emit(RegisterFailure('Redirected to another URL'));
      } else {
        emit(RegisterFailure('Failed with status: ${response.statusCode}'));
      }
    } catch (e) {
      emit(RegisterFailure("Error during request: ${e.toString()}"));
    }
  }
}
