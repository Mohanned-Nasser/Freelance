import 'dart:io';

import 'package:catcare/model/cat_model.dart';
import 'package:catcare/util/alerts.dart';
import 'package:catcare/util/app_color.dart';
import 'package:catcare/util/app_constants.dart';
import 'package:catcare/util/asset_path.dart';
import 'package:catcare/util/services/authentication/firestore_storage.dart';
import 'package:catcare/widgets/custom_appbar.dart';
import 'package:catcare/widgets/custom_button.dart';
import 'package:catcare/widgets/custom_loader.dart';
import 'package:catcare/widgets/custom_textfield.dart';
import 'package:catcare/widgets/custom_widgets.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';

import '../../util/app_style.dart';
import '../../util/format_dates.dart';
import '../drawer_screen.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  GlobalKey<ScaffoldState> _key = GlobalKey();
  List<String> genderList=["Male","Female"];
  String currentGender="Male";

  final txtName=TextEditingController();
  final txtWeight=TextEditingController();
  final txtDob=TextEditingController();
  final txtVaccineDate=TextEditingController();
  final txtNextvaccineDate=TextEditingController();

  @override
  void initState() {
    Permission.camera.request();
    Permission.photos.request();
    Permission.manageExternalStorage.request();
    Permission.storage.request();
    setProfile();
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
            title: "Profile",
            drawerAction: () {
              _key.currentState!.openEndDrawer();
            },
          ),

          body: SingleChildScrollView(
            child: Column(
              children: [

                // profile image
                Center(
                  child: imgUrl==null?
                  Container(
                    height: 150.h,
                    width: 130.w,
                    decoration: _image==null?BoxDecoration(
                      border: Border.all(color: Colors.black),
                      borderRadius: BorderRadius.circular(100.r),
                      image: DecorationImage(
                        image: AssetImage(AssetsPath.cat),
                        fit: BoxFit.cover
                      )
                    ):BoxDecoration(
                        border: Border.all(color: Colors.black),
                        borderRadius: BorderRadius.circular(100.r),
                        image: DecorationImage(
                            image: FileImage(_image!),
                            fit: BoxFit.cover
                        )
                    )
                  ):profileCachedImage(url: imgUrl!),
                ),

                SizedBox(height: 20.h,),
                customButton(text: "upload photo",action: (){
                  _showPicker(context);
                }),
                SizedBox(height: 20.h,),
                Container(
                  color: AppColors.appGreyColor,
                  padding: EdgeInsets.all(8.h),
                  child: Column(
                    children: [
                      customTextField(label: "Name :",controller: txtName),
                      dropdown(),
                      customTextField(label: "Weight :",keyboard: TextInputType.numberWithOptions(signed: true,decimal: true),controller: txtWeight),
                      GestureDetector(
                          onTap: (){
                            _selectDate(context,"dob");
                          },
                          child: customTextField(label: "Date of Birth :",enable: false,controller: txtDob)),
                      GestureDetector(
                          onTap: (){
                            _selectDate(context,"vc");
                          },
                          child: customTextField(label: "Vaccine Date :",controller: txtVaccineDate,enable: false)),
                      GestureDetector(
                          onTap: (){
                            _selectDate(context,"nvc");
                          },
                          child: customTextField(label: "Next Vaccine Date :",controller: txtNextvaccineDate,enable: false)),
                    ],
                  ),
                ),
                SizedBox(height: 20.h,),
                customButton(text: "Update & Save",action: (){
                  updateProfile();
                }),
              ],
            ),
          ),

        ),
      ),
    );
  }

  Widget dropdown(){
    return  Padding(
      padding: EdgeInsets.only(bottom: 10.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Gender :",
            style: fredokaTextStyle(fontSize: 15.sp),
          ),
          SizedBox(width: 10.w,),
          Container(
            height: 35.h,
            width: 150.w,
            decoration: BoxDecoration(
              color: AppColors.textFieldColor,
                borderRadius: BorderRadius.circular(10.r)
            ),
            child: DropdownButton<String>(
              isExpanded: true,
              icon: SizedBox(),
              underline: SizedBox(),
              value: currentGender.toString(),
              items: genderList.map((String value) {
                return DropdownMenuItem<String>(
                    value: value,
                    child:Center(child: Text(value,style:  authenticationTextFieldStyle(fontSize: 12.sp),))
                );
              }).toList(),
              onChanged: (val) {
                setState(() {
                  currentGender=val.toString();
                });
              },
            ),
          ),
        ],
      ),
    );
  }

  File? _image;

  _imgFromCamera() async {
    XFile? image = await ImagePicker().pickImage(
        source: ImageSource.camera, imageQuality: 50
    );

    setState(() {
      _image = File(image!.path);
    });
  }

  _imgFromGallery() async {
    XFile? image = await  ImagePicker().pickImage(
        source: ImageSource.gallery, imageQuality: 50
    );

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
              child:  Wrap(
                children: <Widget>[
                  ListTile(
                      leading:  Icon(Icons.photo_library),
                      title:  Text('Photo Library'),
                      onTap: () {
                        _imgFromGallery();
                        Navigator.of(context).pop();
                      }),
                  ListTile(
                    leading:  Icon(Icons.photo_camera),
                    title:  Text('Camera'),
                    onTap: () {
                      _imgFromCamera();
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              ),
            ),
          );
        }
    );
  }

  DateTime currrentDate = DateTime.now();
  DateTime? dob ;
  DateTime? vcDate;
  DateTime? nvcDate;


  Future<void> _selectDate(BuildContext context,String text) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: currrentDate,
        firstDate: DateTime(1999, 8),
        lastDate: DateTime(2101));
    if (picked != null && picked != currrentDate) {
      setState(() {
        if(text=="dob") {
          dob = picked;
          txtDob.text=dateFormat(picked);
        }
        else if(text=="vc") {
          vcDate = picked;
          txtVaccineDate.text=dateFormat(picked);
        }
        else if(text=="nvc") {
          nvcDate = picked;
          txtNextvaccineDate.text=dateFormat(picked);
        }
      });
    }
  }

  String? name,imgUrl;
  double? weight;
  getValues(){
    name=txtName.text;
    weight=double.parse(txtWeight.text.isEmpty?"0.0":txtWeight.text);
  }
  isEmpty(){
    if(name!.isEmpty||dob==null||vcDate==null||nvcDate==null||(imgUrl==null&&_image==null)){
      return true;
    }else{
      return false;
    }
  }
  updateProfile() async {
    getValues();
    if(isEmpty()){
      MyAlerts.showInfoBox(context, "Please fill all details");
    }else{


      // updateImage
      if(_image!=null){


        if(imgUrl!=null) {
          customLoadingIndicator(context);
          // delete previous image from storage
          await FirestoreService.deleteFromStorage(context,imgUrl);
        }
        customLoadingIndicator(context,text: "Uploading image......Please wait");
        // upload image to fire storage
        imgUrl=await FirestoreService.uploadImageToFirestore(folderName:"profileImages",img:_image!,context: context);
        _image=null;
        print("User Image uploaded Image is ${imgUrl}");
      }

      customLoadingIndicator(context);
      CatModel catModel=CatModel(
        name: name,
        gender: currentGender,
        weight: weight,
        dateOfBirth: Timestamp.fromDate(dob!),
        vaccineDate: Timestamp.fromDate(vcDate!),
        nextVaccineDate: Timestamp.fromDate(nvcDate!),
        imgUrl: imgUrl
      );
      bool result=await catModel.updateCatProfile(context: context);
      catModel.catId=catModel.catId;
      MyConstant.currentCatModel=catModel;
      Navigator.pop(context);
      if(result) {
        MyAlerts.showInfoBox(context, "Profile information updated successfully.");
      }
    }
  }

  setProfile(){
    if(MyConstant.currentCatModel!=null){
      CatModel catModel=MyConstant.currentCatModel!;
      setState(() {
        imgUrl=catModel.imgUrl;
        txtName.text=catModel.name!;
        currentGender=catModel.gender!;
        txtWeight.text=catModel.weight.toString();
        txtDob.text=dateFormat(catModel.dateOfBirth!.toDate());
        txtVaccineDate.text=dateFormat(catModel.vaccineDate!.toDate());
        txtNextvaccineDate.text=dateFormat(catModel.nextVaccineDate!.toDate());

        dob=catModel.dateOfBirth!.toDate();
        vcDate=catModel.vaccineDate!.toDate();
        nvcDate=catModel.nextVaccineDate!.toDate();

      });
    }else{
      print("No saveed");
    }
  }

}
