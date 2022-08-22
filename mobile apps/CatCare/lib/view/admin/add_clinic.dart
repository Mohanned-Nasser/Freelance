import 'dart:io';

import 'package:catcare/model/clinic_model.dart';
import 'package:catcare/util/alerts.dart';
import 'package:catcare/util/app_color.dart';
import 'package:catcare/view/drawer_screen.dart';
import 'package:catcare/widgets/custom_appbar.dart';
import 'package:catcare/widgets/custom_button.dart';
import 'package:catcare/widgets/custom_textfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';

import '../../util/app_style.dart';
import '../../util/services/authentication/firestore_storage.dart';
import '../../widgets/custom_loader.dart';

class AddClinicScreen extends StatefulWidget {
  ClinicModel clinicModel;
   AddClinicScreen({Key? key,required this.clinicModel}) : super(key: key);

  @override
  _AddClinicScreenState createState() => _AddClinicScreenState();
}

class _AddClinicScreenState extends State<AddClinicScreen> {
  GlobalKey<ScaffoldState> _key = GlobalKey(); // add this

  final txtAboutUs = TextEditingController();
  final txtAddress = TextEditingController();
final txtHour = TextEditingController();
final txtPhone = TextEditingController();

setValues(){
  setState(() {
    txtHour.text=widget.clinicModel.hours!;
    txtAddress.text=widget.clinicModel.address!;
    txtPhone.text=widget.clinicModel.phone!;
    txtAboutUs.text=widget.clinicModel.aboutUs!;
    imgUrl=widget.clinicModel.imgUrl!;
  });

}


  @override
  void initState() {
    setValues();
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
                  title: "ADD CLINIC",
                  drawerAction: () {
                    _key.currentState!.openEndDrawer();
                  }),
              body: Center(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(top: 15.h),
                      child: Container(
                        padding: EdgeInsets.all(16.h),
                        decoration: BoxDecoration(color: AppColors.appSkyBlueColor),
                        child: Column(
                          children: [
                            customTextField(controller: txtAboutUs, label: "About us :",isDescription: true),
                            customTextField(controller: txtAddress, label: "Address :"),
                            customTextField(controller: txtHour, label: "Hour :"),
                            customTextField(controller: txtPhone, label: "Phone :"),

                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 17.h,
                    ),
                    customButton(
                        text: "Upload Photo",
                        action: () {
                          _showPicker(context);
                        }),
                    Padding(
                      padding: EdgeInsets.all(18.h),
                      child: Text(_image==null?'--Not selected--':'Image Selected'),
                    ),
                    SizedBox(
                      height: 87.h,
                    ),
                    customButton(text: "Save", action: () {
                      updateClinic();
                    }),
                  ],
                ),
              )),
        ));
  }

  File? _image;

  _imgFromCamera() async {
    XFile? image = await ImagePicker()
        .pickImage(source: ImageSource.camera, imageQuality: 50);

    setState(() {
      _image = File(image!.path);
    });
  }

  _imgFromGallery() async {
    XFile? image = await ImagePicker()
        .pickImage(source: ImageSource.gallery, imageQuality: 50);

    setState(() {
      _image = File(image!.path);
    });
  }

  void _showPicker(context) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext bc) {
          return SafeArea(
            child: Container(
              child: Wrap(
                children: <Widget>[
                  ListTile(
                      leading: Icon(Icons.photo_library),
                      title: Text('Photo Library'),
                      onTap: () {
                        _imgFromGallery();
                        Navigator.of(context).pop();
                      }),
                  ListTile(
                    leading: Icon(Icons.photo_camera),
                    title: Text('Camera'),
                    onTap: () {
                      _imgFromCamera();
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              ),
            ),
          );
        });
  }

  String? aboutUs, address, hours, phone,imgUrl;

  getValues() {
    aboutUs=txtAboutUs.text;
    address=txtAddress.text;
    hours=txtHour.text;
    phone=txtPhone.text;
  }

  isEmpty() {
    if (aboutUs!.isEmpty ||
        address!.isEmpty ||
        hours!.isEmpty ||
        phone!.isEmpty||(imgUrl!.isEmpty&&_image==null)) {
      return true;
    } else {
      return false;
    }
  }

  updateClinic() async {
    getValues();
    if (isEmpty()) {
      MyAlerts.showInfoBox(context, "Please fill all details");
    } else {
      if(_image!=null) {
        customLoadingIndicator(context, text: "Uploading Image...");
        imgUrl = await FirestoreService.uploadImageToFirestore(
            folderName: "ClinicImages", img: _image!, context: context);
      }
      customLoadingIndicator(context, text: "Uploading Training...");
      ClinicModel clinicModel = ClinicModel(
        aboutUs: aboutUs,
        address: address,
        hours: hours,
        phone: phone,
        imgUrl: imgUrl
      );
      bool result = await clinicModel.updateClinicInfo(context: context);
      if (result) {
        Navigator.pop(context);
        MyAlerts.showInfoBox(context, "Clinic Information Updated Successfully.");
      }
    }
  }
}
