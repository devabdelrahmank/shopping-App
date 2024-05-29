import 'package:shopping_app/Models/FavoritesModel.dart';

abstract class ShopState {}

class ShopenitialState extends ShopState {}

class ShopNavigationBar extends ShopState {}

class ShopLoadingState extends ShopState {}

class ShopSuccesState extends ShopState {}

class ShopErrorState extends ShopState {}

class ShopSuccesCategoriesState extends ShopState {}

class ShopErrorCategoriesState extends ShopState {}

class ShopSuccesChangeFavState extends ShopState {
  final ChangeFavoriteModel changeFavoriteModel;

  ShopSuccesChangeFavState(this.changeFavoriteModel);
}

class ShopChangeFavState extends ShopState {}

class ShopErrorChangeFavState extends ShopState {}

class ShopSLoadingGetFavoriteState extends ShopState {}

class ShopSuccesGetFavoriteState extends ShopState {}

class ShopErrorGetFavoriteState extends ShopState {}

class ShopLoadingProfileState extends ShopState {}

class ShopSuccesProfileState extends ShopState {}

class ShopErrorProfileState extends ShopState {}
