import 'package:flutter/cupertino.dart';
import 'package:flutter_provider_utilities/flutter_provider_utilities.dart';
import 'package:smartagri/src/controllers/auth.dart';
import 'package:smartagri/src/validation_item.dart';

class SignInForm extends ChangeNotifier with MessageNotifierMixin {
  final Auth auth;

  SignInForm(this.auth);

  ValidationItem email = ValidationItem(null, null);
  ValidationItem password = ValidationItem(null, null);
  ValidationItem username = ValidationItem(null, null);

  void onChangeEmail(String value) {
    email = ValidationItem(value, null);
    notifyListeners();
  }

  void onChangePassword(String value) {
    password = ValidationItem(value, null);
    notifyListeners();
  }

  void onChangeUsername(String value) {
    username = ValidationItem(value, null);
    notifyListeners();
  }

  bool isValid() {
    return email.isValid() && password.isValid();
  }

  Future<bool> submit() async {
    if (isValid()) {
      return await auth.signIn(email.value, password.value);
    } else {
      auth.notifyError("Please fill in all fields");
      return false;
    }
  }
}
