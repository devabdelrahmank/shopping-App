import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:shopping_app/Network/Cache_helper.dart';
import 'package:shopping_app/Register/register_page.dart';
import 'package:shopping_app/Shared/components.dart';
import 'package:shopping_app/Shared/endpoint.dart';
import 'package:shopping_app/layout/Layout_Screen.dart';
import 'package:shopping_app/login/cubit_login.dart';
import 'package:shopping_app/login/state_login.dart';

class login_page extends StatelessWidget {
  const login_page({super.key});

  @override
  Widget build(BuildContext context) {
    var email = TextEditingController();
    var password = TextEditingController();
    var formkey = GlobalKey<FormState>();
    return BlocProvider(
      create: (context) => loginCubit(),
      child: BlocConsumer<loginCubit, logingState>(
        listener: (context, state) {
          if (state is loginSuccessState) {
            if (state.loginModel.status) {
              print(state.loginModel.message);
              print(state.loginModel.data.token);
              cache_helper()
                  .SaveData(key: 'tokenn', value: state.loginModel.data.token)
                  .then((value) {
                TOKEN = state.loginModel.data.token;
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (ctx) => const Layout_Screen(),
                  ),
                );
              });
              ToastMessage(
                  state: ToastStates.SUCCESS, text: state.loginModel.message);
            } else {
              print(state.loginModel.message);
              ToastMessage(
                  state: ToastStates.ERROR, text: state.loginModel.message);
            }
          }
          if (state is LoginErrorState) {
            ToastMessage(
                state: ToastStates.ERROR, text: state.error.toString());
          }
        },
        builder: (context, state) {
          return Scaffold(
            body: Center(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Form(
                    key: formkey,
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(
                            height: 20,
                          ),
                          defultText(
                            text: 'LOGIN',
                            size: 40,
                            color: HexColor("#C93D3E"),
                          ),
                          defultText(
                              text: 'Login Now to browse our hot offers',
                              size: 19,
                              color: HexColor('#878C8D')),
                          const SizedBox(
                            height: 40,
                          ),
                          defultTextFromFiled(
                            controller: email,
                            valeditor: (value) {
                              if (value!.isEmpty) {
                                return 'enter your Email';
                              }
                              return null;
                            },
                            type: TextInputType.emailAddress,
                            text: 'Email',
                            iconDataPrifix: Icons.email_outlined,
                            //    controller: email,
                          ),
                          const SizedBox(
                            height: 15,
                          ),
                          defultTextFromFiled(
                            controller: password,
                            valeditor: (value) {
                              if (value!.isEmpty) {
                                return 'enter your password';
                              }
                              return null;
                            },
                            // onTap: () {
                            //   if (fromKey.currentState!.validate()) {
                            //     ShoppingCubit.get(context).userLOGIN(
                            //         email: email.text, password: password.text);
                            //   }
                            // },
                            obscureText: loginCubit.get(context).isShow,
                            text: 'passowrd',
                            type: TextInputType.visiblePassword,
                            iconDataPrifix: Icons.lock_outline,
                            iconDataSuffix: loginCubit.get(context).icon,
                            onPressedSufexicon: () {
                              loginCubit.get(context).shownoShow();
                            },
                          ),
                          const SizedBox(
                            height: 25,
                          ),
                          ConditionalBuilder(
                            condition: State is! loginlodingState,
                            builder: (context) => defultButton(
                                text: 'LOGIN',
                                color: HexColor("#C93D3E"),
                                onPressed: () {
                                  if (formkey.currentState!.validate()) {
                                    loginCubit.get(context).userLOGIN(
                                          email: email.text,
                                          password: password.text,
                                        );
                                  }
                                }),
                            fallback: (context) =>
                                Center(child: CircularProgressIndicator()),
                          ),
                          const SizedBox(
                            height: 25,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              defultText(
                                  text: 'Don\'t have an account?  ',
                                  size: 18,
                                  color: HexColor('#878C8D')),
                              InkWell(
                                onTap: () {
                                  Navigator.pushReplacement(
                                      context,
                                      MaterialPageRoute(
                                          builder: (ctx) => Register_page()));
                                },
                                child: defultText(
                                    text: 'REGISTER',
                                    size: 17,
                                    color: HexColor("#C93D3E")),
                              ),
                            ],
                          ),
                        ]),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
