import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../models/shopAppDataModel/shopAppDataModel.dart';
import '../modules/shopapp/cubit/shopAppCubitData.dart';
import 'constans.dart';

class MyBlocObserver extends BlocObserver {
  @override
  void onCreate(BlocBase bloc) {
    super.onCreate(bloc);
    print('onCreate -- ${bloc.runtimeType}');
  }

  @override
  void onChange(BlocBase bloc, Change change) {
    super.onChange(bloc, change);
    print('onChange -- ${bloc.runtimeType}, $change');
  }

  @override
  void onError(BlocBase bloc, Object error, StackTrace stackTrace) {
    print('onError -- ${bloc.runtimeType}, $error');
    super.onError(bloc, error, stackTrace);
  }

  @override
  void onClose(BlocBase bloc) {
    super.onClose(bloc);
    print('onClose -- ${bloc.runtimeType}');
  }
}

Widget textInput(
    {inputControler,
    required String inputLabal,
    required TextInputType type,
    required bool isSave,
    required IconData preffix,
    IconData? suffix,
    required dynamic validate,
    VoidCallback? onSuffixPressed,
    change,
    dynamic onSubmit}) {
  return TextFormField(
    controller: inputControler,
    decoration: InputDecoration(
      border: OutlineInputBorder(),
      label: Text(inputLabal),
      prefixIcon: Icon(preffix),
      suffixIcon: IconButton(
        onPressed: onSuffixPressed,
        icon: Icon(suffix),
      ),
    ),
    keyboardType: type,
    obscureText: isSave,
    validator: validate,
    onChanged: change,
    onFieldSubmitted: onSubmit,
  );
}

void navigatetTo(context, {required Widget widget}) {
  Navigator.push(context, MaterialPageRoute(builder: (context) => widget));
}

void navigatetOff(context, {required Widget widget}) {
  Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (context) => widget),
      (Route<dynamic> router) => false);
}

Widget noResult(context) {
  return Center(
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(
          Icons.menu,
          size: 120.0,
        ),
        separator(),
        Text(
          'Search to view news',
          style: Theme.of(context).textTheme.headline3,
        )
      ],
    ),
  );
}

Widget pageViewItem(
  context,
  index, {
  model,
}) {
  return Padding(
    padding: const EdgeInsets.all(30.0),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: Image(
            image: AssetImage(
              model[index].image,
            ),
          ),
        ),
        Text(
          '${model[index].title}',
          style: Theme.of(context).textTheme.headline1,
        ),
        SizedBox(
          height: 40.0,
        ),
      ],
    ),
  );
}

Widget indicator(context,
    {required PageController cont, len, isLast, required Function submit}) {
  return Padding(
    padding: const EdgeInsets.all(30.0),
    child: Row(
      children: [
        SmoothPageIndicator(
          controller: cont,
          count: len,
          effect: ExpandingDotsEffect(
            activeDotColor: Colors.deepOrange,
            expansionFactor: 4.0,
            spacing: 4.0,
          ),
        ),
        Spacer(),
        FloatingActionButton(
          onPressed: () {
            print('$isLast from the floating action button');
            if (isLast) {
              print('navigated');
              submit();
            } else {
              print('$isLast from the fucntion');
              cont.nextPage(
                  duration: Duration(milliseconds: 750),
                  curve: Curves.easeInOutQuart);
            }
          },
          child: Icon(Icons.arrow_forward_ios),
        ),
      ],
    ),
  );
}

SnackBar snackbar({required String massage, required Color color}) {
  return SnackBar(
    backgroundColor: color,
    duration: Duration(seconds: 5),
    behavior: SnackBarBehavior.floating,
    content: Text(
      massage,
      style: const TextStyle(fontWeight: FontWeight.bold),
      textAlign: TextAlign.center,
    ),
    dismissDirection: DismissDirection.down,
  );
}

