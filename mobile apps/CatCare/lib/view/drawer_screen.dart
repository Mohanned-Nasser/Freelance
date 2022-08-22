import 'package:catcare/util/app_constants.dart';
import 'package:catcare/util/app_navigator.dart';
import 'package:catcare/util/app_style.dart';
import 'package:catcare/util/asset_path.dart';
import 'package:catcare/util/services/authentication/authentication_service.dart';
import 'package:catcare/view/authentication_screens/signin_screen.dart';
import 'package:catcare/view/home_screen.dart';
import 'package:catcare/view/user_screen/profile_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../util/alerts.dart';
import '../util/app_color.dart';

class DrawerScreen extends StatefulWidget {
  const DrawerScreen({Key? key}) : super(key: key);

  @override
  _DrawerScreenState createState() => _DrawerScreenState();
}

class _DrawerScreenState extends State<DrawerScreen> {
  bool isAdmin=MyConstant.isAdmin;
  @override
  Widget build(BuildContext context) {
    return Drawer(
      elevation: 10,
      backgroundColor: Colors.transparent,
      child: ClipRRect(
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(35), bottomLeft: Radius.circular(35)),
        child: Container(
          height: 1.sh,
          decoration: BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                AppColors.appGradientStartColor,
                AppColors.appGradientEndColor
              ])),
          child: Column(
            children: [
              Expanded(
                child: ListView(
                  padding: EdgeInsets.zero,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: DrawerHeader(
                        child: Text(''),
                        decoration: BoxDecoration(
                            image: DecorationImage(
                                image: AssetImage(AssetsPath.profile),
                                fit: BoxFit.contain)),
                      ),
                    ),
                    ListTile(
                      leading: Icon(
                        Icons.home,
                        color: Colors.black,
                      ),
                      title: Text(
                        'Home',
                        style: fredokaTextStyle(fontSize: 16.sp),
                      ),
                      onTap: () {
                        AppNavigator.makeFirst(context, HomeScreen());
                      },
                    ),
                    Visibility(
                      visible: !isAdmin,
                      child: ListTile(
                        leading: Icon(
                          Icons.person,
                          color: Colors.black,
                        ),
                        title: Text(
                          'Profile',
                          style: fredokaTextStyle(fontSize: 16.sp),
                        ),
                        onTap: () {
                          AppNavigator.push(context, ProfileScreen());
                        },
                      ),
                    ),
                    ListTile(
                      leading: Icon(
                        Icons.logout,
                        color: Colors.black,
                      ),
                      title: Text(
                        'Logout',
                        style: fredokaTextStyle(fontSize: 16.sp),
                      ),
                      onTap: () {
                        MyAlerts.showAlertDialog(context, "LOGOUT","LOGOUT", "DO YOU REALLY WANT TO LOGOUT?",(){
                          AuthenticationService.logoutUser();
                          AppNavigator.makeFirst(context, SignInScreen());
                        });

                      },
                    ),
                  ],
                ),
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text('CatCare v1.0.0'),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
