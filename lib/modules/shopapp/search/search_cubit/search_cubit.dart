import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app_news_app/modules/shopapp/search/search_cubit/states.dart';
import 'package:shop_app_news_app/network/end_points.dart';
import 'package:shop_app_news_app/network/remote/dio_helper.dart';
import '../../../../models/shopAppFavoritesModel/shop_app_get_fav_model.dart';
import '../../../../models/shop_app_search_model/search_model.dart';

class SearchCubit extends Cubit<SearchStates> {
  SearchCubit() : super(SearchInitial());
  static SearchCubit get(context) => BlocProvider.of(context);

  var searchController = TextEditingController();

  SearchModel? model;

  void searching({required String text}) {
    emit(SearchLoading());
    DioHelper.postData(url: search, data: {'text': text}).then((value) {
      model = SearchModel.fromJson(value.data);
      emit(SearchSuccess());
    }).catchError((e) {
      print(e);
      emit(SearchFailed());
    });
  }
}
