import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopping_app/Models/user_model.dart';
import 'package:shopping_app/Network/dio_helper.dart';
import 'package:shopping_app/Register/states_regester.dart';
import 'package:shopping_app/Shared/endpoint.dart';

class RegisterCubit extends Cubit<RegesterState> {
  RegisterCubit() : super(RegesterginitialState());
  static RegisterCubit get(context) => BlocProvider.of(context);

  late ShopLoginData LoginData;

  void userREGISTER({
    required String email,
    required String password,
    required String phone,
    required String name,
  }) {
    //  emit(RegesterlodingState());
    Dio_helper.Postdata(url: REGISTER, data: {
      'email': email,
      'password': password,
      'name': name,
      'phone': phone,
    }).then((value) {
      emit(RegesterlodingState());

      LoginData = ShopLoginData.fromJson(value.data);
      print(value.data);

      emit(RegesterSuccessState(LoginData));
    }).catchError((Error) {
      emit(RegesterErrorState(Error.toString()));
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
