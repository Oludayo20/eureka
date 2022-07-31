class UserApp {
  String? userName;
  String? profilePic;
  String? standard;
  String? section;
  String? email;
  String? password;
  UserApp({
    this.userName,
    this.profilePic,
    this.section,
    this.standard,
    this.email,
    this.password,
  });
}

class CurrentUser {
  String? displayName;
  String? email;
  bool? emailVerified;
  bool? isAnonymous;
  String? uid;
  CurrentUser(
      {this.displayName, this.email, this.emailVerified, this.isAnonymous,this.uid});

  CurrentUser.fromJson(Map<String, dynamic> json) {
    isAnonymous = json['isAnonymous'];
    displayName = json['displayName'] as String;
    email = json['email'] as String;
    emailVerified = json['emailVerified'];
  }
  CurrentUser.fromMap(Map<dynamic, dynamic> json) {
    isAnonymous = json['isAnonymous'];
    displayName = json['displayName'] as String;
    email = json['email'] as String;
    emailVerified = json['emailVerified'];
  }

  Map<String, dynamic> toJson() => <String, dynamic>{
        'isAnonymous': isAnonymous,
        'displayName': displayName,
        'email': email,
        'emailVerified': emailVerified,
      };
}
