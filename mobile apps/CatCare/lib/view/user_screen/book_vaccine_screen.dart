import 'package:catcare/model/vaccine_model.dart';
import 'package:catcare/util/format_dates.dart';
import 'package:catcare/widgets/custom_loader.dart';
import 'package:flutter/material.dart';
import 'package:catcare/util/app_color.dart';
import 'package:catcare/util/app_style.dart';
import 'package:catcare/widgets/custom_button.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

import '../../util/alerts.dart';
import '../../widgets/custom_appbar.dart';
import '../../widgets/custom_textfield.dart';
import '../drawer_screen.dart';

class BookVaccineScreen extends StatefulWidget {
  VaccineModel vaccineModel;
   BookVaccineScreen({Key? key,required this.vaccineModel}) : super(key: key);

  @override
  _BookVaccineScreenState createState() => _BookVaccineScreenState();
}

class _BookVaccineScreenState extends State<BookVaccineScreen> {
  GlobalKey<ScaffoldState> _key = GlobalKey(); // add this

  final DateRangePickerController _controller = DateRangePickerController();
  DateTime? _date;


  @override
  void initState() {
    _date=DateTime.now();
    setState(() {
      txtDate.text=dateFormat(_date!);
    });
  }

  final txtDate = TextEditingController();

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
                title: "Book Vaccine",
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
                        customTextField(controller: txtDate, label: "Date",enable: false),
                        SizedBox(height: 20.h,),
                        customButton(text: "Book Vaccine", action: () {
                          bookVaccineScreen();
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
        _date =args.value;
        txtDate.text=dateFormat(_date!);
        print("date is $_date");
      });
    });
  }
  bookVaccineScreen() async {
    customLoadingIndicator(context,text: 'Booking your vaccine...');
    bool result=await VaccineModel.bookVaccine(context: context,vaccine: widget.vaccineModel,date:_date!);
    if(result){
      Navigator.pop(context);
      MyAlerts.showInfoBox(context, "Vaccine Booked Successfully");
    }
  }
}
