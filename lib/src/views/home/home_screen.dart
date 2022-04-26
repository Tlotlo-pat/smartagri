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
import 'package:smartagri/src/views/home/map.dart';

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
    return Scaffold(
        body: SingleChildScrollView(
      child: Column(
        children: [
          Container(
            height: 70,
            width: 414,
            decoration: BoxDecoration(
              color: HexColor("#11544D"),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("SmartAgri",
                    style: GoogleFonts.montserrat(
                        fontSize: 18,
                        //  allowFontScalingSelf: true,

                        fontWeight: FontWeight.bold,
                        color: Colors.white)),
                Icon(
                  FontAwesomeIcons.bell,
                  color: HexColor("#FFFFFF"),
                ),
              ],
            ),
          ),
          SizedBox(height: 20),
          Padding(
            padding: EdgeInsets.only(right: 275),
            child: Text("Hi Molemi",
                style: TextStyle(
                    color: HexColor("#053530"),
                    fontSize: 20,
                    fontWeight: FontWeight.bold)),
          ),
          SizedBox(
            height: 35,
          ),
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: TextField(
              controller: controller,
              style: TextStyle(
                color: Colors.white,
              ),
              decoration: InputDecoration(
                prefixIcon: Icon(
                  FontAwesomeIcons.search,
                  color: HexColor("#AEB3C4"),
                ),
                fillColor: HexColor("#F6F6F6"),
                filled: true,
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(19)),
                    borderSide: BorderSide(color: HexColor("#F6F6F6"))),
                hintText: 'What are you looking for?',
                hintStyle: TextStyle(
                  color: HexColor("#AEB3C4"),
                ),
              ),
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              height: 110,
              width: 414,
              decoration: BoxDecoration(
                color: HexColor("#ECF0F3"),
                borderRadius: BorderRadius.all(Radius.circular(19)),
              ),
              child: Column(
                children: [
                  Padding(
                    padding: EdgeInsets.only(right: 275),
                    child: Text("Welcome!",
                        style: TextStyle(
                            color: HexColor("#80D995"),
                            fontSize: 20,
                            fontWeight: FontWeight.bold)),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Padding(
                    padding: EdgeInsets.only(right: 190, left: 10),
                    child: Text("Manage and track your livestock with ease",
                        style: TextStyle(
                            color: HexColor("#11544D"),
                            fontSize: 14,
                            fontWeight: FontWeight.normal)),
                  )
                ],
              ),
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Padding(
            padding: EdgeInsets.only(right: 265, left: 10),
            child: Text("Notifications",
                style: TextStyle(
                    color: HexColor("#053530"),
                    fontSize: 20,
                    fontWeight: FontWeight.bold)),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            //* disease notifications
            child: Container(
              height: 110,
              width: 414,
              decoration: BoxDecoration(
                color: HexColor("#ECF0F3"),
                borderRadius: BorderRadius.all(Radius.circular(19)),
              ),
              child: Row(
                children: [
                  Padding(
                    padding: EdgeInsets.only(right: 20, left: 30),
                    child: Icon(
                      FontAwesomeIcons.bug,
                      color: HexColor("#11544D"),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(right: 10),
                    child: Text(
                        "It's Pasteurella season, \n remember to vaccinate your livestock! ",
                        style: TextStyle(
                            color: HexColor("#11544D"),
                            fontSize: 14,
                            fontWeight: FontWeight.normal)),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Padding(
            padding: EdgeInsets.only(
              right: 250,
            ),
            child: Text("My Livestock",
                style: TextStyle(
                    color: HexColor("#053530"),
                    fontSize: 20,
                    fontWeight: FontWeight.bold)),
          ),
          SizedBox(
            height: 20,
          ),
          //* cattle information
          Row(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  height: 110,
                  width: 182,
                  decoration: BoxDecoration(
                    color: HexColor("#ECF0F3"),
                    borderRadius: BorderRadius.all(Radius.circular(19)),
                  ),
                  child: Column(children: [
                    Image.asset("assets/Cow.png"),
                    SizedBox(
                      height: 10,
                    ),
                    Icon(
                      FontAwesomeIcons.plus,
                      color: HexColor("#11544D"),
                    ),
                  ]),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: InkWell(
                  onTap: () {
                    Navigator.pushNamed(context, MapD.routeName);
                  },
                  child: Container(
                      height: 110,
                      width: 170,
                      decoration: BoxDecoration(
                        color: HexColor("#11544D"),
                        borderRadius: BorderRadius.all(Radius.circular(19)),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            FontAwesomeIcons.location,
                            color: HexColor("#FFFFFF"),
                          ),
                          Icon(
                            FontAwesomeIcons.map,
                            color: HexColor("#FFFFFF"),
                            size: 45,
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Text("Livestock Tracking",
                              style: TextStyle(
                                  color: HexColor("#FFFFFF"),
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold)),
                        ],
                      )),
                ),
              ),
            ],
          ),
        ],
      ),
    ));
  }
}
