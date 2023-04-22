import 'dart:io';
import 'businessLayer/global.dart' as global;


class CurrentUser {
  int? id;
  String? firstname;
  String? lastname;
  String? phone;
  String? email;
  String? password;
  String? userType;
  String? bio;
  int? isVerified;
  String? token;
  String? tokenExpiration;
  String? createdAt;
  String? currentSchoolLevel;
  String? nameOfSchool;
  String? discipline;
  String? photo;
  String? photoPath;
  String? accessToken;

  CurrentUser(
      {this.id,
        this.firstname,
        this.lastname,
        this.phone,
        this.email,
        this.password,
        this.userType,
        this.bio,
        this.isVerified,
        this.token,
        this.tokenExpiration,
        this.createdAt,
        this.currentSchoolLevel,
        this.nameOfSchool,
        this.discipline,
        this.photo,
        this.photoPath,
        this.accessToken});

  CurrentUser.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    firstname = json['firstname'];
    lastname = json['lastname'];
    phone = json['phone'];
    email = json['email'];
    password = json['password'];
    userType = json['user_type'];
    bio = json['bio'];
    isVerified = json['is_verified'];
    token = json['token'];
    tokenExpiration = json['token_expiration'];
    createdAt = json['created_at'];
    currentSchoolLevel = json['current_school_level'];
    nameOfSchool = json['name_of_school'];
    discipline = json['discipline'];
    photo = json['photo'];
    photoPath = json['photo_path'];
    accessToken = json['access_token'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['firstname'] = this.firstname;
    data['lastname'] = this.lastname;
    data['phone'] = this.phone;
    data['email'] = this.email;
    data['password'] = this.password;
    data['user_type'] = this.userType;
    data['bio'] = this.bio;
    data['is_verified'] = this.isVerified;
    data['token'] = this.token;
    data['token_expiration'] = this.tokenExpiration;
    data['created_at'] = this.createdAt;
    data['current_school_level'] = this.currentSchoolLevel;
    data['name_of_school'] = this.nameOfSchool;
    data['discipline'] = this.discipline;
    data['photo'] = this.photo;
    data['photo_path'] = this.photoPath;
    data['access_token'] = this.accessToken;
    return data;
  }
}


