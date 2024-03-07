import 'package:chat/components/Text.dart';
import 'package:chat/components/color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../components/User Tile/UserTile.dart';
import '../cubit/App cubit/app_cubit.dart';
import 'message body/message body.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;

    return BlocConsumer<AppCubit, AppState>(
      listener: (context, state) {
        // TODO: implement listener
      },
      builder: (context, state) {
        var cubit = AppCubit.get(context);
        return SafeArea(
          child: Scaffold(
            appBar: AppBar(
              backgroundColor: Colors.grey.withOpacity(.2),
              shadowColor: Colors.white,
              leading:const SizedBox(),
          
              title :BuildText(
                text: 'Contacts',
                size: 22.5,
                color: Colors.white,
                bold: true,
              ),
              centerTitle: true,
            ),
            backgroundColor: Colors.black,
            body: Padding(
              padding: const EdgeInsets.symmetric(
                vertical: 10.0,
              ),
              child: SingleChildScrollView(
                child: Column(
                  children: [
          
                    SizedBox(
                        height: height * .8, width: width, child: BuilderUserList())
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  Widget BuilderUserList() {
    return StreamBuilder(
      stream: AppCubit.get(context).getUsersStream(),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return const Text('error');
        }
        if (snapshot.connectionState == ConnectionState) {
          return const Text('Loading');
        }
        if (!snapshot.hasData) {
          return CircularProgressIndicator(
            color: AppColor.primeColor,
          );
        }
        return ListView(
          children: snapshot.data!
              .map<Widget>((userData) => BuildUserListItem(userData, context))
              .toList(),
        );
      },
    );
  }

  Widget BuildUserListItem(
      Map<String, dynamic> userData, BuildContext context) {
    return StreamBuilder(
      stream: AppCubit.get(context).getUsersStream(),
      builder: (context, snapshot) {
        if (userData["email"] !=
            AppCubit.get(context).getCurrentUser()!.email) {
          return UserTile(
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => MessageBody(
                            email: userData['email'],
                            ReceiverId: userData['uid'],
                          )));
            },
            text: userData['email'],
          );
        } else {
          return const SizedBox();
        }
      },
    );
  }
}
