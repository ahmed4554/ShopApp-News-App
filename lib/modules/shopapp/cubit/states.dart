import '../../../models/shopAppFavoritesModel/favourites_model.dart';

abstract class ShopAppDataStates {}

class ShopAppDataIntitialState extends ShopAppDataStates {}

class ShopAppDataNavState extends ShopAppDataStates {}

class ShopAppDataLoadingState extends ShopAppDataStates {}

class ShopAppDataSuccessState extends ShopAppDataStates {}

class ShopAppDataFailedState extends ShopAppDataStates {}

class ShopAppCategoriesSuccessState extends ShopAppDataStates {}

class ShopAppCategoriesFailedState extends ShopAppDataStates {}

class ShopAppFavouritesSuccessState extends ShopAppDataStates {
  FavProduct favProdectModel;
  ShopAppFavouritesSuccessState(this.favProdectModel);
}

class ShopAppFavouritesFailedState extends ShopAppDataStates {}

class ShopAppFavouritesItemsFailedState extends ShopAppDataStates {}

class ShopAppFavouritesItemsSuccessState extends ShopAppDataStates {}

class ShopAppFavouritesEditIconState extends ShopAppDataStates {}
