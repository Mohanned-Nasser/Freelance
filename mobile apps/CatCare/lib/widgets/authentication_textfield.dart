
import 'package:catcare/util/app_color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../util/app_style.dart';

authenticationTextField({TextEditingController? controller,String? hint,bool hide=false}){
  return Padding(
    padding: EdgeInsets.only(bottom: 10.h),
    child: SizedBox(
      height: 40.h,
      width: 249.w,
      child: Center(
        child: TextField(
          controller: controller,
           style: authenticationTextFieldStyle(),
          obscureText: hide,
          textAlign: TextAlign.center,
          decoration: InputDecoration(
            enabledBorder: border(),
            focusedBorder: border(),
            disabledBorder: border(),
            hintText: hint,
            contentPadding: EdgeInsets.zero,
            hintStyle: authenticationTextFieldStyle(),
          ),
        ),
      ),
    ),
  );
}

border(){
  return  OutlineInputBorder(
  borderSide: BorderSide(color:AppColors.loginTextColor, width: 1.0),
  );
}