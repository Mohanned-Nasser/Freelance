import 'package:catcare/util/app_color.dart';
import 'package:catcare/util/app_style.dart';
import 'package:catcare/util/asset_path.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MyAlerts {
  static showAlertDialog(BuildContext context, String btnText, String title,
      String subtitle, Function action) {
    // set up the button
    Widget cancelButton = TextButton(
      child: Text("CANCEL"),
      onPressed: () {
        Navigator.pop(context);
      },
    );
    Widget okButton = TextButton(
      child: Text(btnText),
      onPressed: () {
        Navigator.pop(context);
        action();
      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      alignment: Alignment.center,
      contentPadding: EdgeInsets.zero,
      content: Container(
        height: 180.h,
        padding: EdgeInsets.all(16.h),
        decoration: gradientBackground(),
        child: Column(
          children: [
            Center(
                child: Image.asset(
                  AssetsPath.profile,
                  height: 100.h,
                )),
            SizedBox(height: 10.h,),
            Text(
              subtitle,
              textAlign: TextAlign.center,
              style: epilogueTextStyle(fontSize: 14.sp),
            ),
          ],
        ),
      ),
      actions: [
        cancelButton,
        okButton,
      ],
    );

    // show the dialog
    showDialog(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  static showInfoBox(BuildContext context, String info) {
    // set up the button
    Widget okButton = TextButton(
      child: Text("OK"),
      onPressed: () {
        Navigator.pop(context);
      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      alignment: Alignment.center,
      contentPadding: EdgeInsets.zero,
      content: Container(
        height: 180.h,
        padding: EdgeInsets.all(16.h),
        decoration: gradientBackground(),
        child: Column(
          children: [
            Center(
                child: Image.asset(
              AssetsPath.profile,
              height: 100.h,
            )),
            SizedBox(height: 10.h,),
            Text(
              info,
              textAlign: TextAlign.center,
              style: epilogueTextStyle(fontSize: 14.sp),
            ),
          ],
        ),
      ),
      actions: [
        okButton,
      ],
    );

    // show the dialog
    showDialog(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }
}
