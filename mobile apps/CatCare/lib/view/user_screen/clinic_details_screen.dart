import 'package:catcare/model/clinic_model.dart';
import 'package:catcare/util/app_constants.dart';
import 'package:catcare/util/app_navigator.dart';
import 'package:catcare/util/asset_path.dart';
import 'package:catcare/view/admin/add_clinic.dart';
import 'package:catcare/widgets/custom_widgets.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:catcare/util/app_color.dart';
import 'package:catcare/util/app_style.dart';
import 'package:catcare/widgets/custom_button.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

import '../../widgets/custom_appbar.dart';
import '../../widgets/custom_textfield.dart';
import '../drawer_screen.dart';

class ClinicDetailsScreen extends StatefulWidget {
  const ClinicDetailsScreen({Key? key}) : super(key: key);

  @override
  _ClinicDetailsScreenState createState() => _ClinicDetailsScreenState();
}

class _ClinicDetailsScreenState extends State<ClinicDetailsScreen> {
  GlobalKey<ScaffoldState> _key = GlobalKey(); // add this
  bool isAdmin=MyConstant.isAdmin;
  final _stream=ClinicModel().getClinicInfo();
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
            title: "CONTACT US",
            drawerAction: () {
              _key.currentState!.openEndDrawer();
            }),
        body: StreamBuilder<QuerySnapshot>(
          stream: _stream,
          builder: (context, snapshot) {
            if(!snapshot.hasData){
              return Center(child: CircularProgressIndicator(),);
            }
            if(snapshot.data!.size==0){
              return Center(child: Text('No clinic Info yet'),);
            }
            ClinicModel clinicModel=ClinicModel.fromJson(snapshot.data!.docs.first.data() as Map<String, dynamic> );
            return SingleChildScrollView(
              child: Column(
                children: <Widget>[
                 cachedImage(
                   height: 231.h,
                   width: 343.w,
                   url: clinicModel.imgUrl
                 ),
                  infoRow(
                      title: "About us",
                      info:clinicModel.aboutUs),
                  infoRow(
                      title: "Address",
                      info:clinicModel.address),
                  infoRow(title: "Hours", info: clinicModel.hours, center: true),
                  infoRow(title: "Phone", info: clinicModel.phone, center: true),
                  Visibility(
                    visible:isAdmin,
                    child: Padding(
                      padding: EdgeInsets.only(top: 47.h),
                      child: customButton(text: "Edit", action: () {
                        AppNavigator.push(context, AddClinicScreen(clinicModel: clinicModel,));
                      }),
                    ),
                  )
                ],
              ),
            );
          }
        ),
      ),
    ));
  }

  infoRow({String? title, String? info, bool center = false}) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 10.h, horizontal: 10.w),
      child: Row(
        crossAxisAlignment:
            center ? CrossAxisAlignment.center : CrossAxisAlignment.start,
        children: [
          SizedBox(
              width: 93.w,
              height: 26.h,
              child: customButton(text: title, action: () {})),
          SizedBox(
            width: 15.w,
          ),
          Flexible(
            child: Text(
              info!,
              style: epilogueTextStyle(),
            ),
          )
        ],
      ),
    );
  }
}
