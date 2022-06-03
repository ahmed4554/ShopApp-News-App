import 'package:flutter/material.dart';
import 'package:shop_app_news_app/modules/shopapp/shopApp_cupit_login/shopAppCubit.dart';
import 'package:shop_app_news_app/shared/cubit/cubit.dart';

import '../modules/web_view/web_view.dart';
import 'components.dart';

Widget buildBusinessItem(article, context, index) {
  return InkWell(
    onTap: () {
      AppCubit.get(context).changeIsClick(article['title']);
      navigatetTo(
        context,
        widget: WebViewScreen(article['url']),
      );
    },
    child: Stack(
      alignment: Alignment.center,
      children: [
        Padding(
          padding: const EdgeInsets.all(20.0),
          child: Row(
            children: [
              Container(
                width: 120.0,
                height: 120.0,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20.0),
                  image: DecorationImage(
                    image: NetworkImage('${article['urlToImage']}'),
                    fit: BoxFit.fill,
                  ),
                ),
              ),
              separator(),
              Expanded(
                child: Container(
                  height: 120.0,
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Text(
                          '${article['title']}',
                          style: Theme.of(context).textTheme.headline1,
                          maxLines: 4,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      Text(
                        '${article['publishedAt']}',
                        style: Theme.of(context).textTheme.headline2,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
        if (AppCubit.get(context).isClicked[article['title']] == true)
          Container(
            alignment: Alignment.centerLeft,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: Colors.black.withOpacity(.5),
            ),
            padding: const EdgeInsets.symmetric(vertical: 15),
            margin: const EdgeInsets.symmetric(horizontal: 10),
            height: 150.0,
            width: double.infinity,
            child: const Align(
              alignment: Alignment.centerLeft,
              child: Positioned(
                left: 50.0,
                child: Icon(
                  Icons.check_box,
                  color: Colors.white,
                  size: 35,
                ),
              ),
            ),
          ),
      ],
    ),
  );
}

Widget separator() {
  return SizedBox(
    width: 20.0,
  );
}

dynamic token;

//https://newsapi.org/v2/everything?q=tesla&apiKey=8ca455dadafb4eb5b0d0c44c52514c24
