import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hexcolor/hexcolor.dart';

class FormLayout extends StatefulWidget {
  const FormLayout({Key? key, this.form, this.title, this.showBackArrow = true})
      : super(key: key);
  final form;
  final title;
  final bool showBackArrow;

  @override
  _FormLayoutState createState() => _FormLayoutState();
}

class _FormLayoutState extends State<FormLayout> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return SafeArea(
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            stops: [
              0.4,
              0.4,
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              HexColor('#11544D'),
              Colors.white,
            ],
          ),
        ),
        child: Scaffold(
          backgroundColor: Colors.transparent,
          body: Stack(
            children: [
              CustomScrollView(
                physics: ClampingScrollPhysics(),
                slivers: [
                  SliverAppBar(
                    backgroundColor: Colors.transparent,
                    elevation: 0,
                    toolbarHeight: 100,
                    collapsedHeight: 140,
                    leading: widget.showBackArrow
                        ? IconButton(
                            iconSize: 30,
                            icon: Icon(
                              Icons.arrow_back_rounded,
                            ),
                            onPressed: () {
                              Navigator.pop(context);
                            },
                          )
                        : null,
                    actions: [
                      //Logo(),
                    ],
                    floating: false,
                    stretch: false,
                    onStretchTrigger: () {
                      // Function callback for stretch
                      return Future<void>.value();
                    },
                    expandedHeight: 233,
                    pinned: false,
                    flexibleSpace: FlexibleSpaceBar(
                      titlePadding: EdgeInsets.only(
                        left: 20,
                        bottom: 30,
                      ),
                      title: widget.title != null
                          ? Container(
                              width: double.infinity,
                              //color: Colors.red,
                              child: Text(
                                widget.title,
                                style: TextStyle(
                                  fontSize: 14,
                                ),
                              ),
                            )
                          : null,
                      centerTitle: true,
                      background: Image.asset(
                        "assets/Background.png",
                        //color: Colors.red.withOpacity(.7),
                        alignment: Alignment.topCenter,
                        fit: BoxFit.cover,
                      ),
                      collapseMode: CollapseMode.pin,
                      stretchModes: const <StretchMode>[
                        // StretchMode.zoomBackground,
                        // StretchMode.blurBackground,
                        StretchMode.blurBackground,
                      ],
                    ),
                    //centerTitle: true,

                    //title: Text(header),
                    //collapsedHeight: 100,
                  ),
                  SliverList(
                    delegate: SliverChildListDelegate(
                      [
                        Card(
                          color: Colors.white,
                          elevation: 0,
                          margin: EdgeInsets.zero,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(20),
                              topRight: Radius.circular(20),
                            ),
                          ),
                          child: Container(
                            constraints: BoxConstraints(minHeight: 430),
                            child: Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 20, vertical: 15),
                              child: widget.form,
                            ),
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
