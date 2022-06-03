import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app_news_app/constans/components.dart';
import 'package:shop_app_news_app/modules/search/search_screen.dart';
import '../../modules/shopapp/cubit/shopAppCubitData.dart';
import '../../modules/shopapp/cubit/states.dart';
import '../../modules/shopapp/search/shopAppSearch.dart';

class ShopAppHome extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopAppCubitData, ShopAppDataStates>(
      listener: (context, state) {},
      builder: (context, state) {
        ShopAppCubitData c = ShopAppCubitData.get(context);
        return Scaffold(
          appBar: AppBar(
            actions: [
              IconButton(
                onPressed: () {
                  navigatetTo(context, widget: Search());
                },
                icon: Icon(Icons.search),
              ),
            ],
          ),
          body: c.screens[c.currentIndex],
          bottomNavigationBar: BottomNavigationBar(
            currentIndex: c.currentIndex,
            onTap: (index) {
              c.ChangeShopAppHomeNav(index);
            },
            items: [
              BottomNavigationBarItem(
                icon: Icon(
                  Icons.home,
                ),
                label: 'Home',
              ),
              BottomNavigationBarItem(
                icon: Icon(
                  Icons.category,
                ),
                label: 'Category',
              ),
              BottomNavigationBarItem(
                icon: Icon(
                  Icons.favorite_border,
                ),
                label: 'Favorite',
              ),
              BottomNavigationBarItem(
                icon: Icon(
                  Icons.settings,
                ),
                label: 'Settings',
              ),
            ],
          ),
        );
      },
    );
  }
}
