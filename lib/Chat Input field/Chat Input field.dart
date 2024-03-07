import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../cubit/App cubit/app_cubit.dart';
class ChatInputField extends StatefulWidget {
  final String ReceiverId;


  const ChatInputField({super.key, required this.ReceiverId});

  @override
  State<ChatInputField> createState() => _ChatInputFieldState();
}

class _ChatInputFieldState extends State<ChatInputField> {
  TextEditingController controller = TextEditingController();

  @override
  void initState() {
    super.initState();
    controller.addListener(() {
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppState>(
      listener: (context, state) {
        // TODO: implement listener
      },
      builder: (context, state) {
        var cubit = AppCubit.get(context);
        return Padding(
          padding: const EdgeInsets.all(12.0),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 7.5, vertical: 5),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(.1),
              borderRadius: BorderRadius.circular(20),
            ),
            child: TextFormField(
              controller: controller,
              style: const TextStyle(
                  color: Colors.white, fontWeight: FontWeight.bold),
              decoration: InputDecoration(
                border: InputBorder.none,
                hintText: 'Type a message ...',
                hintStyle: const TextStyle(color: Colors.grey, fontSize: 16),
                contentPadding:
                    const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                enabled: true,
                suffixIcon: controller.text.isEmpty
                    ? IconButton(
                        onPressed: () {},
                        icon: Icon(Icons.add,
                            color: Colors.deepPurpleAccent.shade400))
                    : IconButton(
                        onPressed: () {
                          cubit.SendMessage(controller: controller, receiverID: widget.ReceiverId, message: controller.text);
                        },
                        icon: Icon(Icons.send,
                            color: Colors.deepPurpleAccent.shade400)),
                prefixIcon: IconButton(
                    onPressed: ()  {
                    },
                    icon: Icon(
                      Icons.camera_alt_outlined,
                      color: Colors.deepPurpleAccent.shade400,
                    )),
              ),
            ),
          ),
        );
       },
    );
  }
}
