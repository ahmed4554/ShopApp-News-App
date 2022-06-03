// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app_news_app/constans/constans.dart';

import '../../../constans/components.dart';
import '../../../models/shopAppFavoritesModel/shop_app_get_fav_model.dart';
import '../cubit/shopAppCubitData.dart';
import '../cubit/states.dart';

class Favorite extends StatelessWidget {
  const Favorite({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopAppCubitData, ShopAppDataStates>(
      listener: (context, state) {},
      builder: (context, state) => Padding(
        padding: const EdgeInsets.all(20.0),
        child: ListView.separated(
            itemBuilder: ((context, index) => buildFavItem(
                model:ShopAppCubitData.get(context)
                    .favItemsModel!
                    .data!
                    .data[index]
                    .product,
                context:context)),
            separatorBuilder: (context, index) => SizedBox(
                  height: 15,
                ),
            itemCount:
                ShopAppCubitData.get(context).favItemsModel!.data!.data.length),
      ),
    );
  }
}
