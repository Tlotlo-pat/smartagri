// import 'package:cached_network_image/cached_network_image.dart';
// import 'package:flutter/material.dart';
// import "package:flutter_screenutil/flutter_screenutil.dart";
// import 'package:google_fonts/google_fonts.dart';
// import 'package:hexcolor/hexcolor.dart';
// import 'package:stepping_stones/src/models/badge.dart';

// class UserBadgeView extends StatelessWidget {
//   const UserBadgeView({Key? key, required this.badge}) : super(key: key);
//   final UserBadge badge;

//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.all(8.0),
//       child: Container(
//         child: SizedBox(
//           height: 94.h,
//           width: 94.h,
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               CircleAvatar(
//                 backgroundColor: Colors.white,
//                 radius: 25.w,
//                 child: CachedNetworkImage(
//                   imageUrl: badge.imageUrl!,
//                   height: 30.h,
//                   width: 30.h,
//                 ),
//               ),
//               Text(
//                 badge.name,
//                 style: GoogleFonts.archivo(
//                   color: Colors.white,
//                   fontSize: 8.sp,
//                   fontWeight: FontWeight.bold,
//                 ),
//               ),
//               SizedBox(
//                 height: 4.h,
//               ),
//               Text(
//                 badge.description!,
//                 style: GoogleFonts.archivo(
//                   color: Colors.white,
//                   fontSize: 7.sp,
//                 ),
//               ),
//             ],
//           ),
//         ),
//         decoration: BoxDecoration(
//           borderRadius: BorderRadius.circular(15.r),
//           gradient: LinearGradient(
//             colors: badge.gradient.map<Color>((e) => HexColor(e)).toList(),
//             begin: Alignment.topLeft,
//             end: Alignment.bottomRight,
//           ),
//         ),
//       ),
//     );
//   }
// }
