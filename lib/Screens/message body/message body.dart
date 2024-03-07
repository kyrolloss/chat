import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../Chat Input field/Chat Input field.dart';
import '../../components/color.dart';
import '../../cubit/App cubit/app_cubit.dart';

class MessageBody extends StatefulWidget {
  final String email;
  final String ReceiverId;

  const MessageBody({super.key, required this.email, required this.ReceiverId});

  @override
  State<MessageBody> createState() => _MessageBodyState();
}

class _MessageBodyState extends State<MessageBody> {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppState>(
      listener: (context, state) {
        // TODO: implement listener
      },
      builder: (context, state) {

        return Scaffold(
          backgroundColor: Colors.black,
          appBar: AppBar(
              leading: IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: const Icon(
                    Icons.arrow_back_ios_new,
                    color: Colors.white,
                  )),
              backgroundColor: Colors.transparent,
              title: Text(
                widget.email,
                style: const TextStyle(color: Colors.white),
              )),
          body: Column(
            children: [
              Expanded(child: buildMessageList()),
              ChatInputField(
                ReceiverId: widget.ReceiverId,
              )
            ],
          ),
        );
      },
    );
  }

  Widget buildMessageList() {
    String SenderId = AppCubit.get(context).getCurrentUser()!.uid;
    return StreamBuilder(
      stream: AppCubit.get(context).getMessages(widget.ReceiverId, SenderId),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return const Text('error');
        }
        if (snapshot.connectionState == ConnectionState) {
          return const Text('Loadingg');
        }
        if (!snapshot.hasData) {
          return CircularProgressIndicator(
            color: AppColor.primeColor,
          );
        }

        return ListView(
          children:
              snapshot.data!.docs.map((doc) => BuildMessageItem(doc)).toList(),
        );
      },
    );
  }

  Widget BuildMessageItem(
    DocumentSnapshot doc,
  ) {
    var height = MediaQuery.of(context).size.height;

    Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
    bool isCurrentUser =
        data['senderId'] == AppCubit.get(context).getCurrentUser()!.uid;

    return Align(
      alignment:
          isCurrentUser == true ? Alignment.bottomRight : Alignment.centerLeft,
      child: FractionallySizedBox(
        widthFactor: .375,
        child: isCurrentUser == true
            ? Padding(
                padding: const EdgeInsets.all(8.0),
                child: Align(
                  alignment: Alignment.centerRight,
                  child: Container(
                      height: height * .075,
                      decoration: const BoxDecoration(
                          color: Colors.grey,
                          borderRadius: BorderRadius.only(
                              bottomLeft: Radius.circular(20),
                              bottomRight: Radius.circular(2.5),
                              topLeft: Radius.circular(20),
                              topRight: Radius.circular(17.5))),
                      child: Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: Text(
                          data['message'],
                          style: const TextStyle(
                              color: Colors.white,
                              fontSize: 22.5,
                              fontWeight: FontWeight.bold),
                        ),
                      )),
                ),
              )
            : Padding(
                padding: const EdgeInsets.all(8.0),
                child: Align(
                  alignment: Alignment.centerRight,
                  child: Container(
                      height: height * .075,
                      decoration: BoxDecoration(
                          color: Colors.white.withOpacity(.3),
                          borderRadius: const BorderRadius.only(
                              bottomRight: Radius.circular(20),
                              bottomLeft: Radius.circular(2.5),
                              topLeft: Radius.circular(20),
                              topRight: Radius.circular(17.5))),
                      child: Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: Text(
                          data['message'],
                          style: const TextStyle(
                              color: Colors.white,
                              fontSize: 22.5,
                              fontWeight: FontWeight.bold),
                        ),
                      )),
                ),
              ),
      ),
    );
  }
}
