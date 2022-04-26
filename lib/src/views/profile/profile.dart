// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_provider_utilities/flutter_provider_utilities.dart';
// import "package:flutter_screenutil/flutter_screenutil.dart";
// import 'package:google_fonts/google_fonts.dart';
// import 'package:hexcolor/hexcolor.dart';
// import 'package:provider/provider.dart';
// import 'package:stepping_stones/src/controllers/auth.dart';
// import 'package:stepping_stones/src/forms/sign_up_form.dart';
// import 'package:stepping_stones/src/models/badge.dart';
// import 'package:stepping_stones/src/views/profile/widgets/badge.dart';
// import 'package:stepping_stones/src/views/profile/widgets/profile_picture.dart';
// import 'package:stepping_stones/src/widgets/dialogs/notification.dart';
// import 'package:stepping_stones/src/widgets/inputs/date_input.dart';
// import 'package:stepping_stones/src/widgets/inputs/phone_input.dart';
// import 'package:stepping_stones/src/widgets/inputs/text_input.dart';

// class Profile extends StatefulWidget {
//   const Profile({Key? key}) : super(key: key);

//   static const String routeName = "/profile";

//   @override
//   State<Profile> createState() => _ProfileState();
// }

// class _ProfileState extends State<Profile> {
//   late Auth auth;
//   late CreateProfileForm form;

//   @override
//   void didChangeDependencies() {
//     super.didChangeDependencies();
//     auth = Provider.of<Auth>(context);
//     form = Provider.of<CreateProfileForm>(context);
//   }

