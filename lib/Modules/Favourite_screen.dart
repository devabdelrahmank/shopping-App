import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:shopping_app/Bloc/Cubit.dart';
import 'package:shopping_app/Bloc/States.dart';
import 'package:shopping_app/Models/favorite_model_get.dart';
import 'package:shopping_app/Shared/components.dart';

class favourite_Screen extends StatelessWidget {
  const favourite_Screen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShoppCubit, ShopState>(
      listener: (context, state) {},
      builder: (context, state) {
        return ConditionalBuilder(
          condition:
              ShoppCubit.get(context).favoritesModel!.data!.data!.isNotEmpty,
          builder: (context) => ListView.separated(
            itemBuilder: (context, index) => ArchBuild(
                ShoppCubit.get(context).favoritesModel!.data!.data![index],
                context),
            separatorBuilder: (context, index) => const Padding(
              padding: EdgeInsets.only(top: 5, left: 20, right: 20, bottom: 5),
              child: Divider(
                thickness: 1,
              ),
            ),
            itemCount:
                ShoppCubit.get(context).favoritesModel!.data!.data!.length,
            physics: const BouncingScrollPhysics(),
          ),
          fallback: (context) => Center(
            child: Image.network(
              'https://cdn.dribbble.com/users/12570/screenshots/13987694/media/1635918fab6854e489723a301619b7b2.jpg',
            ),
          ),
        );
      },
    );
  }

  Widget ArchBuild(FavoriteData model, context) => Padding(
        padding: const EdgeInsets.all(20),
        child: SizedBox(
          width: double.infinity,
          height: 120,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Stack(
                alignment: AlignmentDirectional.bottomStart,
                children: [
                  Image(
                    image: NetworkImage(
                      '${model.product!.image}',
                    ),
                    height: 120,
                    width: 120,
                  ),
                  if (model.product!.discount != 0)
                    Container(
                      color: Colors.red,
                      width: 70,
                      height: 20,
                      child: Center(
                        child: defultText(
                          text: 'Discount',
                          size: 11,
                          color: Colors.white,
                        ),
                      ),
                    ),
                ],
              ),
              const SizedBox(
                width: 20,
              ),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Text(
                      model.product!.name.toString(),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        defultText(
                            text: model.product!.price.toString(),
                            size: 15,
                            color: HexColor("#C93D3E")),
                        const SizedBox(
                          width: 10,
                        ),
                        if (model.product!.discount != 0)
                          Text(
                            model.product!.oldPrice.toString(),
                            style: const TextStyle(
                              decoration: TextDecoration.lineThrough,
                              fontWeight: FontWeight.w300,
                            ),
                          ),
                        const Spacer(),
                        IconButton(
                            onPressed: () {
                              ShoppCubit.get(context)
                                  .ChangeFavorite(model.product!.id!);
                              print(model.id!);
                            },
                            icon: CircleAvatar(
                              radius: 15,
                              backgroundColor: ShoppCubit.get(context)
                                          .favorites![model.product!.id] ??
                                      (ShoppCubit.get(context).favorites !=
                                          null)
                                  ? HexColor("#C93D3E")
                                  : Colors.grey,
                              child: const Icon(
                                Icons.favorite,
                                size: 18,
                                color: Colors.white,
                              ),
                            ),),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      );
}
