// import 'package:badges/badges.dart';
// import 'package:cached_network_image/cached_network_image.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:font_awesome_flutter/font_awesome_flutter.dart';
// import 'package:provider/provider.dart';
// import 'package:stepping_stones/src/forms/sign_up_form.dart';

// class ProfilePicture extends StatelessWidget {
//   const ProfilePicture(
//       {Key? key, this.imageUrl, this.height = 50, this.showEditable = false})
//       : super(key: key);
//   final String? imageUrl;
//   final double height;
//   final bool showEditable;

//   @override
//   Widget build(BuildContext context) {
//     final form = Provider.of<CreateProfileForm>(context);
//     return Badge(
//       position: BadgePosition.bottomEnd(),
//       showBadge: showEditable,
//       badgeContent: SizedBox(
//         width: 20.w,
//         child: Center(
//           child: IconButton(
//             iconSize: 10.sp,
//             onPressed: form.updateImage,
//             icon: const Icon(
//               FontAwesomeIcons.pen,
//               color: Colors.white,
//             ),
//           ),
//         ),
//       ),
//       child: CircleAvatar(
//         radius: height,
//         backgroundColor: Colors.white,
//         child: imageUrl == null
//             ? Icon(
//                 FontAwesomeIcons.solidUser,
//                 size: height / .9,
//                 color: Theme.of(context).primaryColor,
//               )
//             : null,
//         backgroundImage: imageUrl != null
//             ? CachedNetworkImageProvider(
//                 imageUrl!,
//               )
//             : null,
//       ),
//     );
//   }
// }
