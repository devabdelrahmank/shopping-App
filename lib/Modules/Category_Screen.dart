import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopping_app/Bloc/Cubit.dart';
import 'package:shopping_app/Bloc/States.dart';
import 'package:shopping_app/Models/Category_model.dart';
import 'package:shopping_app/Shared/components.dart';

class Category_Screen extends StatelessWidget {
  const Category_Screen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShoppCubit, ShopState>(
      builder: (context, state) {
        final categor = ShoppCubit.get(context).categor;
        return ListView.separated(
          physics: const BouncingScrollPhysics(),
          itemBuilder: (context, index) =>
              defulListCategory(categor!.data!.data![index]),
          separatorBuilder: (context, index) => const Padding(
            padding: EdgeInsets.only(top: 5, left: 10, right: 10, bottom: 5),
            child: Divider(
              thickness: 1,
            ),
          ),
          itemCount: ShoppCubit.get(context).categor!.data!.data!.length,
        );
      },
      listener: (context, state) {},
    );
  }

  Widget defulListCategory(CategoryData model) => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Row(
          children: [
            Image(
              image: NetworkImage('${model.image}'),
              width: 130,
              height: 100,
            ),
            const SizedBox(
              width: 20,
            ),
            defultText(
              text: '${model.name}',
              size: 20,
              color: Colors.black,
            ),
            const Spacer(),
            IconButton(
              onPressed: () {},
              icon: const Icon(
                CupertinoIcons.arrow_right,
                size: 28,
              ),
            )
          ],
        ),
      );
}
