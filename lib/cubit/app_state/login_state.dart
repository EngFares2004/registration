
import 'package:flutter/material.dart';

@immutable
abstract class LoginState {}

class LoginInitial extends LoginState {}

class LoginLoading extends LoginState {}

class LoginSuccess extends LoginState {}

class LoginError extends LoginState {
  final String message;
  LoginError(this.message);
}
