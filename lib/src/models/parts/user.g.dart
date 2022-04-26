// GENERATED CODE - DO NOT MODIFY BY HAND

part of '../user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

User _$UserFromJson(Map<String, dynamic> json) => User(
      uid: json['uid'] as String?,
      badges:
          (json['badges'] as List<dynamic>?)?.map((e) => e as String).toList(),
      fullname: json['fullname'] as String?,
      email: json['email'] as String?,
      phone: json['phone'] as String?,
      gender: json['gender'] as String?,
      dob: json['dob'] as String?,
      screenName: json['screenName'] as String?,
      // socialLinks: (json['socialLinks'] as List<dynamic>?)
      //     ?.map((e) => e as String)
      //     .toList(),
      imageUrl: json['imageUrl'] as String?,
      rating: json['rating'] as int?,
      agoraID: json['agoraID'] as int?,
    );

Map<String, dynamic> _$UserToJson(User instance) => <String, dynamic>{
      'uid': instance.uid,
      'fullname': instance.fullname,
      'email': instance.email,
      'phone': instance.phone,
      'gender': instance.gender,
      'dob': instance.dob,
      'screenName': instance.screenName,
      'socialLinks': instance.socialLinks,
      'imageUrl': instance.imageUrl,
      'rating': instance.rating,
      "badges": instance.badges,
      "agoraID": instance.agoraID,
    };
