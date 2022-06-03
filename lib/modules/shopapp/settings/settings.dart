import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';
import 'package:shop_app_news_app/constans/constans.dart';
import 'package:shop_app_news_app/modules/shopapp/login/login.dart';
import 'package:shop_app_news_app/modules/shopapp/shopApp_cupit_login/shopAppCubit.dart';
import 'package:shop_app_news_app/network/local/shared_preference.dart';

import '../../../constans/components.dart';
import '../register/cubit_register/register_states.dart';
import '../shopApp_cupit_login/shopAppStates.dart';

class Settings extends StatelessWidget {
  Settings({Key? key}) : super(key: key);
  var formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopAppCubit, ShopAppStates>(
      listener: (context, state) {
        if (state is UpdateUserSuccess) {
          if (state.userData.status!) {
            ScaffoldMessenger.of(context).showSnackBar(
                snackbar(color: Colors.green, massage: state.userData.message));
          } else {
            ScaffoldMessenger.of(context).showSnackBar(
                snackbar(color: Colors.red, massage: state.userData.message));
          }
        }
      },
      builder: (context, state) {
        var c = ShopAppCubit.get(context);
        return c.userData == null
            ? Lottie.asset('images/lottie.json')
            : Scaffold(
                body: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Form(
                  key: formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      textInput(
                        inputLabal: 'Name',
                        isSave: false,
                        type: TextInputType.name,
                        inputControler: c.nameController,
                        validate: (value) {
                          if (value.isEmpty) {
                            return 'the name value musn\'t be empty';
                          }
                        },
                        preffix: Icons.person,
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      textInput(
                        inputLabal: 'E-mail',
                        isSave: false,
                        type: TextInputType.emailAddress,
                        inputControler: c.emailController,
                        validate: (value) {
                          if (value.isEmpty) {
                            return 'the name value musn\'t be empty';
                          }
                        },
                        preffix: Icons.email,
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      textInput(
                          inputLabal: 'Phone',
                          isSave: false,
                          type: TextInputType.phone,
                          inputControler: c.phoneController,
                          validate: (value) {
                            if (value.isEmpty) {
                              return 'the name value musn\'t be empty';
                            }
                          },
                          preffix: Icons.phone),
                      const SizedBox(
                        height: 20,
                      ),
                      TextButton(
                        style: TextButton.styleFrom(
                            padding: const EdgeInsets.symmetric(vertical: 15),
                            primary: Colors.white,
                            backgroundColor: Colors.deepOrange),
                        onPressed: () {
                          if (formKey.currentState!.validate()) {
                            c.upadateUser(
                                token: token,
                                name: c.nameController.text,
                                email: c.emailController.text,
                                phone: c.phoneController.text);
                          }
                        },
                        child: state is UpdateUserLoading
                            ? const LinearProgressIndicator()
                            : const Text('Update'),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      TextButton(
                        style: TextButton.styleFrom(
                            padding: const EdgeInsets.symmetric(vertical: 15),
                            primary: Colors.white,
                            backgroundColor: Colors.deepOrange),
                        onPressed: () {
                          SharedHelper.removeData(key: 'token').then((value) {
                            navigatetOff(context, widget: LoginScreen());
                            print(token);
                          });
                        },
                        child: Text('Log Out'),
                      ),
                    ],
                  ),
                ),
              ));
      },
    );
  }
}
