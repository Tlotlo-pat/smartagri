import 'package:flutter/material.dart';
import 'package:flutter_provider_utilities/flutter_provider_utilities.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:smartagri/src/controllers/auth.dart';
import 'package:smartagri/src/forms/sign_in_form.dart';
import 'package:smartagri/src/views/auth/sign_up.dart';
import 'package:smartagri/src/widgets/dialogs/notification.dart';
import 'package:smartagri/src/widgets/formlayout.dart';
import 'package:smartagri/src/widgets/inputs/text_input.dart';

import '../home/home_screen.dart';

class SignIn extends StatefulWidget {
  const SignIn({Key? key}) : super(key: key);
  static const String routeName = "/sign_in";

  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  late SignInForm form;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    form = Provider.of<SignInForm>(context);
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final _auth = Provider.of<Auth>(context);

    return MessageListener<Auth>(
      showInfo: (message) {
        showDialog(
          context: context,
          builder: (_) => NotificationDialog(
            type: InfoType.info,
            message: message,
          ),
        );
      },
      showError: (message) {
        showDialog(
          context: context,
          builder: (_) => NotificationDialog(
            type: InfoType.error,
            message: message,
          ),
        );
      },
      child: Stack(
        children: [
          FormLayout(
            title: "Sign In",
            form: Container(
              child: Form(
                //key: form,
                child: Column(
                  children: [
                    Container(
                      width: double.infinity,
                      alignment: Alignment.centerLeft,
                      child: Text(
                        'Welcome Back',
                        style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: HexColor("#5C6E80")),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 5, bottom: 5),
                      width: double.infinity,
                      alignment: Alignment.centerLeft,
                      child: Text('Hello there. Sign in to continue',
                          style: TextStyle(
                              fontSize: 12, color: HexColor("#A5AFBD"))),
                    ),
                    TextInput(
                      value: form.email.value,
                      onChanged: form.onChangeEmail,
                      errorText: form.email.error,
                      label: "Email",
                      placeholder: "Enter your email",
                    ),
                    TextInput(
                      value: form.password.value,
                      onChanged: form.onChangePassword,
                      errorText: form.password.error,
                      label: "Password",
                      placeholder: "Enter your password",
                      isPassword: true,
                    ),
                    Container(
                      padding: EdgeInsets.only(bottom: 20),
                      alignment: Alignment.centerLeft,
                      child: TextButton(
                        child: Text(
                          "Forgot Password?",
                          style: TextStyle(
                            fontSize: 14,
                            color: HexColor("#1264A3"),
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        onPressed: () {},
                      ),
                    ),
                    ElevatedButton(
                      onPressed: () async {
                        if (!form.auth.isLoading) {
                          //bool result = await form.submit();
                          // if (result) {
                          Navigator.pushNamed(
                              context, HomeScreenView.routeName);
                          //}
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        fixedSize: const Size(320, 40),
                        primary: Theme.of(context).primaryColor,
                      ),
                      child: form.auth.isLoading
                          ? SpinKitCircle(
                              color: Colors.white,
                              size: 40,
                            )
                          : Text(
                              "Sign In",
                              style: TextStyle(
                                fontSize: 15,
                              ),
                            ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 30),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Don't have an account?",
                            style: TextStyle(
                                color: HexColor("#5C6E80"), fontSize: 14),
                          ),
                          TextButton(
                            child: Text(
                              'Register',
                              style: TextStyle(
                                fontSize: 14,
                                color: HexColor("#1264A3"),
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            onPressed: () {
                              Navigator.pushNamed(context, SignUp.routeName);
                            },
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          //if (isLoading) LoadingScreen(),
        ],
      ),
    );
  }
}
