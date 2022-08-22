import 'package:catcare/model/cat_model.dart';
import 'package:catcare/util/alerts.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  String? userId;
  String? email;

  UserModel({this.userId, this.email});

  UserModel.fromJson(Map<String, dynamic> json) {
    userId = json['userId'];
    email = json['email'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['userId'] = this.userId;
    data['email'] = this.email;
    data['timestamp'] = Timestamp.now();
    return data;
  }

  static CollectionReference users =
      FirebaseFirestore.instance.collection('users');

  Future<bool> addUser({required context}) async {
    try {
      await users.doc(userId).set(toJson());
      return true;
    } catch (e) {
      MyAlerts.showInfoBox(context, e.toString());
      return false;
    }
  }

 static Future<UserModel> getUserInfo(userId) async {
    try {
      DocumentSnapshot documentSnapshot=await users.doc(userId).get();
      return UserModel.fromJson(documentSnapshot.data() as Map<String, dynamic>);
    } catch (e) {
      print(e.toString());
      return UserModel();
    }
  }
}
