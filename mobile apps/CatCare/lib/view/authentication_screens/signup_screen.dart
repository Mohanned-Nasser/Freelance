import 'package:catcare/model/user_model.dart';
import 'package:catcare/util/alerts.dart';
import 'package:catcare/util/app_color.dart';
import 'package:catcare/util/app_navigator.dart';
import 'package:catcare/util/asset_path.dart';
import 'package:catcare/util/services/authentication/authentication_service.dart';
import 'package:catcare/view/home_screen.dart';
import 'package:catcare/widgets/custom_loader.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../util/app_constants.dart';
import '../../widgets/authentication_button.dart';
import '../../widgets/authentication_textfield.dart';
import '../../widgets/authentication_textfield.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({Key? key}) : super(key: key);

  @override
  _SignupScreenState createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {

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
              padding: EdgeInsets.only(top: 25.h),
              decoration: BoxDecoration(
                color: AppColors.appWhiteColor,
                borderRadius: BorderRadius.only(topLeft: Radius.circular(32.r),topRight:Radius.circular(32.r)),
              ),

              child: FittedBox(
                child: Column(
                  children: [
                    authenticationTextField(controller: txtEmail,hint: "Email"),
                    authenticationTextField(controller: txtPassword,hint: "Password",hide: true),
                    authenticationTextField(controller: txtConfirmPassword,hint: "Confirm Password",hide: true),

                    authenticationButton(text: "Register",action: (){
                      signUpAction();
                    },),
                    Text('OR'),
                    SizedBox(height: 10.h,),
                    authenticationButton(text: "Already have an account? Login",action: (){
                      AppNavigator.pop(context);
                    },isPrimary: false),



                  ],
                ),
              ),
            ),
          )
        ],
      ),
    ));
  }


  final txtEmail=TextEditingController();
  final txtPassword=TextEditingController();
  final txtConfirmPassword=TextEditingController();
  String? email,password,confirmPassword;

  getValues(){
    email=txtEmail.text.trim();
    password=txtPassword.text;
    confirmPassword=txtConfirmPassword.text;

  }
  isEmpty(){
    if(email!.isEmpty||password!.isEmpty){
      return true;
    }else{
      return false;
    }
  }
  isPasswordMatches(){
    if(password==confirmPassword){
      return true;
    }
    return false;
  }

  signUpAction() async {
    getValues();
    if(isEmpty()){
      MyAlerts.showInfoBox(context,"Please enter email and password.");
    }else{
      if(isPasswordMatches()) {

        // show loading
         customLoadingIndicator(context);
        bool result=await AuthenticationService.createUserWithEmailAndPassword(context, email!, password!);
        if(result) {
          UserModel userModel = UserModel(
              email: email,
              userId: MyConstant.currentUserID
          );
          result=await userModel.addUser(context: context);
          Navigator.pop(context);
          if(result) {
            MyConstant.isAdmin = false;
            AppNavigator.makeFirst(context, HomeScreen(isAdmin: false,));
          }
        }

      }else{
        MyAlerts.showInfoBox(context,"Password doesn't matched");
      }
    }
  }
}
