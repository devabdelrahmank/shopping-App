// ignore_for_file: camel_case_types, file_names

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:shopping_app/Bloc/States.dart';
import 'package:shopping_app/Bloc/cubit.dart';
import 'package:shopping_app/Network/Cache_helper.dart';
import 'package:shopping_app/Shared/components.dart';
import 'package:shopping_app/login/login_page.dart';

class Setting_Screen extends StatelessWidget {
  const Setting_Screen({super.key});

  @override
  Widget build(BuildContext context) {
    var name = TextEditingController();
    var emailAdress = TextEditingController();
    var phone = TextEditingController();
    return BlocProvider(
      create: (context) => ShoppCubit()..GetProfileData(),
      child: BlocConsumer<ShoppCubit, ShopState>(
        listener: (context, state) {},
        builder: (context, state) {
        

          return Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              children: [
                if (ShoppCubit.get(context).ProfileUserModel != null)
                  defultTextFromFiled(
                    text: 'Name',
                    controller: name,
                    valeditor: (value) {
                      if (value!.isEmpty) {
                        return 'Enter Your Name';
                      }
                      return null;
                    },
                    iconDataPrifix: Icons.person,
                  ),
                const SizedBox(
                  height: 20,
                ),
                defultTextFromFiled(
                  text: 'Email Address',
                  controller: emailAdress,
                  valeditor: (value) {
                    if (value!.isEmpty) {
                      return 'Enter Your Email Address';
                    }
                    return null;
                  },
                  iconDataPrifix: Icons.email,
                ),
                const SizedBox(
                  height: 20,
                ),
                defultTextFromFiled(
                  text: 'Phone',
                  controller: phone,
                  valeditor: (value) {
                    if (value!.isEmpty) {
                      return 'Enter Your Phone';
                    }
                    return null;
                  },
                  iconDataPrifix: Icons.phone,
                ),
                const SizedBox(
                  height: 40,
                ),
                defultButton(
                  text: 'Logout',
                  color: HexColor("#C93D3E"),
                  onPressed: () {
                    cache_helper().RemoveData(key: 'tokenn').then(
                      (value) {
                        if (value) {
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (ctx) => const login_page(),
                            ),
                          );
                        }
                      },
                    );
                  },
                )
              ],
            ),
          );
        },
      ),
    );
  }
}


  if (ShoppCubit.get(context).ProfileUserModel != null) {
            name.text = ShoppCubit.get(context).ProfileUserModel!.data!.name!;
            emailAdress.text =
                ShoppCubit.get(context).ProfileUserModel!.data!.email!;
            phone.text = ShoppCubit.get(context).ProfileUserModel!.data!.phone!;
          }