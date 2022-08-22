import 'package:catcare/util/app_color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../util/app_style.dart';
Widget customButton({String? text,action}) {
  return GestureDetector(
    onTap:(){
      action();
    },
    child: SizedBox(
      height: 33.h,
      width: 177.w,
      child: Container(
        decoration: BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  AppColors.customBtnStartColor,
                  AppColors.customBtnEndColor
                ]),
          borderRadius: BorderRadius.circular(8.r),
        ),
        child: Center(child: Text(text!,style: fredokaTextStyle(fontSize: 15.sp),)),
      ),
    ),
  );
}
