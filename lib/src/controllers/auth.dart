import 'dart:async';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_provider_utilities/flutter_provider_utilities.dart';
import 'package:smartagri/src/models/user.dart' as app;
import 'package:twilio_phone_verify/twilio_phone_verify.dart';

enum AuthState { signedIn, signedOut }

class Auth extends ChangeNotifier with MessageNotifierMixin {
  app.User? currentUser;
  bool isLoading = false;
  AuthState state = AuthState.signedOut;
  late TwilioPhoneVerify otp;
  bool showBadges = false;

  Future<void> uploadImage(File file) async {
    try {
      Reference ref =
          FirebaseStorage.instance.ref().child(currentUser?.uid ?? "");

      UploadTask uploadTask = ref.putFile(file);

      uploadTask.whenComplete(
        () => () async {
          if (uploadTask.snapshot.state == TaskState.success) {
            String url = await uploadTask.snapshot.ref.getDownloadURL();
            FirebaseFirestore.instance
                .collection("users")
                .doc(currentUser?.uid)
                .update(
              {"imageUrl": url},
            );

            currentUser = app.User.fromJson(
              currentUser!.toJson()..update("imageUrl", (value) => url),
            );

            notifyInfo("Image uploaded successfully");
          } else {
            notifyError("Image uploaded failed,please try again");
          }
        },
      );
    } catch (e) {
      notifyError("Image uploaded failed,please try again");
    }
  }

  Future<void> sendVerificationCode(String number) async {
    try {
      TwilioResponse response =
          await otp.sendSmsCode(number.replaceAll("(", "").replaceAll(")", ""));

      if (response.successful ?? false) {
        notifyInfo("OTP Sent Successfully");
      } else {
        notifyError("OTP failed, please check your number and try again");
      }
    } on TimeoutException catch (e) {
      notifyError("Timeout Error, please check your connection");
    } catch (e) {
      notifyError("OTP failed, please check your number and try again");
    }
  }

  Future<bool> confirmCode(String code, String phone) async {
    try {
      TwilioResponse response =
          await otp.verifySmsCode(phone: phone, code: code);
      if (response.successful ?? false) {
        return true;
      }
      return false;
    } on TimeoutException catch (e) {
      notifyError("Timeout Error, please check your connection");
      return false;
    } catch (e) {
      notifyError("OTP failed, please check your number and try again");
      return false;
    }
  }

  Future<bool> signIn(String email, String password) async {
    try {
      isLoading = true;
      notifyListeners();

      UserCredential credential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
      if (credential.user != null) {
        final uid = credential.user?.uid;
        if (uid != null) {
          final DocumentSnapshot<Map<String, dynamic>> doc =
              await FirebaseFirestore.instance
                  .collection("users")
                  .doc(uid)
                  .get();
          Map<String, dynamic> json = doc.data() ?? {};

          currentUser = app.User.fromJson(json);
          state = AuthState.signedIn;
          isLoading = false;
          notifyInfo("Login Successful");
          notifyListeners();
          return true;
        } else {
          isLoading = false;
          notifyError("User data not found,Please Contact Administrator");
          return false;
        }
      }
      return false;
    } on FirebaseAuthException catch (e) {
      isLoading = false;
      notifyError(e.message);
      return false;
    } on FirebaseException catch (e) {
      isLoading = false;
      notifyError(e.message);
      return false;
    } on TimeoutException catch (e) {
      isLoading = false;
      notifyError("Timeout Error,please check connection");
      return false;
    }
  }

  Future<void> createUser(
    String fullname,
    String email,
    String password,
    String phone,
    String gender,
    String dateOfBirth,
  ) async {
    isLoading = true;
    try {
      UserCredential credential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);
      if (credential.user != null) {
        currentUser = app.User(
          dob: dateOfBirth,
          email: email,
          fullname: fullname,
          uid: credential.user!.uid,
          gender: gender,
          phone: phone,
          rating: 0,
        );

        await FirebaseFirestore.instance
            .collection("users")
            .doc(credential.user!.uid)
            .set(
              currentUser!.toJson(),
            );

        notifyInfo("Account Created Successfully");
      }
    } on FirebaseAuthException catch (e) {
      notifyError(e.message);
    } on TimeoutException catch (e) {
      notifyError(
        "Registration Failed due to bad network, please check your connection",
      );
    } catch (e) {
      notifyError(e);
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  Future<void> signOut() async {
    try {
      await FirebaseAuth.instance.signOut();
      currentUser = null;
      state = AuthState.signedOut;
      notifyInfo("Logged Out Successfully");
    } on TimeoutException catch (e) {
      notifyError("Timeout Error,please check your connection");
    } catch (e) {
      notifyError(e);
    }
  }

  Future<void> updateUser(app.User user) async {
    try {
      await FirebaseFirestore.instance
          .collection("users")
          .doc(currentUser?.uid)
          .set(
            user.toJson(),
            SetOptions(merge: true),
          );
      currentUser = user;
      notifyInfo("User updated successfully");
    } catch (e) {
      notifyError("User update failed");
    }
  }

  Future<void> toggleBadges(bool value) async {
    showBadges = value;
    notifyListeners();
  }
}
