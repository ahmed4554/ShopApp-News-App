

import '../../../models/Shop_app_model/shopAppModel.dart';

abstract class ShopAppStates {}

class ShopAppInitialState extends ShopAppStates {}

class LoadingLoginState extends ShopAppStates {}

class LoginSucces extends ShopAppStates {
  final ShopAppModel? loginModel;
  LoginSucces(this.loginModel);
}

class LoginFailed extends ShopAppStates 
{
  final ShopAppModel? loginModel;
  LoginFailed(this.loginModel);
}

class ChangeMode extends ShopAppStates {}


class ChangeMessageContent extends ShopAppStates {}


class LoadingGetUserDataState extends ShopAppStates {}

class GetUserDataSucces extends ShopAppStates {
  final ShopAppModel? loginModel;
  GetUserDataSucces(this.loginModel);
}

class GetUserDataFailed extends ShopAppStates 
{
  final ShopAppModel? loginModel;
  GetUserDataFailed(this.loginModel);
}

class UpdateUserLoading extends ShopAppStates {}

class UpdateUserSuccess extends ShopAppStates {
  ShopAppModel userData;
  UpdateUserSuccess(this.userData);
}

class UpdateUserFailed extends ShopAppStates {}
