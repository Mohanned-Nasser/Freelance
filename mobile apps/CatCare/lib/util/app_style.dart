import 'package:catcare/util/app_color.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';


gradientBackground(){
  return BoxDecoration(
      gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            AppColors.appGradientStartColor,
            AppColors.appGradientEndColor,
            AppColors.appWhiteColor
          ]));
}
TextStyle authenticationTextFieldStyle({double? fontSize}) {
  return TextStyle(
      color: AppColors.loginTextColor,
      fontSize: fontSize??15.sp,
      fontWeight: FontWeight.w500,
      fontFamily: 'Epilogue'
  );
}
TextStyle appbarTitleStyle() {
  return TextStyle(
      fontSize: 25.sp,
      fontFamily: 'FredokaOne'
  );
}
TextStyle homeContainerStyle() {
  return TextStyle(
      fontSize: 13.sp,
      fontFamily: 'FredokaOne'
  );
}
TextStyle fredokaTextStyle({double? fontSize}) {
  return TextStyle(
      fontSize: fontSize??13.sp,
      fontFamily: 'FredokaOne'
  );
}TextStyle epilogueTextStyle({double? fontSize,FontWeight fontWeight=FontWeight.normal,Color color=Colors.black}) {
  return TextStyle(
      fontSize: fontSize??10.sp,
      fontFamily: 'Epilogue',
      fontWeight:fontWeight,
      color:color,
  );
}
TextStyle authenticationBtnTextStyle() {
  return TextStyle(
      color: AppColors.appWhiteColor,
      fontSize: 15.sp,
      fontWeight: FontWeight.bold,
      fontFamily: 'Epilogue'
  );
}
