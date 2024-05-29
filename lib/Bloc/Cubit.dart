// ignore_for_file: file_names, non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopping_app/Bloc/States.dart';
import 'package:shopping_app/Models/Category_model.dart';
import 'package:shopping_app/Models/FavoritesModel.dart';
import 'package:shopping_app/Models/Home_data.dart';
import 'package:shopping_app/Models/Profile_model.dart';
import 'package:shopping_app/Models/favorite_model_get.dart';
import 'package:shopping_app/Modules/Category_Screen.dart';
import 'package:shopping_app/Modules/Favourite_screen.dart';
import 'package:shopping_app/Modules/Setting_screen.dart';
import 'package:shopping_app/Modules/products_screen.dart';
import 'package:shopping_app/Network/dio_helper.dart';
import 'package:shopping_app/Shared/endpoint.dart';
import 'package:dio/dio.dart';

class ShoppCubit extends Cubit<ShopState> {
  ShoppCubit() : super(ShopenitialState());
  static ShoppCubit get(context) => BlocProvider.of(context);

  int currentIndex = 0;

  List<Widget> screenWidget = [
    const product_Screen(),
    const Category_Screen(),
    const favourite_Screen(),
    const Setting_Screen(),
  ];

  void changebottom(int index) {
    currentIndex = index;
    emit(ShopNavigationBar());
  }

  ModelData? model;
  Map<int, bool>? favorites = {};

  void GetHomeData() {
    emit(ShopLoadingState());
    Dio_helper.Getdata(
      url: HOME,
      token: TOKEN,
    ).then((value) {
      model = ModelData.fromJson(value.data);
      model!.data.products.forEach((Element) {
        favorites!.addAll({
          Element.id: Element.inFavorites,
        });
      });
      //  print(favorites.toString());
      emit(ShopSuccesState());
    }).catchError((Error) {
      //  print('====home======');
      //  print(Error.toString());
      //    print('==========');

      emit(ShopErrorState());
    });
  }

  CategoryModel? categor;

  void GetCategoryData() {
    emit(ShopLoadingState());
    Dio_helper.Getdata(
      url: 'categories',
      token: TOKEN,
    ).then((value) {
      categor = CategoryModel.fromJson(value.data);

      emit(ShopSuccesCategoriesState());
    }).catchError((Error) {
      //    print('====categories======');
      //  print(Error.toString());
      //  print('==========');
      emit(ShopErrorCategoriesState());
    });
  }

  ChangeFavoriteModel? changeFavoriteModel;
  void ChangeFavorite(int ProductId) {
    favorites![ProductId] = !favorites![ProductId]!;
    emit(ShopChangeFavState());
    Dio_helper.Postdata(
      url: Favorite,
      token: TOKEN,
      data: {
        'product_id': ProductId,
      },
    ).then((value) {
      changeFavoriteModel = ChangeFavoriteModel.fromJson(value.data);
    //  print(value.data);
      if (!changeFavoriteModel!.status) {
        favorites![ProductId] = !favorites![ProductId]!;
      } else {
        GetFavorite();
      }
      emit(ShopSuccesChangeFavState(changeFavoriteModel!));
    }).catchError((Error) {
      //  print('====change favourites======');
      //  print(Error.toString());
      //  print('==========');
      emit(ShopErrorChangeFavState());
    });
  }

  favoriteModel? favoritesModel;

  void GetFavorite() {
    emit(ShopSLoadingGetFavoriteState());
    Dio_helper.Getdata(
      url: Favorite,
      token: TOKEN,
    ).then((value) {
      favoritesModel = favoriteModel.fromJson(value.data);
      //  print(value.data.toString());

      emit(ShopSuccesGetFavoriteState());
    }).catchError((Error) {
      //  print('====fav======');
      //  print(Error.toString());
      //  print('==========');
      emit(ShopErrorGetFavoriteState());
    });
  }

  profileModel? ProfileUserModel;

  void GetProfileData() {
    emit(ShopLoadingProfileState());
    Dio_helper.Getdata(
      url: Profile,
      token: TOKEN,
    ).then((value) {
      ProfileUserModel = profileModel.fromJson(value.data);
      //  print(value.data[0]);

      //  print(ProfileUserModel!.data!.email.toString());
      //  print(ProfileUserModel!.data!.name.toString());
      //  print(ProfileUserModel!.data!.phone.toString());

      emit(ShopSuccesProfileState());
    }).catchError((error) {
      if (error is DioException) {
        print(error.response);
      }
      //  print('====profile======');
      // print(error.toString());
      // print('==========');
      emit(ShopErrorProfileState());
    });
  }
}
