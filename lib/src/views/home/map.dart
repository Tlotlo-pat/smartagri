// ignore_for_file: constant_identifier_names
import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:provider/provider.dart';
import 'package:smartagri/src/controllers/auth.dart';
//import 'package:smartagric/src/controllers/auth.dart';

class MapD extends StatefulWidget {
  const MapD({
    Key? key,
  }) : super(key: key);
  static const String routeName = "/map";

  @override
  State<MapD> createState() => _MapDState();
}

class _MapDState extends State<MapD> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  Completer<GoogleMapController> _controller = Completer();

  static const LatLng _center =
      const LatLng(-24.678217307543953, 25.922147033251843);

  void _onMapCreated(GoogleMapController controller) {
    _controller.complete(controller);
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final auth = Provider.of<Auth>(context);
    return SafeArea(
      child: Scaffold(
          backgroundColor: HexColor("#2D2F3B"),
          body: SingleChildScrollView(
            child: Container(
              constraints: BoxConstraints(
                minHeight: MediaQuery.of(context).size.height,
              ),
              child: Stack(
                alignment: Alignment.bottomCenter,
                children: [
                  //* map
                  Container(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height,
                    child: GoogleMap(
                      onMapCreated: _onMapCreated,
                      mapType: MapType.normal,
                      markers: Set<Marker>.of(
                        [
                          Marker(
                            markerId: MarkerId("1"),
                            position:
                                LatLng(-24.678217307543953, 25.922147033251843),
                            infoWindow: InfoWindow(
                              title: "Cattle 111",
                              snippet: "Tag:",
                            ),
                          ),
                        ],
                      ),
                      initialCameraPosition: CameraPosition(
                        target: _center,
                        zoom: 11.0,
                      ),
                    ),
                  ),
                  Container(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              // //* search bar
                              // Padding(
                              //   padding: const EdgeInsets.all(15.0),
                              //   child: TextField(
                              //     //controller: controller,
                              //     style: TextStyle(
                              //       color: Colors.white,
                              //     ),
                              //     decoration: InputDecoration(
                              //       prefixIcon: Icon(
                              //         FontAwesomeIcons.search,
                              //         color: HexColor("#2E89FF"),
                              //       ),
                              //       fillColor: HexColor("#F6F7F9"),
                              //       filled: true,
                              //       border: OutlineInputBorder(
                              //           borderRadius: BorderRadius.all(
                              //               Radius.circular(10)),
                              //           borderSide: BorderSide(
                              //               color: HexColor("#F6F7F9"))),
                              //       hintText: 'Search',
                              //       hintStyle: TextStyle(
                              //         color: HexColor("#C3C8D2"),
                              //       ),
                              //     ),
                              //   ),
                              // ),

                              //* location
                              Padding(
                                padding: EdgeInsets.only(
                                  top: 20,
                                  left: 10,
                                  right: 262,
                                ),
                                child: Text("Locate",
                                    style: GoogleFonts.archivo(
                                      fontSize: 14,
                                      color: HexColor("#263245"),
                                      fontWeight: FontWeight.bold,
                                    )),
                              ),
                              SizedBox(
                                height: 15,
                              ),
                              Padding(
                                padding: EdgeInsets.only(top: 10, bottom: 10),
                                child: Container(
                                  child: Row(children: [
                                    Padding(
                                      padding: EdgeInsets.only(
                                        left: 15,
                                        right: 15,
                                      ),
                                      child: Container(
                                        child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Icon(Icons.location_on,
                                                  color: HexColor("#FFFFFF"))
                                            ]),
                                        height: 39.9,
                                        width: 39.9,
                                        decoration: BoxDecoration(
                                            color: HexColor("#80D995"),
                                            shape: BoxShape.circle),
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.only(right: 40),
                                      child: Text("Cattle 111       1.5km away",
                                          style: GoogleFonts.archivo(
                                            fontSize: 12,
                                            color: HexColor("#FFFFFF"),
                                            fontWeight: FontWeight.bold,
                                          )),
                                    ),
                                  ]),
                                  height: 60,
                                  width: 335,
                                  decoration: BoxDecoration(
                                    color: HexColor("#11544D"),
                                    borderRadius: BorderRadius.circular(20.0),
                                  ),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.only(top: 10, bottom: 10),
                                child: Container(
                                  child: Row(children: [
                                    Padding(
                                      padding: EdgeInsets.only(
                                        left: 15,
                                        right: 15,
                                      ),
                                      child: Container(
                                        child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Icon(Icons.location_on,
                                                  color: HexColor("#FFFFFF"))
                                            ]),
                                        height: 39.9,
                                        width: 39.9,
                                        decoration: BoxDecoration(
                                            color: HexColor("#80D995"),
                                            shape: BoxShape.circle),
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.only(right: 40),
                                      child:
                                          Text("Sheep 100       0.700km away",
                                              style: GoogleFonts.archivo(
                                                fontSize: 12,
                                                color: HexColor("#FFFFFF"),
                                                fontWeight: FontWeight.bold,
                                              )),
                                    ),
                                  ]),
                                  height: 60,
                                  width: 335,
                                  decoration: BoxDecoration(
                                    color: HexColor("#11544D"),
                                    borderRadius: BorderRadius.circular(20.0),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          decoration: BoxDecoration(
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.5),
                                spreadRadius: 9,
                                blurRadius: 15,
                                offset:
                                    Offset(0, 0), // changes position of shadow
                              ),
                            ],
                            border: Border.all(
                              color: HexColor("#FFFFFF"),
                            ),
                            color: HexColor("#FFFFFF"),
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(20),
                              topRight: Radius.circular(20),
                            ),
                          ),
                          width: 375,
                          height: 250,
                        ),
                      ],
                    ),
                    decoration: BoxDecoration(
                        color: HexColor("#FFFFFF"),
                        borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(20),
                            bottomRight: Radius.circular(20))),
                    width: 375,
                    // height: 269.h,
                  ), //Container
                ],
              ),
            ),
          )),
    );
  }
}
