import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';

import '../../../constans/components.dart';
import '../../../models/shopAppCategoriesData/categoriesData.dart';
import '../../../models/shopAppDataModel/shopAppDataModel.dart';
import '../../../models/shopAppFavoritesModel/shop_app_get_fav_model.dart';
import '../cubit/shopAppCubitData.dart';
import '../cubit/states.dart';

class ProductsScreen extends StatelessWidget {
  const ProductsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Widget categoryItemBuilder(DataModelOfOneCategories model) {
      return Container(
        clipBehavior: Clip.antiAliasWithSaveLayer,
        decoration: BoxDecoration(
          border: Border.all(
            color: Colors.deepOrange,
          ),
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: Stack(
          alignment: AlignmentDirectional.bottomCenter,
          children: [
            Container(
              clipBehavior: Clip.antiAliasWithSaveLayer,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: Image(
                fit: BoxFit.cover,
                image: NetworkImage(model.image.toString()),
                width: 100.0,
                height: 100.0,
              ),
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 10.0),
              color: Colors.deepOrange.withOpacity(0.6),
              width: 100.0,
              child: Text(
                model.name.toString(),
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            )
          ],
        ),
      );
    }

    Widget itemBuilder(ProductsDataModel? model, CategoriesModel? model2) {
      return SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10.0),
          child: Column(
            children: [
              CarouselSlider(
                items: model!.data!.banners.map((element) {
                  return CachedNetworkImage(
                    imageUrl: "${element.image}",
                    imageBuilder: (context, imageProvider) => Container(
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: imageProvider,
                          fit: BoxFit.fill,
                        ),
                      ),
                    ),
                    errorWidget: (context, url, error) => Icon(Icons.error),
                  );
                }).toList(),
                options: CarouselOptions(
                  autoPlay: true,
                  autoPlayAnimationDuration: Duration(seconds: 1),
                  autoPlayCurve: Curves.fastLinearToSlowEaseIn,
                  autoPlayInterval: Duration(seconds: 5),
                  enableInfiniteScroll: true,
                  height: 250.0,
                  initialPage: 0,
                  reverse: false,
                  scrollDirection: Axis.horizontal,
                  viewportFraction: 1.0,
                ),
              ),
              SizedBox(
                height: 15.0,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    clipBehavior: Clip.antiAliasWithSaveLayer,
                    padding: EdgeInsets.fromLTRB(10, 5, 10, 5),
                    decoration: BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                            color: Colors.red,
                            blurRadius: 10.0,
                            spreadRadius: 1,
                            offset: Offset(0, 0))
                      ],
                      color: Colors.deepOrange,
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    child: Text(
                      'Categories',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 10.0,
                  ),
                  Container(
                    height: 120.0,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10.0),
                      child: ListView.separated(
                        physics: BouncingScrollPhysics(),
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (context, index) =>
                            categoryItemBuilder(model2!.data!.data[index]),
                        separatorBuilder: (context, index) => SizedBox(
                          width: 10.0,
                        ),
                        itemCount: model2!.data!.data.length,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 10.0,
                  ),
                  Container(
                    clipBehavior: Clip.antiAliasWithSaveLayer,
                    padding: EdgeInsets.fromLTRB(10, 5, 10, 5),
                    decoration: BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                            color: Colors.red,
                            blurRadius: 10.0,
                            spreadRadius: 1,
                            offset: Offset(0, 0))
                      ],
                      color: Colors.deepOrange,
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    child: Text(
                      'New Products',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 15.0,
              ),
              GridView.count(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
                childAspectRatio: 1 / 1.7,
                crossAxisCount: 2,
                children: List.generate(
                  model.data!.products.length,
                  (index) => itemProductBuild(
                      model: model.data!.products[index],
                      index: index,
                      context: context),
                ),
              ),
            ],
          ),
        ),
      );
    }

    return BlocConsumer<ShopAppCubitData, ShopAppDataStates>(
      listener: (context, state) {
        if (state is ShopAppFavouritesSuccessState) {
          if (state.favProdectModel.statue) {
            ScaffoldMessenger.of(context).showSnackBar(snackbar(
                massage: state.favProdectModel.message!, color: Colors.green));
          } else {
            ScaffoldMessenger.of(context).showSnackBar(snackbar(
                massage: state.favProdectModel.message!, color: Colors.red));
          }
        }
      },
      builder: (context, state) {
        ShopAppCubitData c = ShopAppCubitData.get(context);
        return Scaffold(
          body: c.datamodel == null ||
                  c.categoriesDataModel == null ||
                  c.favItemsModel == null
              ? Center(child: Lottie.asset('images/lottie.json'))
              : itemBuilder(c.datamodel, c.categoriesDataModel),
        );
      },
    );
  }
}
