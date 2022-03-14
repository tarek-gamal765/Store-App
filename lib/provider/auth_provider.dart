import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce/models/user_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;

class AuthProvider extends ChangeNotifier {
  File? userImage;

  void getUserImage({
    required ImageSource source,
  }) async {
    final pickedImage = await ImagePicker().pickImage(source: source);
    if (pickedImage != null) {
      userImage = File(pickedImage.path);
    }
    notifyListeners();
  }

  void uploadUserData({
    required String id,
    required String name,
    required String phone,
    required String email,
    required String password,
  }) {
    final userId = FirebaseAuth.instance.currentUser!.uid;
    final dateFormat = DateTime.parse(DateTime.now().toString());
    final formattedDate =
        '${dateFormat.day}-${dateFormat.month}-${dateFormat.year}';
    firebase_storage.FirebaseStorage.instance
        .ref()
        .child('users/${Uri.file(userImage!.path).pathSegments.last}')
        .putFile(userImage!)
        .then(
      (value) {
        value.ref.getDownloadURL().then(
          (value) {
            UserModel model = UserModel(
              id: id,
              name: name,
              phone: phone,
              email: email,
              password: password,
              imageUrl: value,
              joinedAt: formattedDate,
              createdAt: Timestamp.now().toString(),
            );
            FirebaseFirestore.instance
                .collection('users')
                .doc(userId)
                .set(model.toJson());
          },
        );
      },
    );
  }

  UserModel? userModel;

  Future<void> getUserData() async {
    User? user = FirebaseAuth.instance.currentUser;

    if (user != null && !user.isAnonymous) {
      final uId = user.uid;
      FirebaseFirestore.instance
          .collection('users')
          .doc(uId)
          .get()
          .then((value) {
        userModel = UserModel.fromJson(value.data()!);
        print(userModel!.name);
      });
    }
  }

  Future<void> userRegister({
    required String name,
    required String phone,
    required String email,
    required String password,
  }) async {
    await FirebaseAuth.instance
        .createUserWithEmailAndPassword(
      email: email,
      password: password,
    )
        .then(
      (value) {
        uploadUserData(
          id: value.user!.uid,
          name: name,
          phone: phone,
          email: email,
          password: password,
        );
      },
    );
  }

  Future<void> userLogin({
    required String email,
    required String password,
  }) async {
    await FirebaseAuth.instance.signInWithEmailAndPassword(
      email: email,
      password: password,
    );
  }

  Future<void> signInAnonymously() async {
    await FirebaseAuth.instance.signInAnonymously();
  }

  Future<void> signInWithGoogle() async {
    final googleAccount = await GoogleSignIn().signIn();
    if (googleAccount != null) {
      final googleAuth = await googleAccount.authentication;
      if (googleAuth.accessToken != null && googleAuth.idToken != null) {
        await FirebaseAuth.instance
            .signInWithCredential(
          GoogleAuthProvider.credential(
            idToken: googleAuth.idToken,
            accessToken: googleAuth.accessToken,
          ),
        )
            .then(
          (value) {
            final dateFormat = DateTime.parse(DateTime.now().toString());
            final formattedDate =
                '${dateFormat.day}-${dateFormat.month}-${dateFormat.year}';
            UserModel model = UserModel(
              id: value.user!.uid,
              name: value.user!.displayName,
              email: value.user!.email,
              imageUrl: value.user!.photoURL,
              phone: value.user!.phoneNumber,
              joinedAt: formattedDate,
              createdAt: Timestamp.now().toString(),
            );
            FirebaseFirestore.instance
                .collection('users')
                .doc(value.user!.uid)
                .set(model.toJson());
          },
        );
      }
    }
  }

  Future<void> resetPassword({
    required String email,
  }) async {
    await FirebaseAuth.instance.sendPasswordResetEmail(
      email: email,
    );
  }

  Future<void> updateUser({
    required String name,
    required String phone,
    required String email,
    required String password,
  }) async {
    User? user = FirebaseAuth.instance.currentUser;
    if (name != userModel!.name) {
      FirebaseFirestore.instance.collection('users').doc(user!.uid).update({
        'name': name,
      });
    } else if (!phone.contains(userModel!.phone!)) {
      FirebaseFirestore.instance.collection('users').doc(user!.uid).update({
        'phone': phone,
      });
    } else if (!password.contains(userModel!.password!)) {
      FirebaseFirestore.instance.collection('users').doc(user!.uid).update({
        'password': password,
      });
    } else if (!email.contains(userModel!.email!)) {
      FirebaseFirestore.instance.collection('users').doc(user!.uid).update({
        'email': email,
      });
    }
  }
}