Widget itemProductBuild({required model, required int index,context,bool search = false}) {
      return Container(
        height: 200,
        padding: EdgeInsets.all(5.0),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.deepOrange),
          borderRadius: BorderRadius.circular(10.0),
        ),
        clipBehavior: Clip.antiAliasWithSaveLayer,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(alignment: AlignmentDirectional.bottomEnd, children: [
              Image(
                width: double.infinity,
                height: 200.0,
                fit: BoxFit.fill,
                image: NetworkImage(
                  model.image.toString(),
                ),
              ),
              if(search==false)
              if (model.price != model.old_price)
                Container(
                  padding: EdgeInsets.fromLTRB(5, 5, 5, 5),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10.0),
                    color: Colors.red,
                  ),
                  child: Text(
                    'Discount ${model.discount} \$',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
            ]),
            SizedBox(
              height: 8.0,
            ),
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.0),
                  color: Colors.grey[300],
                ),
                clipBehavior: Clip.antiAliasWithSaveLayer,
                child: Padding(
                  padding: const EdgeInsets.all(
                    12.0,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Text(
                        model.name.toString(),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                      Spacer(),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                            '${model.price.round()}',
                            style: TextStyle(color: Colors.blue),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                          SizedBox(
                            width: 5,
                          ),
                          if(search== false)
                          if (model.price != model.old_price)
                            Text(
                              '${model.old_price.round()}',
                              style: const TextStyle(
                                  color: Colors.red,
                                  decoration: TextDecoration.lineThrough),
                            ),
                          const Spacer(),
                          IconButton(
                            onPressed: () {
                              ShopAppCubitData.get(context)
                                  .editFavourite(model.id, index:index);
                            },
                            icon: model.in_favorites == true
                                ? const Icon(
                                    Icons.favorite,
                                    color: Color.fromARGB(255, 255, 17, 0),
                                  )
                                : const Icon(
                                    Icons.favorite_border,
                                  ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      );
    }
  Widget buildFavItem({required model, required context, bool isSearch = false}) {
    return Container(
      height: 120.0,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(alignment: AlignmentDirectional.bottomEnd, children: [
            Container(
              clipBehavior: Clip.antiAliasWithSaveLayer,
              decoration:
                  BoxDecoration(borderRadius: BorderRadius.circular(10)),
              child: Image(
                width: 120,
                height: 120.0,
                fit: BoxFit.fill,
                image: NetworkImage(
                  model.image.toString(),
                ),
              ),
            ),
            if(isSearch == false)
            if (model.price != model.oldPrice)
              Container(
                padding: EdgeInsets.fromLTRB(5, 5, 5, 5),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.0),
                  color: Color.fromARGB(165, 244, 67, 54),
                ),
                child: Text(
                  'Discount ${model.discount}%',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
          ]),
          SizedBox(
            width: 8.0,
          ),
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10.0),
                color: Colors.grey[300],
              ),
              clipBehavior: Clip.antiAliasWithSaveLayer,
              child: Padding(
                padding: const EdgeInsets.all(
                  12.0,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      model.name.toString(),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    Spacer(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          model.price.toString(),
                          style: TextStyle(color: Colors.blue),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        if(isSearch==false)
                        if (model.price != model.oldPrice)
                          Text(
                            model.oldPrice.toString(),
                            style: const TextStyle(
                                color: Colors.red,
                                decoration: TextDecoration.lineThrough),
                          ),
                        const Spacer(),
                        IconButton(
                          onPressed: () {
                            ShopAppCubitData.get(context).editFavourite(
                                int.parse(model.id.toString()),
                                index:
                                    ShopAppCubitData.get(context).neededIndex);
                          },
                          icon:isSearch==true? model.in_favorites? const Icon(
                            Icons.favorite,
                            color: Color.fromARGB(255, 255, 17, 0),
                          ):const Icon(Icons.favorite_border):const Icon(Icons.favorite,color: Colors.red,)
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }