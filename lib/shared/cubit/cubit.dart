import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app_news_app/shared/cubit/states.dart';

import '../../constans/components.dart';
import '../../models/models.dart';
import '../../modules/business/business.dart';
import '../../modules/science/science.dart';
import '../../modules/shopapp/login/login.dart';
import '../../modules/sports/sports.dart';
import '../../network/local/shared_preference.dart';
import '../../network/remote/dio_helper.dart';

class AppCubit extends Cubit<AppCubitState> {
  AppCubit() : super(InitialState());

  static AppCubit get(context) => BlocProvider.of(context);
  int currentIndex = 0;
  PageController controller = PageController();
  List<Widget> screens = [
    Business(),
    Sport(),
    Science(),
  ];
  List<BottomNavigationBarItem> items = [
    BottomNavigationBarItem(icon: Icon(Icons.business), label: 'business'),
    BottomNavigationBarItem(icon: Icon(Icons.sports), label: 'sports'),
    BottomNavigationBarItem(icon: Icon(Icons.science), label: 'science'),
  ];

  Map<String, bool> isClicked = {};

  void change(index) {
    if (index == 1) {
      getSport();
    } else if (index == 2) {
      getScience();
    }
    currentIndex = index;
    emit(BottomNavBarState());
  }

  List<dynamic> buisness = [];
  List<dynamic> sport = [];
  List<dynamic> science = [];
  List<dynamic> search = [];

  void getBusiness() {
    emit(DioHelperBusinessLoading());
    buisness = [];
    DioHelper.getData(url: 'v2/top-headlines', query: {
      'country': 'eg',
      'category': 'business',
      'apiKey': '8ca455dadafb4eb5b0d0c44c52514c24'
    }).then((value) {
      // print(value.data['totalResults'].toString());
      buisness = value.data['articles'];
      buisness.forEach((e) {
        isClicked.addAll({'${e['title']}': false});
      });
      print('$isClicked from get business');
      emit(DioHelperBusinessSuccessGetData());
    }).catchError((error) {
      emit(DioHelperBusinessErrorGetData());
      print(error.toString());
    });
  }

  void getSport() {
    emit(DioHelperSportLoading());
    sport = [];
    DioHelper.getData(url: 'v2/top-headlines', query: {
      'country': 'eg',
      'category': 'sports',
      'apiKey': '8ca455dadafb4eb5b0d0c44c52514c24'
    }).then((value) {
      // print(value.data['totalResults'].toString());
      sport = value.data['articles'];
      sport.forEach((e) {
        isClicked.addAll({'${e['title']}': false});
      });
      emit(DioHelperSportSuccessGetData());
      print(sport[0]);
    }).catchError((error) {
      emit(DioHelperSportErrorGetData());
      print(error.toString());
    });
  }

  void getScience() {
    emit(DioHelperScienceLoading());
    science = [];
    DioHelper.getData(url: 'v2/top-headlines', query: {
      'country': 'eg',
      'category': 'science',
      'apiKey': '8ca455dadafb4eb5b0d0c44c52514c24'
    }).then((value) {
      // print(value.data['totalResults'].toString());
      science = value.data['articles'];
      science.forEach((e) {
        isClicked.addAll({'${e['title']}': false});
      });
      emit(DioHelperScienceSuccessGetData());
      print(science[0]);
    }).catchError((error) {
      emit(DioHelperScienceErrorGetData());
      print(error.toString());
    });
  }

  void getSearch(String value) {
    emit(DioHelperSearchLoading());
    search = [];
    DioHelper.getData(url: 'v2/top-headlines', query: {
      'q': '${value}',
      'apiKey': '8ca455dadafb4eb5b0d0c44c52514c24'
    }).then((value) {
      // print(value.data['totalResults'].toString());
      search = value.data['articles'];
      emit(DioHelperSearchSuccessGetData());
      print(search[0]);
    }).catchError((error) {
      emit(DioHelperSearchErrorGetData());
      print(error.toString());
    });
  }

  void changeIsClick(String title) {
    isClicked.update(title, (value) => true);
    emit(ChangeIsClicked());
  }

  bool onBoarding = false;

  void submit(context, {bool? onBoarding}) {
    SharedHelper.setData(key: 'onboarding', value: true).then((value) {
      emit(OnBoardingChangeState());
      print(value);
      if (value) {
        navigatetOff(context, widget: LoginScreen());
      }
    });
  }

  bool isdark = false;

  void changeMode({bool? isDarkFromCubit}) {
    if (isDarkFromCubit != null) {
      isdark = isDarkFromCubit;
    } else {
      isdark = !isdark;
      SharedHelper.setShared(key: 'isDark', value: isdark).then((value) {
        emit(ChangeThemeMode());
        print('$value from change mode method');
      });
    }
  }

  List<PageViewModel> model = [
    PageViewModel(image: 'images/pic.jpg', title: 'Page View one'),
    PageViewModel(image: 'images/pic.jpg', title: 'Page View two'),
    PageViewModel(image: 'images/pic.jpg', title: 'Page View three')
  ];
  bool isLast = false;
  void changeIndicatorBehavior(index) {
    if (index == model.length - 1) {
      isLast = true;
      emit(ChangeIsLast());
      print('last page');
      print(isLast);
    } else {
      print('not last page');
      isLast = false;
      emit(ChangeIsLast());
      print(isLast);
    }
  }
}
