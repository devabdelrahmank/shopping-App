import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:shopping_app/Bloc/Cubit.dart';
import 'package:shopping_app/Bloc/States.dart';
import 'package:shopping_app/Network/Cache_helper.dart';
import 'package:shopping_app/Network/dio_helper.dart';
import 'package:shopping_app/layout/Layout_Screen.dart';
import 'package:shopping_app/login/login_page.dart';
import 'package:shopping_app/onBoarding/onbording_screen.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Dio_helper.init();
  await cache_helper().init();

  Widget widget;
  bool isonbordingVisited =
      cache_helper().getData(key: 'isonbordingVisited') ?? false;

  print(isonbordingVisited);

  var token = cache_helper().getData(key: 'tokenn');
  print(token);

//  ignore: unnecessary_null_comparison
  if (isonbordingVisited == true) {
    // ignore: unnecessary_null_comparison
    if (token != null) {
      widget = const Layout_Screen(); //لو معاك التوكن
    } else {
      widget = const login_page(); //لو مش معاك التوكن
    }
  } else {
    widget = const onBoarding_Screen();
  }

  runApp(MyApp(
    startwidget: widget,
  ));
}

class MyApp extends StatelessWidget {
  final Widget startwidget;
  MyApp({required this.startwidget});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ShoppCubit()
        ..GetHomeData()
        ..GetCategoryData()
        ..GetProfileData()
        ..GetFavorite(),
      child: BlocConsumer<ShoppCubit, ShopState>(
        builder: (context, state) {
          return MaterialApp(
            title: 'Shopping App',
            debugShowCheckedModeBanner: false,
            theme: ThemeData(
              scaffoldBackgroundColor: Colors.white,
              appBarTheme: const AppBarTheme(
                backgroundColor: Colors.white,
                elevation: 0.5,
                titleTextStyle: TextStyle(
                  fontSize: 20,
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
                iconTheme: IconThemeData(
                  color: Colors.black,
                  size: 28,
                ),
              ),
              floatingActionButtonTheme: FloatingActionButtonThemeData(
                backgroundColor: HexColor("#C93D3E"),
              ),
              bottomNavigationBarTheme: BottomNavigationBarThemeData(
                selectedItemColor: HexColor("#C93D3E"),
                type: BottomNavigationBarType.fixed,
                elevation: 20,
              ),
              elevatedButtonTheme: const ElevatedButtonThemeData(
                style: ButtonStyle(
                  iconColor: MaterialStatePropertyAll(
                    Colors.white,
                  ),
                ),
              ),
            ),
            home: startwidget,
          );
        },
        listener: (context, state) {},
      ),
    );
  }
}
