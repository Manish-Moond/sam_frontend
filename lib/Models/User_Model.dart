import 'package:localstorage/localstorage.dart';

class UserModel {
  final String userId;
  final String fullName;
  final String emailId;
  final String profileURL;

  UserModel(
      {required this.userId,
      required this.fullName,
      required this.emailId,
      this.profileURL = ''});

  // geting user id from localStorage
  static String getUserId() {
    final storage = LocalStorage("sam");
    return UserModel.fromJson(storage.getItem("user")).userId;
  }

  // geting group id from localStorage
  static String getGroupId() {
    final storage = LocalStorage("sam");
    String grpId = storage.getItem("groupId");
    return grpId;
  }

  // geting user from localStorage
  static UserModel getUser() {
    final storage = LocalStorage("sam");
    return UserModel.fromJson(storage.getItem("user"));
  }

  static Future<UserModel> getUserFromLocalStorage() async {
    final storage = LocalStorage('sam');
    await storage.ready;
    final userJson = storage.getItem('user');
    return UserModel.fromJson(userJson);
  }

  static Future<String> getUserIdFromLocalStorage() async {
    final storage = LocalStorage('sam');
    await storage.ready;
    final userJson = storage.getItem('user');
    return (UserModel.fromJson(userJson)).userId;
  }

  // convert userModel object to JSON format
  Map<String, dynamic> toJson() {
    return ({
      'userId': userId,
      'fullName': fullName,
      'emailId': emailId,
      'profileImage': profileURL
    });
  }

  // convert JSON to userModel object
  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      userId: json['userId'] as String,
      fullName: json['fullName'] as String,
      emailId: json['emailId'] as String,
      profileURL: json['profileImage'] as String,
    );
  }
}
