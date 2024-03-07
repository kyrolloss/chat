import 'package:chat/Screens/home%20Screen.dart';
import 'package:chat/components/Text.dart';
import 'package:chat/components/color.dart';
import 'package:chat/components/components.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../cubit/App cubit/app_cubit.dart';
import '../Sign up/Sign Up.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    TextEditingController emailController = TextEditingController();
    TextEditingController passwordController = TextEditingController();

    return BlocConsumer<AppCubit, AppState>(
      listener: (context, state) {
        if (state is LoginSuccess) {
          navigateTo(context,const  HomeScreen());
        }
        // TODO: implement listener
      },
      builder: (context, state) {
        var cubit = AppCubit.get(context);

        return Scaffold(
          backgroundColor: Colors.black,
          body: Padding(
            padding: const EdgeInsets.symmetric(vertical: 50.0, horizontal: 25),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Container(
                        height: height * .05,
                        width: width * .155,
                        decoration: BoxDecoration(
                            color: Colors.black,
                            borderRadius: BorderRadius.circular(20),
                            border: Border.all(color: Colors.grey, width: .15)),
                        child: const Icon(
                          Icons.arrow_back_ios_new,
                          color: Colors.white,
                        ),
                      ),
                      SizedBox(
                        width: width * .05,
                      ),
                      BuildText(
                        text: 'Log in',
                        color: Colors.white,
                        size: 30,
                        bold: true,
                      ),
                    ],
                  ),
                  SizedBox(
                    height: height * .09,
                  ),
                  BuildText(
                    text: 'log in with one of the following options',
                    size: 15,
                    color: Colors.white,
                    bold: true,
                  ),
                  SizedBox(
                    height: height * .03,
                  ),
                  Row(
                    children: [
                      Container(
                        height: height * .065,
                        width: width * .4,
                        decoration: BoxDecoration(
                            color: Colors.white.withOpacity(.1),
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(color: Colors.grey, width: .15)),
                        child: const Icon(
                          Icons.g_mobiledata_outlined,
                          size: 55,
                          color: Colors.white,
                        ),
                      ),
                      SizedBox(
                        width: width * .05,
                      ),
                      Container(
                        height: height * .065,
                        width: width * .4,
                        decoration: BoxDecoration(
                            color: Colors.white.withOpacity(.1),
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(color: Colors.grey, width: .15)),
                        child: const Icon(
                          Icons.apple,
                          size: 45,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: height * .05,
                  ),
                  BuildText(
                    text: 'Email',
                    color: Colors.white,
                    size: 17.5,
                    bold: true,
                  ),
                  SizedBox(
                    height: height * .005,
                  ),
                  TextFormField(
                    controller: emailController,
                    style:const  TextStyle(
                      color: Colors.white
                    ),
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.white.withOpacity(.1),
                      disabledBorder: OutlineInputBorder(
                        borderSide: const BorderSide(
                          color: Colors.grey,
                          width: 2,
                        ),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: const BorderSide(
                          color: Colors.purple,
                          width: 2,
                        ),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: const BorderSide(
                          color: Colors.grey,
                          width: 2,
                        ),
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: height * .03,
                  ),
                  BuildText(
                    text: 'Passwoard',
                    color: Colors.white,
                    size: 17.5,
                    bold: true,
                  ),
                  SizedBox(
                    height: height * .005,
                  ),
                  TextFormField(
                    controller: passwordController,
                    style:const  TextStyle(
                        color: Colors.white
                    ),
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.white.withOpacity(.1),
                      disabledBorder: OutlineInputBorder(
                        borderSide: const BorderSide(
                          color: Colors.grey,
                          width: 2,
                        ),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: const BorderSide(
                          color: Colors.purple,
                          width: 2,
                        ),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: const BorderSide(
                          color: Colors.grey,
                          width: 2,
                        ),
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: height * .05,
                  ),
                  GestureDetector(
                    onTap: () {
                      cubit.Login(
                          email: emailController.text,
                          password: passwordController.text);
                    },
                    child: Container(
                      height: height * .075,
                      width: width * .9,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: AppColor.primeColor),
                      child: Center(
                          child: BuildText(
                        text: 'Log in',
                        color: Colors.white,
                        size: 17.5,
                        bold: true,
                      )),
                    ),
                  ),
                  SizedBox(
                    height: height * .03,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      BuildText(
                        text: "doesn't hava an account? ",
                        color: Colors.white,
                        size: 17.5,
                      ),
                      SizedBox(
                        width: width * .02,
                      ),
                      GestureDetector(
                        onTap: (){
                          navigateTo(context, const SignUpScreen());
                        },
                        child: BuildText(
                          text: "Sign UP ",
                          color: Colors.white,
                          size: 17.5,
                          bold: true,
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
