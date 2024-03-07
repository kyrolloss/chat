import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../Text.dart';

class UserTile extends StatelessWidget {
  final String text;
  final void Function()? onTap;


  const  UserTile({super.key, required this.text, this.onTap});

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          height: height * .1,
          width: width * .85,
          decoration: const BoxDecoration(),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0),
            child: Row(
              children: [
                const CircleAvatar(
                  backgroundColor: Colors.grey,
                  radius: 30,
                  child: Icon(Icons.person , size: 30,color: Colors.black45,),
                ),
                Flexible(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10.0),
                    child: Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 12.5),
                          child: BuildText(
                            text: text,
                            bold: true,
                            size: 17.5,
                            color: Colors.white,
                          ),
                        ),

                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
