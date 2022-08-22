import 'package:catcare/util/app_color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../util/app_style.dart';

authenticationButton({String? text,action, bool isPrimary = true}) {
  return GestureDetector(
    onTap:(){
      action();
    },
    child: Padding(
        padding: EdgeInsets.only(bottom: 10.h),
        child: SizedBox(
          height: 45.h,
          width: 249.w,
          child: Container(
            decoration: BoxDecoration(
              color: isPrimary
                  ? AppColors.loginBtnPrimaryColor
                  : AppColors.loginBtnSecondaryColor,
              borderRadius: BorderRadius.circular(8.r),
            ),
            child: Center(child: Text(text!,style: authenticationBtnTextStyle(),)),
          ),
        )),
  );
}