//   @override
//   Widget build(BuildContext context) {
//     return MessageListener<Auth>(
//       showInfo: (message) {
//         showDialog(
//           context: context,
//           builder: (_) => NotificationDialog(
//             type: InfoType.info,
//             message: message,
//           ),
//         );
//       },
//       showError: (message) {
//         showDialog(
//           context: context,
//           builder: (_) => NotificationDialog(
//             type: InfoType.error,
//             message: message,
//           ),
//         );
//       },
//       child: Scaffold(
//         backgroundColor: Colors.indigo,
//         body: CustomScrollView(
//           physics: const ClampingScrollPhysics(),
//           slivers: [
//             SliverAppBar(
//               backgroundColor: Colors.transparent,
//               elevation: 0,
//               title: Text("My Profile", style: GoogleFonts.archivo()),
//               iconTheme: IconThemeData(
//                 color: Theme.of(context).primaryColor,
//               ),
//               bottom: PreferredSize(
//                 preferredSize: Size(double.infinity, 170.h),
//                 child: Column(
//                   children: [
//                     SizedBox(
//                       height: 20.h,
//                     ),
//                     ProfilePicture(
//                       imageUrl: auth.currentUser?.imageUrl,
//                       showEditable: true,
//                     ),
//                     SizedBox(
//                       height: 10.h,
//                     ),
//                     Text(
//                       auth.currentUser!.fullname!,
//                       style: GoogleFonts.archivo(
//                         fontWeight: FontWeight.bold,
//                         fontSize: 20.sp,
//                         color: Colors.white,
//                       ),
//                     ),
//                     SizedBox(
//                       height: 5.h,
//                     ),
//                     Padding(
//                       padding: const EdgeInsets.all(8.0),
//                       child: Text(
//                         auth.currentUser?.screenName ?? "",
//                         style: GoogleFonts.archivo(
//                           fontSize: 16.sp,
//                           color: Colors.white,
//                         ),
//                       ),
//                     )
//                   ],
//                 ),
//               ),
//             ),
//             SliverToBoxAdapter(
//               child: Card(
//                 margin: EdgeInsets.zero,
//                 shape: RoundedRectangleBorder(
//                   borderRadius: BorderRadius.only(
//                     topLeft: Radius.circular(20.r),
//                     topRight: Radius.circular(20.r),
//                   ),
//                 ),
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.stretch,
//                   children: [
//                     SizedBox(
//                       height: 10.h,
//                     ),
//                     Padding(
//                       padding: const EdgeInsets.all(8.0),
//                       child: Row(
//                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                         children: [
//                           Padding(
//                             padding: const EdgeInsets.all(8.0),
//                             child: Text(
//                               "Badges",
//                               style: GoogleFonts.archivo(
//                                 fontWeight: FontWeight.bold,
//                                 fontSize: 20.sp,
//                                 color: Colors.black,
//                               ),
//                             ),
//                           ),
//                           Row(
//                             children: [
//                               Text(
//                                 "Hide Badges",
//                                 style: GoogleFonts.archivo(
//                                   fontStyle: FontStyle.italic,
//                                   fontSize: 10.sp,
//                                   color: HexColor('#97A5B7'),
//                                 ),
//                               ),
//                               Switch.adaptive(
//                                 activeColor: HexColor("#2E89FF"),
//                                 value: auth.showBadges,
//                                 onChanged: auth.toggleBadges,
//                               ),
//                             ],
//                           ),
//                         ],
//                       ),
//                     ),
//                     SizedBox(
//                       height: 100.h,
//                       child: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
//                           stream: FirebaseFirestore.instance
//                               .collection("badges")
//                               .where("bid", whereIn: auth.currentUser?.badges)
//                               .snapshots(),
//                           builder: (context, snapshot) {
//                             if (!snapshot.hasData) {
//                               return Container(
//                                 color: Colors.red,
//                               );
//                             }
//                             return ListView.builder(
//                                 scrollDirection: Axis.horizontal,
//                                 itemCount: snapshot.data?.docs.length,
//                                 itemBuilder: (context, index) {
//                                   final badge = UserBadge.fromJson(
//                                       snapshot.data!.docs[index].data());
//                                   return UserBadgeView(badge: badge);
//                                 });
//                           }),
//                     ),
//                     Padding(
//                       padding: const EdgeInsets.all(8.0),
//                       child: Text(
//                         "Personal Details",
//                         style: GoogleFonts.archivo(
//                           color: HexColor("#2D2F3B"),
//                           fontWeight: FontWeight.bold,
//                           fontSize: 20.sp,
//                         ),
//                       ),
//                     ),
//                     TextInput(
//                       value: form.fullnames.value,
//                       onChanged: form.changeFullnames,
//                       errorText: form.fullnames.error,
//                       label: "full names",
//                       placeholder: "Name Surname",
//                     ),
//                     TextInput(
//                       value: form.screenName.value,
//                       onChanged: form.changeScreenName,
//                       errorText: form.screenName.error,
//                       label: "screen name",
//                       placeholder: "@diginav",
//                     ),
//                     DateInput(
//                       onChanged: form.changeDOB,
//                       value: form.dob.value,
//                       label: "Date Of Birth",
//                       placeholder: '04/01/1997',
//                       errorText: form.dob.error,
//                     ),
//                     Padding(
//                       padding: const EdgeInsets.all(8.0),
//                       child: Text(
//                         "Contact Information",
//                         style: GoogleFonts.archivo(
//                           color: HexColor("#2D2F3B"),
//                           fontWeight: FontWeight.bold,
//                           fontSize: 20.sp,
//                         ),
//                       ),
//                     ),
//                     TextInput(
//                       value: form.email.value,
//                       onChanged: form.changeEmail,
//                       errorText: form.email.error,
//                       label: "Email",
//                       placeholder: "create@diginav.co",
//                     ),
//                     PhoneInput(
//                       value: form.phone.value,
//                       onChanged: form.changePhone,
//                       errorText: form.phone.error,
//                       label: "Phone",
//                       placeholder: "00 000 000",
//                     ),
//                     Padding(
//                       padding: const EdgeInsets.all(8.0),
//                       child: Text(
//                         "Social Media",
//                         style: GoogleFonts.archivo(
//                           color: HexColor("#2D2F3B"),
//                           fontWeight: FontWeight.bold,
//                           fontSize: 20.sp,
//                         ),
//                       ),
//                     ),
//                     _buildSocialMeda(
//                       "assets/icons8-facebook-48.png",
//                       form.socialLinksFacebook.value,
//                       form.changeSocialLinksFb,
//                     ),
//                     _buildSocialMeda(
//                       "assets/icons8-instagram-48.png",
//                       form.socialLinksFacebook.value,
//                       form.changeSocialLinksInsta,
//                     ),
//                     _buildSocialMeda(
//                         "assets/icons8-tiktok-48.png",
//                         form.socialLinksFacebook.value,
//                         form.changeSocialLinksTick),
//                     _buildSocialMeda(
//                         "assets/icons8-twitter-48.png",
//                         form.socialLinksFacebook.value,
//                         form.changeSocialLinksTwitter),
//                     SizedBox(
//                       height: 20.h,
//                     ),
//                     Padding(
//                       padding: const EdgeInsets.all(8.0),
//                       child: ElevatedButton(
//                         onPressed: form.updateUser,
//                         child: Text("Save"),
//                         style: ElevatedButton.styleFrom(
//                           fixedSize: Size(335.w, 40.h),
//                         ),
//                       ),
//                     ),
//                     SizedBox(
//                       height: 50.h,
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   Widget _buildSocialMeda(
//       String asset, String? url, Function(String?) onChanged) {
//     return Padding(
//       padding: const EdgeInsets.all(8.0),
//       child: Row(
//         children: [
//           Container(
//             height: 47.h,
//             width: 47.h,
//             color: HexColor("#EDEFF3"),
//             child: Padding(
//               padding: const EdgeInsets.all(8.0),
//               child: Image.asset(asset),
//             ),
//           ),
//           SizedBox(
//             width: 270.w,
//             child: TextFormField(
//               initialValue: url,
//               onChanged: onChanged,
//               decoration: InputDecoration(
//                 hintText: asset.split("-")[1],
//                 border: const OutlineInputBorder(
//                   borderSide: BorderSide.none,
//                 ),
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
