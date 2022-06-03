import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app_news_app/modules/shopapp/search/search_cubit/search_cubit.dart';
import 'package:shop_app_news_app/modules/shopapp/search/search_cubit/states.dart';

import '../../../constans/components.dart';
import '../../../models/shop_app_search_model/search_model.dart';

class Search extends StatelessWidget {
  const Search({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SearchCubit(),
      child: BlocConsumer<SearchCubit, SearchStates>(
        listener: (context, state) {},
        builder: (context, state) {
          var c = SearchCubit.get(context);
          return Scaffold(
            appBar: AppBar(),
            body: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                mainAxisSize: MainAxisSize.max,
                children: [
                textInput(
                    inputLabal: 'Search For Product',
                    isSave: false,
                    preffix: Icons.search,
                    type: TextInputType.text,
                    validate: (value) {
                      return 'Enter a Text To Search';
                    },
                    onSubmit: (value) {
                      c.searching(text: value);
                    },
                    inputControler: c.searchController),
                const SizedBox(
                  height: 20,
                ),
                c.model == null
                    ? noResult(context)
                    : Expanded(
                        child: ListView.separated(
                            itemBuilder: (context, index) {
                              return buildFavItem(
                                  model: c.model!.data!.data[index],
                                  context: context,
                                  isSearch: true,
                                  );
                            },
                            separatorBuilder: (context, index) =>
                                const SizedBox(
                                  height: 20,
                                ),
                            itemCount: c.model!.data!.data.length)),
              ]),
            ),
          );
        },
      ),
    );
  }
}
