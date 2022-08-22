
import 'package:catcare/model/cat_model.dart';
import 'package:catcare/model/user_model.dart';
import 'package:catcare/util/app_constants.dart';
import 'package:catcare/util/services/authentication/authentication_service.dart';
import 'package:catcare/view/authentication_screens/signin_screen.dart';
import 'package:catcare/view/home_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shared_preferences/shared_preferences.dart';


Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();


  SharedPreferences prefs = await SharedPreferences.getInstance();
  var userID = prefs.getString('userID')??'';
  bool isAdmin=false;
  if(userID!=''){
    MyConstant.currentUserModel= await UserModel.getUserInfo(userID);
    MyConstant.currentUserID=userID;
    isAdmin=await AuthenticationService.isAdmin();
     CatModel.getCatInfo();
  }

  runApp(
      ScreenUtilInit(
          designSize: const Size(375, 751),
          builder: (context,child) {
            return MaterialApp(
              title: 'Cat Care',
              theme: ThemeData(
                textTheme: Typography.englishLike2018.apply(fontSizeFactor: 1.sp),
              ),
              home:userID.isEmpty?SignInScreen():HomeScreen(isAdmin: isAdmin?true:false,),
            );
          }
      )
  );
}
