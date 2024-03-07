import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:meta/meta.dart';

import '../../models/Chat model.dart';

part 'app_state.dart';

class AppCubit extends Cubit<AppState> {
  AppCubit() : super(AppInitial());

  static AppCubit get(context) => BlocProvider.of(context);

  // Auth variable
  var auth = FirebaseAuth.instance;
  var database = FirebaseFirestore.instance;
  var storge = FirebaseStorage.instance;
  var user = FirebaseAuth.instance.currentUser;

  Future<void> SendCameraImage(
      {required XFile file, required TextEditingController controller}) async {
    emit(PickerImageLoading());
    final ref = storge
        .ref()
        .child('images')
        .child(DateTime.now().toIso8601String() + file.name);
    await ref.putFile(File(file.path)).then((p0) async {
      final uel = await ref.getDownloadURL().then((url) {
        Map<String, dynamic> document = {
          'images': url,
          'senderId': user!.uid,
          'senderName': user?.displayName,
          'senderImage': user?.photoURL,
          'type': 1,
          'time': DateTime.now()
        };
        database.collection('messages').add(document);
        emit(PickerImageSuccess());
        controller.clear();
        emit(ControllerCleared());

        print(url);
      }).catchError((onError) {
        emit(PickerImageFailed());
        print(onError.toString());
      });
    }).catchError((onError) {
      print(onError.toString());
    });
  }
  List messages=[];

  Future<void> SendMessage(
      {required receiverID,
      required message,
      required TextEditingController controller}) async {
    emit(SendingMessageLoading());

    final String currentUserId = auth.currentUser!.uid;
    final String email = auth.currentUser!.email!;
    final Timestamp timeStamp = Timestamp.now();

    Chat chat = Chat(
        senderEmail: email,
        senderId: currentUserId,
        receiverId: receiverID,
        Message: message,
        timestamp: timeStamp);

    List<String> ids = [currentUserId, receiverID];
    ids.sort();
    String ChatRoomId = ids.join('_');
    await database
        .collection("chat_rooms")
        .doc(ChatRoomId)
        .collection('messages')
        .add(chat.toMap())
        .then((value) {
          messages.add(value);
          print(message);
      emit(SendingMessageSuccess());
      controller.clear();
      emit(ControllerCleared());
    }).catchError((onError) {
      print(onError);
    });
  }

  Future<UserCredential> Register({
    required String email,
    required String password,
  }) async {
    try {
      emit(RegisterLoading());
      UserCredential userCredential = await auth.createUserWithEmailAndPassword(
          email: email, password: password);
      database.collection('Users').doc(userCredential.user!.uid).set({
        'email': userCredential.user!.email,
        'uid': userCredential.user!.uid,
      });
      emit(RegisterSuccess());

      return userCredential;
    } on FirebaseAuthException catch (e) {
      emit(RegisterFailed());
      print(e.message);
      rethrow;
      // TODO
    }
  }

  Future<UserCredential> Login({
    required String email,
    required String password,
  }) async {
    try {
      emit(LoginLoading());
      UserCredential userCredential = await auth.signInWithEmailAndPassword(
          email: email, password: password);
      database.collection('Users').doc(userCredential.user!.uid).set({
        'email': userCredential.user!.email,
        'uid': userCredential.user!.uid,
      });
      emit(LoginSuccess());

      return userCredential;
    } on FirebaseAuthException catch (e) {
      emit(LoginFailed());
      print(e.message);
      rethrow;
      // TODO
    }
  }

  Stream<List<Map<String, dynamic>>> getUsersStream() {
    return database.collection('Users').snapshots().map((snapshot) {
      return snapshot.docs.map((doc) {
        final user = doc.data();
        return user;
      }).toList();
    });
  }

  User? getCurrentUser() {
    return auth.currentUser;
  }


  Stream<QuerySnapshot> getMessages(String UserId, otherUserId) {
    List<String> ids = [UserId, otherUserId];

    ids.sort();
    String ChatRoomId = ids.join('_');
    return database
        .collection('chat_rooms')
        .doc(ChatRoomId)
        .collection('messages')
        .orderBy('timestamp', descending: false)
        .snapshots();
  }
}
