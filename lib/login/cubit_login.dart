import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopping_app/Models/user_model.dart';
import 'package:shopping_app/Network/dio_helper.dart';
import 'package:shopping_app/Shared/endpoint.dart';
import 'package:shopping_app/login/state_login.dart';

class loginCubit extends Cubit<logingState> {
  loginCubit() : super(loginginitialState());
  static loginCubit get(context) => BlocProvider.of(context);

  late ShopLoginData LoginData;

  Future<void> userLOGIN({
    required String email,
    required String password,
  }) async {
    emit(loginlodingState());

    Dio_helper.Postdata(url: LOGIN, data: {
      'email': email,
      'password': password,
    }).then((value) {
      emit(loginlodingState());

      LoginData = ShopLoginData.fromJson(value.data);
      print(value.data);

      emit(loginSuccessState(LoginData));
    }).catchError((Error) {
      emit(LoginErrorState(Error.toString()));
    });
  }

  bool isShow = false;
  IconData icon = Icons.remove_red_eye;
  void shownoShow() {
    isShow = !isShow;
    icon = isShow ? CupertinoIcons.eye : CupertinoIcons.eye_slash_fill;
    emit(ShownoShowIconState());
  }
}
