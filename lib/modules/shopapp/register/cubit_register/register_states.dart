import '../../../../models/Shop_app_model/shopAppModel.dart';

abstract class RegisterStates {}

class RegisterInitialState extends RegisterStates {}

class RegisterLoading extends RegisterStates {}

class RegisterSuccess extends RegisterStates {
  ShopAppModel registerModel;
  RegisterSuccess(this.registerModel);
}

class RegisterFailed extends RegisterStates {}

class ChangeModeRegister extends RegisterStates {}
