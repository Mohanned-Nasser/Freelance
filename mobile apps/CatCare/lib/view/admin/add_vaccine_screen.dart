import 'dart:io';

import 'package:catcare/model/vaccine_model.dart';
import 'package:catcare/util/alerts.dart';
import 'package:catcare/util/app_color.dart';
import 'package:catcare/util/services/authentication/authentication_service.dart';
import 'package:catcare/util/services/authentication/firestore_storage.dart';
import 'package:catcare/view/drawer_screen.dart';
import 'package:catcare/widgets/custom_appbar.dart';
import 'package:catcare/widgets/custom_button.dart';
import 'package:catcare/widgets/custom_loader.dart';
import 'package:catcare/widgets/custom_textfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';

import '../../util/app_style.dart';

class AddVaccineScreen extends StatefulWidget {
  const AddVaccineScreen({Key? key}) : super(key: key);

  @override
  _AddVaccineScreenState createState() => _AddVaccineScreenState();
}

class _AddVaccineScreenState extends State<AddVaccineScreen> {
  GlobalKey<ScaffoldState> _key = GlobalKey(); // add this

  final txtName = TextEditingController();
  final txtType = TextEditingController();
  final txtAge = TextEditingController();
  final txtUsage = TextEditingController();
  final txtPrice = TextEditingController();

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
              title: "ADD VACCINE",
              drawerAction: () {
                _key.currentState!.openEndDrawer();
              }),
          body: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding(
                  padding: EdgeInsets.only(top: 15.h),
                  child: Container(
                    padding: EdgeInsets.all(16.h),
                    decoration:
                        BoxDecoration(color: AppColors.appSkyBlueColor),
                    child: Column(
                      children: [
                        customTextField(controller: txtName, label: "Name"),
                        customTextField(controller: txtType, label: "Type"),
                        customTextField(controller: txtAge, label: "Age"),
                        customTextField(controller: txtUsage, label: "Usage"),
                        customTextField(
                            controller: txtPrice,
                            label: "Price",
                            keyboard: TextInputType.numberWithOptions(
                                decimal: true, signed: true)),
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
                  child: Text(
                      _image == null ? '--Not selected--' : 'Image Selected'),
                ),
                SizedBox(
                  height: 87.h,
                ),
                customButton(
                    text: "Add",
                    action: () {
                      addVaccine();
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

  String? name, type, age, usage, imgUrl;
  double? price;

  getValues() {
    name = txtName.text;
    type = txtType.text;
    age = txtAge.text;
    usage = txtUsage.text;
    price = double.parse(txtPrice.text.isEmpty ? '0.00' : txtPrice.text);
  }

  isEmpty() {
    if (name!.isEmpty ||
        type!.isEmpty ||
        age!.isEmpty ||
        usage!.isEmpty ||
        price == 0.00 ||
        _image == null) {
      return true;
    } else {
      return false;
    }
  }

  addVaccine() async {
    getValues();
    if (isEmpty()) {
      MyAlerts.showInfoBox(context, "Please fill all details");
    } else {
      customLoadingIndicator(context, text: "Uploading Image...");
      imgUrl = await FirestoreService.uploadImageToFirestore(
          folderName: "VaccineImages", img: _image!, context: context);
      customLoadingIndicator(context, text: "Uploading Vaccine...");
      VaccineModel vaccineModel = VaccineModel(
          vaccineImgUrl: imgUrl,
          vaccinePrice: price,
          vaccineAge: age,
          vaccineName: name,
          vaccineType: type,
          vaccineUsage: usage);
      bool result = await vaccineModel.uploadVaccine(context: context);
      if (result) {
        Navigator.pop(context);
        MyAlerts.showInfoBox(context, "New Vaccine Uploaded Successfully.");
      }
    }
  }
}
