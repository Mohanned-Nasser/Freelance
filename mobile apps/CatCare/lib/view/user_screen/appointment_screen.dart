import 'package:catcare/model/appointment_model.dart';
import 'package:catcare/util/app_color.dart';
import 'package:catcare/util/app_navigator.dart';
import 'package:catcare/util/app_style.dart';
import 'package:catcare/view/user_screen/add_appointment_screen.dart';
import 'package:catcare/widgets/custom_button.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../widgets/custom_appbar.dart';
import '../../widgets/custom_widgets.dart';
import '../drawer_screen.dart';

class AppointmentScreen extends StatefulWidget {
  const AppointmentScreen({Key? key}) : super(key: key);

  @override
  _AppointmentScreenState createState() => _AppointmentScreenState();
}

class _AppointmentScreenState extends State<AppointmentScreen> {
  GlobalKey<ScaffoldState> _key = GlobalKey(); // add this
  var _stream = AppointmentModel().getMyAppointments();

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
              title: "APPOINTMENTS",
              drawerAction: () {
                _key.currentState!.openEndDrawer();
              }),
          body: Stack(
            children: [
              Container(
                color: AppColors.appWhiteColor,
                child: Padding(
                  padding: EdgeInsets.only(bottom: 50.h),
                  child: StreamBuilder<QuerySnapshot>(
                      stream: _stream,
                      builder: (context, snapshot) {
                        if (!snapshot.hasData) {
                          return Center(child: CircularProgressIndicator.adaptive());
                        }
                        if (snapshot.data!.size == 0) {
                          return Center(
                            child: Text(
                              'No appointment yet',
                              style: fredokaTextStyle(),
                            ),
                          );
                        }
                        var allDocs = snapshot.data!.docs;
                        List<AppointmentModel> appointments = [];
                        for (var doc in allDocs) {
                          var model = AppointmentModel.fromJson(
                              doc.data() as Map<String, dynamic>);
                          appointments.add(model);
                        }
                        return ListView.builder(
                          itemCount: appointments.length,
                          itemBuilder: (context, index) {
                            return appointmentTile(
                                appointmentModel: appointments[index]);
                          },
                        );
                      }),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(bottom: 30.h),
                child: Align(
                  alignment: Alignment.bottomCenter,
                  child: customButton(
                      text: "Book new appointment",
                      action: () {
                        AppNavigator.push(context, AddAppointmentScreen());
                      }),
                ),
              )
            ],
          )),
    ));
  }
}
