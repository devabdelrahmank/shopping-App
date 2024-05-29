import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:shopping_app/Network/Cache_helper.dart';
import 'package:shopping_app/Register/cubit_register.dart';
import 'package:shopping_app/Register/states_regester.dart';
import 'package:shopping_app/Shared/components.dart';
import 'package:shopping_app/Shared/endpoint.dart';
import 'package:shopping_app/layout/Layout_Screen.dart';
import 'package:shopping_app/login/login_page.dart';

class Register_page extends StatelessWidget {
  const Register_page({super.key});

  @override
  Widget build(BuildContext context) {
    var email = TextEditingController();
    var password = TextEditingController();
    var phone = TextEditingController();
    var name = TextEditingController();
    var formkey = GlobalKey<FormState>();
    return BlocProvider(
      create: (context) => RegisterCubit(),
      child: BlocConsumer<RegisterCubit, RegesterState>(
        listener: (context, state) {
          if (state is RegesterSuccessState) {
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
          if (state is RegesterErrorState) {
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
                            text: 'REGISTER',
                            size: 40,
                            color: HexColor("#C93D3E"),
                          ),
                          defultText(
                              text: 'register Now to browse our hot offers',
                              size: 19,
                              color: HexColor('#878C8D')),
                          const SizedBox(
                            height: 40,
                          ),
                          defultTextFromFiled(
                            controller: name,
                            valeditor: (value) {
                              if (value!.isEmpty) {
                                return 'enter your name';
                              }
                              return null;
                            },
                            type: TextInputType.text,
                            text: 'Name',
                            iconDataPrifix: Icons.person,
                            //    controller: email,
                          ),
                          const SizedBox(
                            height: 15,
                          ),
                          defultTextFromFiled(
                            controller: phone,
                            valeditor: (value) {
                              if (value!.isEmpty) {
                                return 'enter your Phone';
                              }
                              return null;
                            },
                            type: TextInputType.phone,
                            text: 'Phone',
                            iconDataPrifix: Icons.phone,
                            //    controller: email,
                          ),
                          const SizedBox(
                            height: 15,
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
                            onTap: () {
                              if (formkey.currentState!.validate()) {
                                RegisterCubit.get(context).userREGISTER(
                                  email: email.text,
                                  password: password.text,
                                  phone: phone.text,
                                  name: name.text,
                                );
                              }
                            },
                            obscureText: RegisterCubit.get(context).isShow,
                            text: 'passowrd',
                            type: TextInputType.visiblePassword,
                            iconDataPrifix: Icons.lock_outline,
                            iconDataSuffix: RegisterCubit.get(context).icon,
                            onPressedSufexicon: () {
                              RegisterCubit.get(context).shownoShow();
                            },
                          ),
                          const SizedBox(
                            height: 25,
                          ),
                          ConditionalBuilder(
                            condition: State is! RegesterlodingState,
                            builder: (context) => defultButton(
                                text: 'REGISTER',
                                color: HexColor("#C93D3E"),
                                onPressed: () {
                                  if (formkey.currentState!.validate()) {
                                    RegisterCubit.get(context).userREGISTER(
                                      email: email.text,
                                      password: password.text,
                                      phone: phone.text,
                                      name: name.text,
                                    );
                                  }
                                }),
                            fallback: (context) => const Center(
                                child: CircularProgressIndicator()),
                          ),
                          const SizedBox(
                            height: 25,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              defultText(
                                  text: 'You have account?  ',
                                  size: 18,
                                  color: HexColor('#878C8D')),
                              InkWell(
                                onTap: () {
                                  Navigator.pushReplacement(
                                      context,
                                      MaterialPageRoute(
                                          builder: (ctx) => login_page()));
                                },
                                child: defultText(
                                    text: 'LOGIN',
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
