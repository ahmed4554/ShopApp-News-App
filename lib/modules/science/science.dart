import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../constans/constans.dart';
import '../../shared/cubit/cubit.dart';
import '../../shared/cubit/states.dart';


class Science extends StatelessWidget {
  const Science({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppCubitState>(
        builder: (context, state) {
          var list = AppCubit.get(context).science;
          return list.length > 0
              ? ListView.separated(
              physics: BouncingScrollPhysics(),
              itemBuilder: (context, index) => buildBusinessItem(list[index],context,index),
              separatorBuilder: (context, index) => separator(),
              itemCount: list.length)
              : const Center(child: CircularProgressIndicator(),);
        },
        listener: (context, state) {});
  }
}
