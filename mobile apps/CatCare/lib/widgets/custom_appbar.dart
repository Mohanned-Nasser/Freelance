import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../util/app_style.dart';

customAppBar({Widget? leading, String? title, drawerAction,required BuildContext context,bool hideMenuBar=false}) {
  return PreferredSize(
      preferredSize: Size.fromHeight(120.h),
      child: Padding(
        padding:  EdgeInsets.only(top: 10.h,bottom: 10.h),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            leading ??
                IconButton(onPressed: () {
                  Navigator.pop(context);
                }, icon: Icon(Icons.arrow_back_ios)),
            Text(
              title!,
              style: appbarTitleStyle(),
            ),
            IconButton(
                onPressed: () {
                  drawerAction();
                },
                icon: Icon(Icons.menu)),
          ],
        ),
      ));
}
