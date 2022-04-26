import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:image_picker/image_picker.dart';
import 'package:smartagri/src/controllers/auth.dart';
import 'package:smartagri/src/models/user.dart';
import 'package:smartagri/src/validation_item.dart';
import 'package:validators/validators.dart';

class CreateProfileForm extends ChangeNotifier {
  ValidationItem fullnames = ValidationItem(null, null);
  ValidationItem phone = ValidationItem(null, null);
  ValidationItem email = ValidationItem(null, null);
  ValidationItem password = ValidationItem(null, null);
  ValidationItem confirmPassword = ValidationItem(null, null);
  ValidationItem gender = ValidationItem(null, null);
  ValidationItem dob = ValidationItem(null, null);
  ValidationItem screenName = ValidationItem(null, null);
  ValidationItem socialLinksFacebook = ValidationItem(null, null);
  ValidationItem socialLinksTwitter = ValidationItem(null, null);
  ValidationItem socialLinksInstagram = ValidationItem(null, null);
  ValidationItem socialLinksTikTok = ValidationItem(null, null);
  ValidationItem imageUrl = ValidationItem(null, null);

  final Auth auth;

  CreateProfileForm(this.auth) {
    if (auth.state == AuthState.signedIn) {
      fullnames = ValidationItem(auth.currentUser?.fullname, null);
      phone = ValidationItem(auth.currentUser?.phone, null);
      email = ValidationItem(auth.currentUser?.email, null);
      dob = ValidationItem(auth.currentUser?.dob, null);
      screenName = ValidationItem(auth.currentUser?.screenName, null);
      if (auth.currentUser?.socialLinks?.isNotEmpty ?? false) {
        socialLinksTikTok =
            ValidationItem(auth.currentUser?.socialLinks?[0], null);
        socialLinksInstagram =
            ValidationItem(auth.currentUser?.socialLinks?[1], null);
        socialLinksTwitter =
            ValidationItem(auth.currentUser?.socialLinks?[2], null);
        socialLinksFacebook =
            ValidationItem(auth.currentUser?.socialLinks?[3], null);
      }
    }
  }

  Future<void> updateImage() async {
    try {
      XFile? file = await ImagePicker().pickImage(source: ImageSource.gallery);

      if (file != null) {
        await auth.uploadImage(File(file.path));
      }
    } catch (e) {
      auth.notifyError("Invalid image format, please try again");
    }
  }

  Future<void> updateUser() async {
    User user = User(
      uid: auth.currentUser!.uid,
      fullname: fullnames.value,
      agoraID: auth.currentUser?.agoraID,
      imageUrl: auth.currentUser?.imageUrl,
      rating: auth.currentUser?.rating,
      badges: auth.currentUser?.badges,
      dob: dob.value,
      email: email.value,
      gender: auth.currentUser?.gender,
      phone: phone.value,
      screenName: screenName.value,
      socialLinks: [
        socialLinksTikTok.value,
        socialLinksInstagram.value,
        socialLinksTwitter.value,
        socialLinksFacebook.value
      ],
    );

    await auth.updateUser(user);
  }

  void changeScreenName(String? value) {
    if (value != null) {
      screenName = ValidationItem(value, null);
    } else {
      screenName = ValidationItem(null, "Screen name invalid");
    }
    notifyListeners();
  }

  void changeSocialLinksFb(String? value) {
    if (value != null) {
      socialLinksFacebook = ValidationItem(value, null);
    } else {
      socialLinksFacebook = ValidationItem(null, "Screen name invalid");
    }
    notifyListeners();
  }

  void changeSocialLinksTwitter(String? value) {
    if (value != null) {
      socialLinksTwitter = ValidationItem(value, null);
    } else {
      socialLinksTwitter = ValidationItem(null, "Screen name invalid");
    }
    notifyListeners();
  }

  void changeSocialLinksInsta(String? value) {
    if (value != null) {
      socialLinksInstagram = ValidationItem(value, null);
    } else {
      socialLinksInstagram = ValidationItem(null, "Screen name invalid");
    }
    notifyListeners();
  }

  void changeSocialLinksTick(String? value) {
    if (value != null) {
      socialLinksTikTok = ValidationItem(value, null);
    } else {
      socialLinksTikTok = ValidationItem(null, "Screen name invalid");
    }
    notifyListeners();
  }

  void changeFullnames(String? value) {
    if ((value?.split(" ").length ?? 0) >= 2) {
      fullnames = ValidationItem(value, null);
    } else {
      fullnames = ValidationItem(null, "must include name and surname");
    }

    notifyListeners();
  }

  void changePhone(String value) {
    if (value.length >= 10) {
      phone = ValidationItem(value, null);
    } else {
      phone = ValidationItem(null, "invalid phone number format");
    }
    notifyListeners();
  }

  void changeEmail(String value) {
    if (isEmail(value)) {
      email = ValidationItem(value, null);
    } else {
      email = ValidationItem(null, "invalid email format");
    }
    notifyListeners();
  }

  void changePassword(String value) {
    if (value.length >= 6) {
      password = ValidationItem(value, null);
    } else {
      password = ValidationItem(null, "password must be greater than 6");
    }

    notifyListeners();
  }

  void changeConfirmPassword(String value) {
    if (value == password.value) {
      confirmPassword = ValidationItem(value, null);
    } else {
      confirmPassword = ValidationItem(null, "passwords must match");
    }

    notifyListeners();
  }

  void changeGender(String value) {
    if (value.isNotEmpty) {
      gender = ValidationItem(value, null);
    } else {
      gender = ValidationItem(null, "required");
    }

    notifyListeners();
  }

  void changeDOB(String value) {
    dob = ValidationItem(value, null);
    notifyListeners();
  }

  bool isValid() {
    return dob.isValid() &&
        phone.isValid() &&
        email.isValid() &&
        password.isValid() &&
        confirmPassword.isValid() &&
        fullnames.isValid();
  }

  Future<void> submit() async {
    if (isValid()) {
      await auth.createUser(fullnames.value, email.value, password.value,
          phone.value, gender.value, dob.value);
    } else {
      auth.notifyError("Please fill in all fields");
    }
  }
}
