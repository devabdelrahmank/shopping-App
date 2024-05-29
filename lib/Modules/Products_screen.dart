import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:shopping_app/Bloc/Cubit.dart';
import 'package:shopping_app/Bloc/States.dart';
import 'package:shopping_app/Models/Category_model.dart';
import 'package:shopping_app/Shared/components.dart';

// ignore: camel_case_types
class product_Screen extends StatelessWidget {
  const product_Screen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShoppCubit, ShopState>(
      listener: (context, state) {
        if (state is ShopSuccesChangeFavState) {
          if (state.changeFavoriteModel.status) {
            ToastMessage(
                state: ToastStates.SUCCESS,
                text: state.changeFavoriteModel.message.toString());
          }
        }
      },
      builder: (context, state) {
        final model = ShoppCubit.get(context).model;
        final categor = ShoppCubit.get(context).categor;
        final favorite = ShoppCubit.get(context).favorites;

        if (model != null) {
          return SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CarouselSlider(
                  items: model.data.banners
                      .map(
                        (e) => Image(
                          image: NetworkImage(e.image),
                          width: double.infinity,
                          fit: BoxFit.cover,
                        ),
                      )
                      .toList(),
                  options: CarouselOptions(
                    height: 250.0,
                    initialPage: 0,
                    viewportFraction: 1,
                    enableInfiniteScroll: true,
                    reverse: false,
                    autoPlay: true,
                    autoPlayInterval: const Duration(seconds: 3),
                    autoPlayAnimationDuration: const Duration(seconds: 1),
                    autoPlayCurve: Curves.fastOutSlowIn,
                    scrollDirection: Axis.horizontal,
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      defultText(
                          text: 'Categories',
                          size: 28,
                          color: HexColor("#C93D3E")),
                      SizedBox(
                        height: 100,
                        child: ListView.separated(
                          physics: const BouncingScrollPhysics(),
                          scrollDirection: Axis.horizontal,
                          itemBuilder: (context, index) =>
                              CategoryItem(categor.data!.data![index]),
                          itemCount: categor!.data!.data!.length,
                          separatorBuilder: (context, index) => const SizedBox(
                            width: 5,
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      defultText(
                          text: 'New Products',
                          size: 28,
                          color: HexColor("#C93D3E")),
                    ],
                  ),
                ),
                Container(
                  color: Colors.grey[300],
                  child: GridView.count(
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    childAspectRatio: 0.55,
                    crossAxisCount: 2,
                    crossAxisSpacing: 1,
                    mainAxisSpacing: 1,
                    children: List.generate(
                      model.data.products.length,
                      (index) => Container(
                        color: Colors.white,
                        child: Column(
                          children: [
                            Stack(
                              alignment: AlignmentDirectional.bottomStart,
                              children: [
                                Image(
                                  image: NetworkImage(
                                    model.data.products[index].image,
                                  ),
                                  height: 250,
                                  width: double.infinity,
                                ),
                                if (model.data.products[index].discount != 0)
                                  Container(
                                    color: Colors.red,
                                    width: 70,
                                    height: 20,
                                    child: Center(
                                      child: defultText(
                                          text: 'Discount',
                                          size: 11,
                                          color: Colors.white),
                                    ),
                                  ),
                              ],
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            Padding(
                              padding: const EdgeInsets.all(10),
                              child: Column(
                                children: [
                                  Text(
                                    model.data.products[index].name,
                                    maxLines: 1,
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
                                          text:
                                              "${model.data.products[index].price}",
                                          size: 15,
                                          color: HexColor("#C93D3E")),
                                      const SizedBox(
                                        width: 10,
                                      ),
                                      if (model.data.products[index].discount !=
                                          0)
                                        Text(
                                          model.data.products[index].oldPrice
                                              .toString(),
                                          style: const TextStyle(
                                            decoration:
                                                TextDecoration.lineThrough,
                                            fontWeight: FontWeight.w300,
                                          ),
                                        ),
                                      const Spacer(),
                                      IconButton(
                                          onPressed: () {
                                            ShoppCubit.get(context)
                                                .ChangeFavorite(model
                                                    .data.products[index].id);
                                            print(
                                                model.data.products[index].id);
                                          },
                                          icon: CircleAvatar(
                                            radius: 15,
                                            backgroundColor:
                                                ShoppCubit.get(context)
                                                                .favorites![
                                                            model
                                                                .data
                                                                .products[index]
                                                                .id] ??
                                                        (favorite != null)
                                                    ? HexColor("#C93D3E")
                                                    : Colors.grey,
                                            child: const Icon(
                                              Icons.favorite,
                                              size: 18,
                                              color: Colors.white,
                                            ),
                                          ))
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
        } else {
          return const Center(child: CircularProgressIndicator());
        }
      },
    );
  }

  Widget CategoryItem(CategoryData data) {
    return Stack(
      alignment: AlignmentDirectional.bottomCenter,
      children: [
        Image(
          image: NetworkImage('${data.image}'),
          width: 110,
          height: 110,
        ),
        Container(
          width: 100,
          height: 25,
          color: const Color.fromARGB(190, 0, 0, 0),
          child: Center(
            child: Text(
              '${data.name}',
              maxLines: 1,
              textAlign: TextAlign.center,
              style: const TextStyle(color: Colors.white),
            ),
          ),
        ),
      ],
    );
  }
}
