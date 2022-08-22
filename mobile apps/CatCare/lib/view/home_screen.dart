import 'package:catcare/util/app_color.dart';
import 'package:catcare/util/app_navigator.dart';
import 'package:catcare/util/asset_path.dart';
import 'package:catcare/view/admin/admin_appointment_screen.dart';
import 'package:catcare/view/user_screen/appointment_screen.dart';
import 'package:catcare/view/user_screen/clinic_details_screen.dart';
import 'package:catcare/view/user_screen/expenses_screen.dart';
import 'package:catcare/view/user_screen/news_screen.dart';
import 'package:catcare/view/user_screen/profile_screen.dart';
import 'package:catcare/view/user_screen/train_screen.dart';
import 'package:catcare/view/user_screen/vaccine_screen.dart';
import 'package:catcare/widgets/custom_appbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../util/app_style.dart';
import '../widgets/custom_widgets.dart';
import 'drawer_screen.dart';

class HomeScreen extends StatefulWidget {
  bool? isAdmin;
  HomeScreen({Key? key,this.isAdmin}) : super(key: key);

  @override
  _HomeScreeState createState() => _HomeScreeState();
}

class _HomeScreeState extends State<HomeScreen> {
  GlobalKey<ScaffoldState> _key = GlobalKey(); // add this

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Container(
          decoration: gradientBackground(),
      child: Scaffold(
        key: _key,
        backgroundColor: Colors.transparent,
        endDrawer: DrawerScreen(),
        appBar: customAppBar(
          context: context,
            leading: widget.isAdmin!?SizedBox():Padding(
              padding: EdgeInsets.only(left: 8.w),
              child: GestureDetector(
                onTap: (){
                  AppNavigator.push(context, const ProfileScreen());
                },
                child: CircleAvatar(
                  backgroundImage: AssetImage(AssetsPath.profile,),
                  radius: 25.h,
                ),
              ),
            ),
            title: "HOME",
            drawerAction: () {
              _key.currentState!.openEndDrawer();
            }),

        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                homeContainer(imgPath: AssetsPath.vaccineIcon,title: "Vaccine",action: (){
                  AppNavigator.push(context, VaccineScreen());
                }),
                SizedBox(width: 47.w,),
                homeContainer(imgPath: AssetsPath.appointmentIcon,title: "Appointment",action: (){
                  widget.isAdmin!?AppNavigator.push(context, AdminAppointmentScreen()):AppNavigator.push(context, AppointmentScreen());
                }),
              ],
            ),
            SizedBox(height: 32.h,),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                homeContainer(imgPath: AssetsPath.trainIcon,title: "Train",action: (){
                  AppNavigator.push(context, const TrainScreen());
                }),
                Visibility(
                    visible: !widget.isAdmin!,
                    child: SizedBox(width: 47.w,)),
                Visibility(
                  visible: !widget.isAdmin!,
                  child: homeContainer(imgPath: AssetsPath.expensesIcon,title: "Expenses",action: (){
                    AppNavigator.push(context, const ExpensesScreen());
                  }),
                ),
              ],
            ),
            SizedBox(height: 32.h,),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                homeContainer(imgPath: AssetsPath.newsIcon,title: "News",action: (){
                  AppNavigator.push(context, NewsScreen());
                }),
                SizedBox(width: 47.w,),
                homeContainer(imgPath: AssetsPath.clinicDetailsIcon,title: "Clinic Details",action: (){
                  AppNavigator.push(context, ClinicDetailsScreen());
                }),
              ],
            ),
            SizedBox(height: 32.h,),
          ],
        ),
      ),
    ));
  }
}
