import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'Layout/new_app_layout.dart';
import 'Layout/shopApp/shop_app_layout.dart';
import 'constans/components.dart';
import 'constans/constans.dart';
import 'modules/shopapp/cubit/shopAppCubitData.dart';
import 'modules/shopapp/login/login.dart';
import 'modules/shopapp/onboarding_screen/onBoardingScreen.dart';
import 'modules/shopapp/shopApp_cupit_login/shopAppCubit.dart';
import 'network/local/shared_preference.dart';
import 'network/remote/dio_helper.dart';
import 'shared/cubit/cubit.dart';
import 'shared/cubit/states.dart';
import 'shared/themes/themes.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  DioHelper.dioGet();
  await SharedHelper.init();
  bool? isDark = SharedHelper.getShared(key: 'isDark');
  bool? onBoarding = SharedHelper.getShared(key: 'onboarding');
  token = SharedHelper.getShared(key: 'token');
  Widget? widget;
  print('$onBoarding from main');
  if (onBoarding != null) {
    if (token != null) {
      widget = ShopAppHome();
    } else {
      widget = LoginScreen();
    }
  } else {
    widget = OnBoardingScreen();
  }
  print("$token from main");
  BlocOverrides.runZoned(
    () {
      runApp(MyApp(
        isDark: isDark,
        widget: widget,
      ));
    },
    blocObserver: MyBlocObserver(),
  );
}

class MyApp extends StatelessWidget {
  final bool? isDark;
  final Widget? widget;

  MyApp({this.isDark, this.widget});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      // ..getBusiness()
      providers: [
        BlocProvider(create: (BuildContext context) => AppCubit()..getBusiness()),
        BlocProvider(
            create: (BuildContext context) => ShopAppCubitData()
              ..getHomeData()
              ..getCategoriesData()
              ..getFavPage()),
        BlocProvider(
            create: (BuildContext context) => ShopAppCubit()..getUserData()),
      ],
      child: BlocConsumer<AppCubit, AppCubitState>(
        listener: (context, state) {},
        builder: (context, state) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            theme: lightTheme,
            darkTheme: darkTheme,
            themeMode:
                // AppCubit.get(context).isdark ? ThemeMode.dark : ThemeMode.light,
                ThemeMode.light,
            home: const Layout(),//the vaiable => widget to display the shop app
          );
        },
      ),
    );
  }
}
