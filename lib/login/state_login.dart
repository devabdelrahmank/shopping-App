import 'package:shopping_app/Models/user_model.dart';

abstract class logingState {}

class loginginitialState extends logingState {}

class loginlodingState extends logingState {}

class loginSuccessState extends logingState {
  final ShopLoginData loginModel;

  loginSuccessState(this.loginModel);
}

class LoginErrorState extends logingState {
  final String error;

  LoginErrorState(this.error);
}

class ShownoShowIconState extends logingState {}
