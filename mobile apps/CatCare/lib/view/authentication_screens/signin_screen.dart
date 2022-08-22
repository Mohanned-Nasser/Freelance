import 'package:catcare/model/user_model.dart';
import 'package:catcare/util/alerts.dart';
import 'package:catcare/util/app_color.dart';
import 'package:catcare/util/app_navigator.dart';
import 'package:catcare/util/asset_path.dart';
import 'package:catcare/util/services/authentication/authentication_service.dart';
import 'package:catcare/view/authentication_screens/signup_screen.dart';
import 'package:catcare/view/home_screen.dart';
import 'package:catcare/widgets/custom_loader.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../util/app_constants.dart';
import '../../widgets/authentication_button.dart';
import '../../widgets/authentication_textfield.dart';
import '../../widgets/authentication_textfield.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({Key? key}) : super(key: key);

  @override
  _SignInScreenState createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {

  @override
  Widget build(BuildContext context) {
    return SafeArea(child: Scaffold(
      backgroundColor: AppColors.appWhiteColor,
      body: Stack(
        children: [

          // logo image
          Positioned(
            top: 0,
            left: 0,
            child: Image.asset(AssetsPath.loginLogo,
              height: 564.h,
              width: 396.w,
              fit: BoxFit.cover,
            ),
          ),


          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              width: 344.w,
              height: 300.h,
              padding: EdgeInsets.symmetric(vertical: 25.h),
              decoration: BoxDecoration(
                color: AppColors.appWhiteColor,
                borderRadius: BorderRadius.only(topLeft: Radius.circular(32.r),topRight:Radius.circular(32.r)),
              ),

              child: Column(
                children: [
                  authenticationTextField(controller: txtEmail,hint: "Email"),
                  authenticationTextField(controller: txtPassword,hint: "Password",hide: true),
                  authenticationButton(text: "Login",action: (){
                    siginAction();
                  },),
                  Text('OR'),
                  SizedBox(height: 10.h,),
                  authenticationButton(text: "Register",action: (){
                    AppNavigator.push(context, SignupScreen());
                  },isPrimary: false),


                ],
              ),
            ),
          )
        ],
      ),
    ));
  }


  final txtEmail=TextEditingController();
  final txtPassword=TextEditingController();
  String? email,password;

  getValues(){
    email=txtEmail.text.trim();
    password=txtPassword.text;
  }
  isEmpty(){
    if(email!.isEmpty||password!.isEmpty){
      return true;
    }else{
      return false;
    }
  }

  siginAction() async {
    getValues();
    if(isEmpty()){
      MyAlerts.showInfoBox(context,"Please enter email and password.");
    }else{
      if(email!.toLowerCase()=="admin@admin.com"&&password=="admin1234"){
        MyConstant.isAdmin=true;
        AuthenticationService.saveAdmin();
        AppNavigator.makeFirst(context,HomeScreen(isAdmin: true,));
      }else{
        // show loading
        customLoadingIndicator(context);
        bool result=await AuthenticationService.signInWithEmailAndPassword(context, email!, password!);
        if(result) {
          MyConstant.currentUserModel = await UserModel.getUserInfo(MyConstant.currentUserID);
          Navigator.pop(context);
            MyConstant.isAdmin=false;
            AppNavigator.makeFirst(context,HomeScreen(isAdmin: false,));
        }

      }
    }
  }
}
