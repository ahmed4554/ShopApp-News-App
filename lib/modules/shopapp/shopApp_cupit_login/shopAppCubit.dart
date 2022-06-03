import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app_news_app/constans/constans.dart';

import '../../../Layout/shopApp/shop_app_layout.dart';
import '../../../constans/components.dart';
import '../../../models/Shop_app_model/shopAppModel.dart';
import '../../../network/end_points.dart';
import '../../../network/local/shared_preference.dart';
import '../../../network/remote/dio_helper.dart';
import 'shopAppStates.dart';

class ShopAppCubit extends Cubit<ShopAppStates> {
  ShopAppCubit() : super(ShopAppInitialState());
  static ShopAppCubit get(context) => BlocProvider.of(context);
  bool isSecure = true;
  IconData suffixIconFromCubit = Icons.visibility;
  ShopAppModel? loginModel;
  void changeMode() {
    isSecure = !isSecure;
    isSecure == true
        ? suffixIconFromCubit = Icons.visibility
        : suffixIconFromCubit = Icons.visibility_off_rounded;
    emit(ChangeMode());
  }

  void loginUser(context, {required String email, required password}) {
    emit(LoadingLoginState());
    DioHelper.postData(
      url: login,
      data: {
        'email': email,
        'password': password,
      },
    ).then((value) {
      loginModel = ShopAppModel.init(map: value.data);
      token = loginModel!.data!.token;
      print(value.data);
      emit(LoginSucces(loginModel));
    }).catchError((error) {
      print(error);
      emit(LoginSucces(loginModel));
    });
  }

  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneController = TextEditingController();

  ShopAppModel? userData;
  void getUserData() {
    emit(LoadingGetUserDataState());
    DioHelper.getData(url: profile, token: token).then((value) {
      print(value.data);
      userData = ShopAppModel.init(map: value.data);
      nameController.text = userData!.data!.name;
      emailController.text = userData!.data!.email;
      phoneController.text = userData!.data!.phone;
      emit(GetUserDataSucces(userData));
    }).catchError((e) {
      print(e.toString());
      emit(GetUserDataFailed(userData));
    });
  }

  void upadateUser({
    required String name,
    required String email,
    required String phone,
    required String token,
  }) {
    emit(UpdateUserLoading());
    DioHelper.putData(
        url: update_profile,
        token: token,
        data: {'name': name, 'email': email, 'phone': phone}).then((value) {
      userData = ShopAppModel.init(map: value.data);
      SharedHelper.setData(key: 'token', value: userData!.data!.token)
          .then((value) {
        print('$value from register button');
      });
      emit(UpdateUserSuccess(userData!));
    }).catchError((e) {
      print(e);
      emit(UpdateUserFailed());
    });
  }
}
