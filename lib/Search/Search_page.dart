// ignore_for_file: file_names, camel_case_types

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:shopping_app/Models/Search_model.dart';
import 'package:shopping_app/Search/States.dart';
import 'package:shopping_app/Search/cubit.dart';
import 'package:shopping_app/Shared/components.dart';

class search_Screen extends StatelessWidget {
  const search_Screen({super.key});

  @override
  Widget build(BuildContext context) {
    var formkey = GlobalKey<FormState>();
    var searchController = TextEditingController();
    return BlocProvider(
      create: (BuildContext context) => SearchCubit(),
      child: BlocConsumer<SearchCubit, SearchState>(
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(),
            body: Column(
              children: [
                if (state is SearchlodingState) const LinearProgressIndicator(),
                Padding(
                  padding: const EdgeInsets.all(20),
                  child: Form(
                    key: formkey,
                    child: defultTextFromFiled(
                      controller: searchController,
                      text: 'Search',
                      valeditor: (value) {
                        if (value!.isEmpty) {
                          return 'Search any Thing';
                        }
                        return null;
                      },
                      iconDataPrifix: Icons.search,
                      onchanged: (text) {
                        SearchCubit.get(context).PostSearchProduct(text: text!);
                        return null;
                      },
                    ),
                  ),
                ),
                if (SearchCubit.get(context).productResponse != null)
                  Expanded(
                      child: ListView.separated(
                    itemBuilder: (context, index) => defulListCategory(
                        SearchCubit.get(context).productResponse!, index),
                    separatorBuilder: (context, index) => const Padding(
                      padding: EdgeInsets.only(
                          top: 5, left: 20, right: 20, bottom: 5),
                      child: Divider(
                        thickness: 1,
                      ),
                    ),
                    itemCount: SearchCubit.get(context)
                        .productResponse!
                        .data!
                        .data
                        .length,
                  )),
              ],
            ),
          );
        },
        listener: (context, state) {},
      ),
    );
  }

  Widget defulListCategory(ProductResponse model, index) => Padding(
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
                    image: NetworkImage(model.data!.data[index].image),
                    height: 120,
                    width: 120,
                  ),
                  if (1 != 0)
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
                      model.data!.data[index].name.toString(),
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
                            text: model.data!.data[index].price.toString(),
                            size: 15,
                            color: HexColor("#C93D3E")),
                        const SizedBox(
                          width: 10,
                        ),
                        if (1 != 0)
                          Text(
                            model.data!.data[index].price.toString(),
                            style: const TextStyle(
                              decoration: TextDecoration.lineThrough,
                              fontWeight: FontWeight.w300,
                            ),
                          ),
                        const Spacer(),
                        IconButton(
                          onPressed: () {
                            // ShoppCubit.get(context)
                            //     .ChangeFavorite(model.product!.id!);
                            // print(model.id!);
                          },
                          icon: const CircleAvatar(
                            radius: 15,
                            backgroundColor:
                                // ShoppCubit.get(context)
                                //             .favorites![model.product!.id] ??
                                //         (ShoppCubit.get(context).favorites !=
                                //             null)
                                //     ? HexColor("#C93D3E")
                                Colors.grey,
                            child: Icon(
                              Icons.favorite,
                              size: 18,
                              color: Colors.white,
                            ),
                          ),
                        ),
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
