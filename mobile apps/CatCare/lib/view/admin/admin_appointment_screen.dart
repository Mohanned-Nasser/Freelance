import 'package:catcare/model/appointment_model.dart';
import 'package:catcare/util/app_color.dart';
import 'package:catcare/util/app_navigator.dart';
import 'package:catcare/util/app_style.dart';
import 'package:catcare/util/format_dates.dart';
import 'package:catcare/view/user_screen/add_appointment_screen.dart';
import 'package:catcare/widgets/custom_button.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../widgets/custom_appbar.dart';
import '../../widgets/custom_widgets.dart';
import '../drawer_screen.dart';

class AdminAppointmentScreen extends StatefulWidget {
  const AdminAppointmentScreen({Key? key}) : super(key: key);

  @override
  _AdminAppointmentScreenState createState() => _AdminAppointmentScreenState();
}

class _AdminAppointmentScreenState extends State<AdminAppointmentScreen> {
  GlobalKey<ScaffoldState> _key = GlobalKey(); // add this
  final _stream = AppointmentModel().getAllAppointments();

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
              body: Container(
                color: AppColors.appWhiteColor,
                child: StreamBuilder<QuerySnapshot>(
                    stream: _stream,
                    builder: (context, snapshot) {
                      if (!snapshot.hasData) {
                        return Center(child: const CircularProgressIndicator.adaptive());
                      }
                      if (snapshot.data!.size== 0) {
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
                        return adminAppointmentTile(appointmentModel: appointments[index]);
                      },
                    );
                  }
                ),
              )),
        ));
  }


  Widget adminAppointmentTile({AppointmentModel? appointmentModel}) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 8.w,vertical: 5.h),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    '${appointmentModel!.appointmentName}',
                    style: epilogueTextStyle(fontSize: 17.sp),
                  ),
                  SizedBox(
                    height: 8.h,
                  ),
                  Text(
                    appointmentModel.appointmentStatus=="pending"?'Pending':'Approved',
                    style: epilogueTextStyle(fontSize: 12.sp, color:  appointmentModel.appointmentStatus=="pending"?Colors.red:Colors.green),
                  ),
                ],
              ),
              Column(
                children: [
                  Text(
                    '${dateFormat(appointmentModel.appointmentDate!.toDate())}',
                    style: epilogueTextStyle(fontSize: 12.sp, color:  appointmentModel.appointmentStatus=="pending"?Colors.red:Colors.green),
                  ),
                  SizedBox(
                    child: Transform.scale(
                      transformHitTests: false,
                      scale: .7,
                      child: CupertinoSwitch(
                        value: appointmentModel.appointmentStatus=="pending"?false:true,
                        onChanged: (value) {
                         AppointmentModel().updateAppointmentStatus(context: context,appointmentId: appointmentModel.appointmentId,status:appointmentModel.appointmentStatus=="pending"?"approved":"pending");
                        },
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
          Divider(
            thickness: 1,
          )
        ],
      ),
    );
  }
}
