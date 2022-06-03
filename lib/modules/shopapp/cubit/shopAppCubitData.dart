import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app_news_app/models/shopAppFavoritesModel/favourites_model.dart';
import 'package:shop_app_news_app/modules/shopapp/cubit/states.dart';
import 'package:shop_app_news_app/modules/shopapp/favourite/ShopAppFavorite.dart';
import 'package:shop_app_news_app/modules/shopapp/settings/settings.dart';

import '../../../models/shopAppCategoriesData/categoriesData.dart';
import '../../../models/shopAppDataModel/shopAppDataModel.dart';
import '../../../models/shopAppFavoritesModel/shop_app_get_fav_model.dart';
import '../../../network/end_points.dart';
import '../../../network/local/shared_preference.dart';
import '../../../network/remote/dio_helper.dart';
import '../category/shopAppCategory.dart';
import '../products/products.dart';

class ShopAppCubitData extends Cubit<ShopAppDataStates> {
  ShopAppCubitData() : super(ShopAppDataIntitialState());
  static ShopAppCubitData get(context) => BlocProvider.of(context);
  List<Widget> screens = [
    const ProductsScreen(),
    const Category(),
    const Favorite(),
    Settings()
  ];
  int currentIndex = 0;
  void ChangeShopAppHomeNav(int index) {
    currentIndex = index;
    emit(ShopAppDataNavState());
  }

  var token = SharedHelper.getShared(key: 'token');

  ProductsDataModel? datamodel;
  Map<int, bool> inFav = {};
  void getHomeData() {
    emit(ShopAppDataLoadingState());
    DioHelper.getData(url: home, token: token).then((value) {
      datamodel = ProductsDataModel.fromJson(value.data);
      datamodel!.data!.products.forEach((element) {
        inFav.addAll({element.id: element.in_favorites});
      });
      print(inFav);
      emit(ShopAppDataSuccessState());
    }).catchError((error) {
      log(error.toString());
      emit(ShopAppDataFailedState());
    });
  }

  CategoriesModel? categoriesDataModel;
  void getCategoriesData() {
    DioHelper.getData(url: getGategories).then((value) {
      categoriesDataModel = CategoriesModel.fromJson(value.data);
      emit(ShopAppCategoriesSuccessState());
    }).catchError((error) {
      emit(ShopAppCategoriesFailedState());
      print(error);
    });
  }

  FavProduct? favProdectModel;
  int neededIndex = 0;
  void editFavourite(int productId, {required int index}) {
    neededIndex = index;
    changeFavIcon(index);
    DioHelper.postData(
            url: favourites, data: {"product_id": productId}, token: token)
        .then((value) {
      favProdectModel = FavProduct.fromJson(value.data);
      if (!favProdectModel!.statue) {
        changeFavIcon(index);
      }
      getFavPage();
      getHomeData();
      emit(ShopAppFavouritesSuccessState(favProdectModel!));
    }).catchError((error) {
      print(error.toString() + " from edit fav");
      emit(ShopAppFavouritesFailedState());
    });
  }

  GetFavorite? favItemsModel;
  void getFavPage() {
    DioHelper.getData(url: favourites, token: token).then((value) {
      favItemsModel = GetFavorite.fromJson(value.data);
      emit(ShopAppFavouritesItemsSuccessState());
    }).catchError((error) {
      print(error);
      emit(ShopAppFavouritesItemsFailedState());
    });
  }

  void changeFavIcon(int index) {
    datamodel!.data!.products[index].in_favorites =
        !datamodel!.data!.products[index].in_favorites;
    emit(ShopAppFavouritesEditIconState());
  }
}
