import 'package:shopping_app/Models/user_model.dart';

abstract class RegesterState {}

class RegesterginitialState extends RegesterState {}

class RegesterlodingState extends RegesterState {}

class RegesterSuccessState extends RegesterState {
  final ShopLoginData loginModel;

  RegesterSuccessState(this.loginModel);
}

class RegesterErrorState extends RegesterState {
  final String error;

  RegesterErrorState(this.error);
}

class ShownoShowIconState extends RegesterState {}
