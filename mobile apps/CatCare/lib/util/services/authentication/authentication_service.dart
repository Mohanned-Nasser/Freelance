
import 'package:catcare/model/cat_model.dart';
import 'package:catcare/util/alerts.dart';
import 'package:catcare/util/app_constants.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';


class AuthenticationService{
  static final FirebaseAuth auth = FirebaseAuth.instance;

  static Future<bool> createUserWithEmailAndPassword(BuildContext context,String email,String password) async {
    try {
      UserCredential result =await auth.createUserWithEmailAndPassword(email:email, password:password);
      final User user = result.user!;
      MyConstant.currentUserID=user.uid;
      CatModel.getCatInfo();
      print("created successfully");
      saveUser(user.uid);
      return true;
    } on FirebaseAuthException catch (e) {
      Navigator.pop(context);
      if (e.code == 'weak-password') {
        MyAlerts.showInfoBox(context,"The password provided is too weak.");
        return false;
      } else if (e.code == 'email-already-in-use') {
        MyAlerts.showInfoBox(context,"The account already exists for that email.");
        return false;
      } else if (e.code == 'invalid-email') {
        MyAlerts.showInfoBox(context,"Please enter valid email address");
        return false;
      }else{
        MyAlerts.showInfoBox(context,e.toString());
        return false;
      }
    } catch (e) {
      print(e.toString());
      MyAlerts.showInfoBox(context,e.toString());
      return false;
    }
    return false;
  }



  static Future<bool> signInWithEmailAndPassword(BuildContext context,String email,String password) async {

    try {
      UserCredential result = await auth.signInWithEmailAndPassword(
          email: email,
          password: password
      );
      final User user = result.user!;
      MyConstant.currentUserID=user.uid;
      CatModel.getCatInfo();
      saveUser(user.uid);
      return true;
    } on FirebaseAuthException catch (e) {
      Navigator.pop(context);
      if (e.code == 'user-not-found') {
        MyAlerts.showInfoBox(context,'No user found for that email.');
        return false;
      } else if (e.code == 'wrong-password') {
        MyAlerts.showInfoBox(context,'Wrong password provided for that user.');
        return false;
      } else if (e.code == 'invalid-email') {
        MyAlerts.showInfoBox(context,"Please enter valid email address");
        return false;
      }
      else{
        MyAlerts.showInfoBox(context,e.toString());
        return false;
      }
    }catch (e) {
      print("Error is ${e.toString()}");
      MyAlerts.showInfoBox(context,e.toString());
      return false;
    }
    return false;
  }






  static Future<bool> resetPassword(BuildContext context,String email) async {
    try {
      await auth.sendPasswordResetEmail(email: email);

      return true;
    }on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        MyAlerts.showInfoBox(context,'No user found for that email.');
        return false;
      } else if (e.code == 'wrong-password') {
        MyAlerts.showInfoBox(context,'Password/Username is in correct');
        return false;
      }else{
        MyAlerts.showInfoBox(context,e.toString());
        return false;
      }
    }catch (e) {
      print("Error is ${e.toString()}");
      MyAlerts.showInfoBox(context,e.toString());
      return false;
    }
  }


  static Future<bool> saveUser(String userID) async {
    try{
      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setString("userID", userID);
      return true;
    }catch(e){
      print(e);
      return false;
    }
  }
 static Future<bool> saveAdmin() async {
    try{
      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setBool("isAdmin", true);
      return true;
    }catch(e){
      print(e);
      return false;
    }
  } static Future<bool> isAdmin() async {
    try{
      SharedPreferences prefs = await SharedPreferences.getInstance();
      return prefs.getBool("isAdmin")??false;
    }catch(e){
      print(e);
      return false;
    }
  }



  static Future<bool> logoutUser() async {
    try{
      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setString('userID', '');
      return true;
    }catch(e){
      print(e);
      return false;
    }
  }



}