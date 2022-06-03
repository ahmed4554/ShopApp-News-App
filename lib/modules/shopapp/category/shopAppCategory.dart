import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../constans/constans.dart';
import '../../../models/shopAppCategoriesData/categoriesData.dart';
import '../cubit/shopAppCubitData.dart';
import '../cubit/states.dart';

class Category extends StatelessWidget {
  const Category({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopAppCubitData, ShopAppDataStates>(
        listener: (context, state) {},
        builder: (context, state) {
          ShopAppCubitData c = ShopAppCubitData.get(context);
          return Scaffold(
            body: c.categoriesDataModel == null
                ? Center(
                    child: CircularProgressIndicator(),
                  )
                : ListView.separated(
                    itemBuilder: (context, index) =>
                        buildCatitme(c.categoriesDataModel!.data!.data[index]),
                    separatorBuilder: (context, index) => separator(),
                    itemCount: c.categoriesDataModel!.data!.data.length),
          );
        });
  }

  Widget buildCatitme(DataModelOfOneCategories? model) {
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: Row(
        children: [
          Image(
            image: NetworkImage(model!.image.toString()),
            width: 100.0,
            height: 100.0,
          ),
          SizedBox(
            width: 20.0,
          ),
          Text(
            model.name.toString(),
            style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
          ),
          Spacer(),
          Icon(Icons.arrow_forward_ios),
        ],
      ),
    );
  }
}
