// loading widget

import 'package:catcare/util/app_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../util/app_color.dart';

Future<dynamic> customLoadingIndicator(BuildContext context,{String? text}) {
  return showDialog(
      context: context,
      builder: (ctx) {
        return Material(
          color: Colors.transparent,
          child: Center(
            child: Container(
              height: 150.h,
              width: 250.w,
              decoration:gradientBackground(),
              child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Text(text??'Please wait.....',style: fredokaTextStyle(),),
                      CircularProgressIndicator(
                        color: AppColors.loadingColor,
                      ),
                    ],
                  )),
            ),
          ),
        );
      });
}