// ignore_for_file: prefer_const_constructors, unused_local_variable

import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';

import 'package:provider/provider.dart';

import 'package:smartagri/src/controllers/auth.dart';

import '../profile/widgets/profile_picture.dart';

class HomeScreenView extends StatefulWidget {
  const HomeScreenView({
    Key? key,
    required String text,
  }) : super(key: key);
  static const String routeName = "/home";

  @override
  State<HomeScreenView> createState() => _HomeScreenViewState();
}

class _HomeScreenViewState extends State<HomeScreenView>
    with TickerProviderStateMixin {
  DateTime now = DateTime.now();
  TextEditingController controller = TextEditingController();

  late AnimationController _animationController;
  int currentPage = 0;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  var currentUser = FirebaseAuth.instance.currentUser;
  final quoteRef = FirebaseFirestore.instance.collection('quotes');
  late String name;
  late String quote;

  @override
  void initState() {
    super.initState();
    name = "";
    quote = "";
    //getQuotes();
    initUser();

    _animationController = AnimationController(
      vsync: this,
      duration: Duration(seconds: 1),
    );
  }

  //* get random quote from database
  Future<String> getQuotes() async {
    final QuerySnapshot doc = await quoteRef.get();
    Map<String, dynamic> _quote = doc.docs[Random().nextInt(doc.docs.length)]
        .data() as Map<String, dynamic>;
    return _quote["quote"];
  }

  //* return greeting by time
  _greeting() {
    String greeting = "";
    var timeNow = DateTime.now().hour;

    if (timeNow >= 0 && timeNow <= 11) {
      // greeting = "Good Morning";
      return "Good Morning,";
    } else if (timeNow >= 11 && timeNow <= 17) {
      // greeting = "Good Afternoon";
      return "Good Afternoon,";
    } else if (timeNow >= 17 && timeNow <= 20) {
      //greeting = "Good Evening";
      return "Good Evening,";
    } else if (timeNow >= 20 && timeNow <= 23) {
      // greeting = "Good Night";
      return "Good Night,";
    }
  }

  //* fetch users from the database

  initUser() async {
    currentUser = _auth.currentUser;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text("hgfdsfghjkl"),
    );
  }
}
