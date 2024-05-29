import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopping_app/Models/Search_model.dart';
import 'package:shopping_app/Network/dio_helper.dart';
import 'package:shopping_app/Search/States.dart';
import 'package:shopping_app/Shared/endpoint.dart';

class SearchCubit extends Cubit<SearchState> {
  SearchCubit() : super(SearchinitialState());
  static SearchCubit get(context) => BlocProvider.of(context);

  ProductResponse? productResponse;
  void PostSearchProduct({
    required String text,
  }) {
    emit(SearchlodingState());

    Dio_helper.Postdata(
      token: TOKEN,
      url: PRODUCT_SEARCH,
      data: {
        'text': text,
      },
    ).then((value) {
      productResponse = ProductResponse.fromJson(value.data);

      emit(SearchSuccessState());
    }).catchError((Error) {
      print('=========Search======');
      print(Error.toString());
      emit(SearchErrorState(Error.toString()));
      print('==================');
    });
  }

  // bool isShow = false;
  // IconData icon = Icons.remove_red_eye;
  // void shownoShow() {
  //   isShow = !isShow;
  //   icon = isShow ? CupertinoIcons.eye : CupertinoIcons.eye_slash_fill;
  //   emit(ShownoShowIconState());
  // }
}
