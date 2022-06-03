import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app_news_app/network/remote/dio_helper.dart';

import '../../../../Layout/shopApp/shop_app_layout.dart';
import '../../../../constans/components.dart';
import '../../../../models/Shop_app_model/shopAppModel.dart';
import '../../../../network/end_points.dart';
import 'register_states.dart';

class RegisterCubit extends Cubit<RegisterStates> {
  RegisterCubit() : super(RegisterInitialState());
  static RegisterCubit get(context) => BlocProvider.of(context);

  var nameController = TextEditingController();
  var emailController = TextEditingController();
  var passController = TextEditingController();
  var phoneController = TextEditingController();

  ShopAppModel? registerModel;
  void registerUser(
    context, {
    required String name,
    required String email,
    required String password,
    required String phone,
  }) {
    emit(RegisterLoading());
    DioHelper.postData(url: register, data: {
      'name': name,
      'email': email,
      'password': password,
      'phone': phone
    }).then((value) {
      registerModel = ShopAppModel.init(map: value.data);
      emit(RegisterSuccess(registerModel!));
    }).catchError((e) {
      print(e.toString());
      emit(RegisterFailed());
    });
  }

  bool isSecure = true;
  IconData suffixIconFromCubit = Icons.visibility;
  void changeMode() {
    isSecure = !isSecure;
    isSecure == true
        ? suffixIconFromCubit = Icons.visibility
        : suffixIconFromCubit = Icons.visibility_off_rounded;
    emit(ChangeModeRegister());
  }
}
