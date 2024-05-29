// ignore_for_file: camel_case_types

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:shopping_app/Bloc/States.dart';
import 'package:shopping_app/Bloc/cubit.dart';
import 'package:shopping_app/Search/Search_page.dart';
import 'package:shopping_app/Shared/components.dart';

class Layout_Screen extends StatelessWidget {
  const Layout_Screen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ShoppCubit(),
      child: BlocConsumer<ShoppCubit, ShopState>(
        listener: (context, state) {},
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(
              elevation: 0,
              title: defultText(
                  text: 'Elemam', size: 25, color: HexColor("#C93D3E")),
              actions: [
                IconButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (ctx) => const search_Screen()));
                  },
                  icon: const Icon(Icons.search),
                  iconSize: 30,
                )
              ],
            ),
            body: ShoppCubit.get(context)
                .screenWidget[ShoppCubit.get(context).currentIndex],
            bottomNavigationBar: BottomNavigationBar(
              items: const [
                BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
                BottomNavigationBarItem(
                    icon: Icon(Icons.apps), label: 'Categories'),
                BottomNavigationBarItem(
                    icon: Icon(Icons.favorite), label: 'Favorite'),
                BottomNavigationBarItem(
                    icon: Icon(Icons.settings), label: 'Settings'),
              ],
              currentIndex: ShoppCubit.get(context).currentIndex,
              onTap: (index) {
                ShoppCubit.get(context).changebottom(index);
              },
            ),
          );
        },
      ),
    );
  }
}
