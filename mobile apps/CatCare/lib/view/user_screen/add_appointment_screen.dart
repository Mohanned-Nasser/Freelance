import 'package:catcare/model/appointment_model.dart';
import 'package:catcare/util/alerts.dart';
import 'package:catcare/util/app_color.dart';
import 'package:catcare/util/app_constants.dart';
import 'package:catcare/util/app_style.dart';
import 'package:catcare/util/format_dates.dart';
import 'package:catcare/widgets/custom_button.dart';
import 'package:catcare/widgets/custom_loader.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

import '../../widgets/custom_appbar.dart';
import '../../widgets/custom_textfield.dart';
import '../drawer_screen.dart';

class AddAppointmentScreen extends StatefulWidget {
  const AddAppointmentScreen({Key? key}) : super(key: key);

  @override
  _AddAppointmentScreenState createState() => _AddAppointmentScreenState();
}

class _AddAppointmentScreenState extends State<AddAppointmentScreen> {
  GlobalKey<ScaffoldState> _key = GlobalKey(); // add this

  final DateRangePickerController _controller = DateRangePickerController();
  DateTime _date = DateTime.now();

  final txtInput = TextEditingController();
  final txtDate = TextEditingController();

  @override
  void initState() {
    setState(() {
      txtDate.text=dateFormat(_date);
    });
  }
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
            title: "Add Appointments",
            drawerAction: () {
              _key.currentState!.openEndDrawer();
            }),
        body: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              SfDateRangePicker(
                backgroundColor: AppColors.appWhiteColor,
                selectionColor: AppColors.appOrangeColor,
                onSelectionChanged: selectionChanged,
                controller: _controller,
                headerStyle: DateRangePickerHeaderStyle(
                  textAlign: TextAlign.center,
                ),
              ),
              Container(
                color: AppColors.appGreyColor,
                padding: EdgeInsets.all(28.h),
                child: Column(
                  children: [
                    customTextField(
                        controller: txtInput, label: "Appointment name"),
                    customTextField(controller: txtDate, label: "Date",enable: false),
                    SizedBox(height: 20.h,),
                    customButton(text: "Add appointment", action: () {
                      addAppointment();
                    }),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    ));
  }

  void selectionChanged(DateRangePickerSelectionChangedArgs args) {
    SchedulerBinding.instance.addPostFrameCallback((duration) {
      setState(() {
        _date = args.value;
        txtDate.text=dateFormat(_date);
        print("date is $_date");
      });
    });
  }

  addAppointment() async {
    if(txtInput.text.isEmpty){
      MyAlerts.showInfoBox(context, "Please enter appointment name");
    }else{
      customLoadingIndicator(context,text: "Booking appointment...");
      AppointmentModel appointmentModel=AppointmentModel(
        appointmentDate: Timestamp.fromDate(_date),
        appointmentStatus: "pending",
        appointmentName: txtInput.text,
        appointmentBookedBy: MyConstant.currentUserID
      );
      bool result=await appointmentModel.bookAppointment(context: context);
      if(result) {
        Navigator.pop(context);
        MyAlerts.showInfoBox(context, "Appointment booked successfully.");
      }
    }
  }
}
