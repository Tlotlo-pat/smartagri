import 'package:json_annotation/json_annotation.dart';

part 'parts/user.g.dart';

@JsonSerializable()
class User extends Comparable<User> {
  String? uid;
  String? fullname;
  String? email;
  String? phone;
  String? gender;
  String? dob;
  String? screenName;
  List<String?>? socialLinks;
  String? imageUrl;
  int? rating;
  int? agoraID;
  List<String>? badges;

  User(
      {this.uid,
      this.fullname,
      this.email,
      this.phone,
      this.gender,
      this.agoraID,
      this.dob,
      this.screenName,
      this.socialLinks,
      this.badges,
      this.imageUrl,
      this.rating});

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);

  Map<String, dynamic> toJson() => _$UserToJson(this);

  @override
  int compareTo(User other) {
    if (other.rating != null && rating != null) {
      if (other.rating! > rating!) {
        return 1;
      }
    }
    return -1;
  }
}
