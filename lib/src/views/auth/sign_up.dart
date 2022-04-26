import 'package:flutter/material.dart';
import 'package:flutter_provider_utilities/flutter_provider_utilities.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:smartagri/src/controllers/auth.dart';
import 'package:smartagri/src/forms/sign_in_form.dart';
import 'package:smartagri/src/forms/sign_up_form.dart';

import 'package:smartagri/src/views/auth/sign_in.dart';
import 'package:smartagri/src/views/home/home_screen.dart';
import 'package:smartagri/src/widgets/dialogs/notification.dart';
import 'package:smartagri/src/widgets/inputs/date_input.dart';
import 'package:smartagri/src/widgets/inputs/phone_input.dart';
import 'package:smartagri/src/widgets/inputs/text_input.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_provider_utilities/flutter_provider_utilities.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:provider/provider.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:smartagri/src/widgets/formlayout.dart';

class SignUp extends StatefulWidget {
  @override
  _SignUpState createState() => _SignUpState();
  static const String routeName = "/sign_up";
}

class _SignUpState extends State<SignUp> {
  // late UserValidator userValidator;
  late CreateProfileForm form;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    form = Provider.of<CreateProfileForm>(context);
    final auth = Provider.of<Auth>(context);
    // userValidator = Provider.of<UserValidator>(context);
  }

  @override
  Widget build(BuildContext context) {
    // provides validation functions for form
    final _auth = Provider.of<Auth>(context, listen: true);
    final _size = MediaQuery.of(context).size;
    return MessageListener<Auth>(
      showError: (info) {
        showDialog(
          context: context,
          builder: (_) => const HomeScreenView(
            text: "Account Created Successfully",
          ),
        );
        ;
      },
      showInfo: (info) {
        if ("Account Created Successfully" == info) {
          showDialog(
            context: context,
            builder: (_) => const HomeScreenView(
              text: "Account Created Successfully",
            ),
          );
        } else {
          showDialog(
            context: context,
            builder: (c) =>
                NotificationDialog(type: InfoType.info, message: info),
          );
        }
      },
      child: Stack(
        children: [
          FormLayout(
            title: "Create A Profile",
            form: Flex(
              direction: Axis.vertical,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.only(bottom: 5),
                  child: Text(
                    'Welcome',
                    style: TextStyle(
                      color: HexColor('#5C6E80'),
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(bottom: 10),
                  child: Text(
                    'Hello there. Register to continue',
                    style: TextStyle(
                      fontSize: 12,
                      color: HexColor('#A5AFBD'),
                    ),
                  ),
                ),
                TextInput(
                  value: form.fullnames.value,
                  onChanged: form.changeFullnames,
                  errorText: form.fullnames.error,
                  label: "Fullnames",
                  placeholder: "Name Surname",
                ),
                TextInput(
                  value: form.email.value,
                  onChanged: form.changeEmail,
                  errorText: form.email.error,
                  label: "Email",
                  placeholder: "tlotlo@gmail.com",
                ),
                PhoneInput(
                  value: form.phone.value,
                  onChanged: form.changePhone,
                  errorText: form.phone.error,
                  label: "Phone",
                  placeholder: "00 000 000",
                ),
                TextInput(
                  value: form.password.value,
                  onChanged: form.changePassword,
                  errorText: form.password.error,
                  label: "Password",
                  placeholder: "Enter password of length 6 or more",
                  isPassword: true,
                ),
                TextInput(
                  value: form.confirmPassword.value,
                  onChanged: form.changeConfirmPassword,
                  errorText: form.confirmPassword.error,
                  label: "Confirm Password",
                  placeholder: "Enter matching password",
                  isPassword: true,
                ),
                SizedBox(
                  height: 10,
                ),

                Padding(
                  padding: EdgeInsets.only(top: 10),
                  child: ElevatedButton(
                    onPressed: () async {
                      if (form.isValid()) {
                        if (form.password.value == form.confirmPassword.value) {
                          await form.submit();
                        } else {
                          showDialog(
                            context: context,
                            builder: (_) => NotificationDialog(
                              type: InfoType.info,
                              message: "Please fill all the fields",
                            ),
                          );
                        }
                      } else {
                        form.auth.notifyError("please fill out more");
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      fixedSize: Size(320, 40),
                      //primary: Theme.of(context).primaryColor,
                    ),
                    child: Text(
                      "Create Account",
                      style: TextStyle(
                        fontSize: 15,
                      ),
                    ),
                  ),
                ),

                SizedBox(
                  height: 10,
                ),

                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Already have an account?',
                      style: TextStyle(
                        fontSize: 14,
                        color: HexColor('#5C6E80'),
                      ),
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.pushNamed(context, SignIn.routeName);
                      },
                      child: Text(
                        'Sign In',
                        style: TextStyle(
                          fontSize: 14,
                          color: HexColor("#1264A3"),
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    )
                  ],
                ),

                // TextButton(
                //   onPressed: () {
                //     Navigator.push(
                //       context,
                //       MaterialPageRoute(
                //         builder: (_) =>
                //             ChangeNotifierProxyProvider<Auth, RepUserValidator>(
                //           update: (_, value, previous) =>
                //               RepUserValidator(userValidator.auth),
                //           create: (_) => RepUserValidator(userValidator.auth),
                //           child: Representative(),
                //         ),
                //       ),
                //     );
                //   },
                //   style: TextButton.styleFrom(
                //     alignment: Alignment.center,
                //     //backgroundColor: Colors.red,
                //     fixedSize: Size(335.w, 40.h),
                //   ),
                //   child: Text(
                //     'Investing on behalf of someone else?',
                //     style: TextStyle(
                //       fontSize: 14.sp,
                //       color: HexColor("#1264A3"),
                //     ),
                //   ),
                // )
              ],
            ),
          ),
          //  if (_auth.isLoading == true) LoadingScreen()
        ],
      ),
    );
  }
}
