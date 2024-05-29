abstract class SearchState {}

class SearchinitialState extends SearchState {}

class SearchlodingState extends SearchState {}

class SearchSuccessState extends SearchState {
//  final ShopLoginData loginModel;

//  SearchSuccessState(this.loginModel);
}

class SearchErrorState extends SearchState {
  final String error;

  SearchErrorState(this.error);
}

//class ShownoShowIconState extends SearchState {}
