import 'package:catcare/util/app_color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../util/app_style.dart';

Widget customTextField(
    {TextEditingController? controller,
    String? label,
    bool hide = false,
    bool enable = true,
    TextInputType? keyboard,
    bool isDescription = false}) {
  return Padding(
    padding: EdgeInsets.only(bottom: 10.h),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label!,
          style: fredokaTextStyle(fontSize: 15.sp),
        ),
        SizedBox(
          width: 10.w,
        ),
        Container(
          width: 150.w,
          height: isDescription?100.h:35.h,
          child: TextField(
            controller: controller,
            style: authenticationTextFieldStyle(fontSize: 12.sp),
            obscureText: hide,
            enabled: enable,
            maxLines: isDescription?20:1,
            keyboardType: keyboard,
            textAlign: TextAlign.center,
            decoration: InputDecoration(
              enabledBorder: border(),
              focusedBorder: border(),
              filled: true,
              fillColor: AppColors.textFieldColor,
              disabledBorder: border(),
              contentPadding: EdgeInsets.zero,
              hintStyle: authenticationTextFieldStyle(),
            ),
          ),
        ),
      ],
    ),
  );
}

border() {
  return OutlineInputBorder(
      borderSide: BorderSide(color: AppColors.textFieldColor, width: 1.0),
      borderRadius: BorderRadius.circular(10.r));
}
