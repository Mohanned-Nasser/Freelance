import 'dart:io';

import 'package:catcare/model/train_model.dart';
import 'package:catcare/util/alerts.dart';
import 'package:catcare/util/app_color.dart';
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

class AddTrainingScreen extends StatefulWidget {
  const AddTrainingScreen({Key? key}) : super(key: key);

  @override
  _AddTrainingScreenState createState() => _AddTrainingScreenState();
}

class _AddTrainingScreenState extends State<AddTrainingScreen> {
  GlobalKey<ScaffoldState> _key = GlobalKey(); // add this

  final txtTitle = TextEditingController();
  final txtDescription = TextEditingController();
  final txtVideoUrl = TextEditingController();

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
                  title: "ADD TRAINING",
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
                        decoration: BoxDecoration(color: AppColors.appSkyBlueColor),
                        child: Column(
                          children: [
                            customTextField(controller: txtTitle, label: "Title"),
                            customTextField(controller: txtDescription, label: "Description",isDescription: true),
                            customTextField(controller: txtVideoUrl, label: "Video Url"),
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
                    customButton(text: "Add", action: () {
                      addTraining();
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


  String? title, description, videoUrl, imgUrl;

  getValues() {
    title = txtTitle.text;
    description = txtDescription.text;
    videoUrl = txtVideoUrl.text;
  }

  isEmpty() {
    if (title!.isEmpty ||
        description!.isEmpty ||
        videoUrl!.isEmpty ||
        _image == null) {
      return true;
    } else {
      return false;
    }
  }

  addTraining() async {
    getValues();
    if (isEmpty()) {
      MyAlerts.showInfoBox(context, "Please fill all details");
    } else {
      customLoadingIndicator(context, text: "Uploading Image...");
      imgUrl = await FirestoreService.uploadImageToFirestore(
          folderName: "TrainingImages", img: _image!, context: context);
      customLoadingIndicator(context, text: "Uploading Training...");
      TrainModel trainModel = TrainModel(
          title: title,
          description: description,
          videoUrl: videoUrl,
          imgUrl: imgUrl,
      );
      bool result = await trainModel.uploadTraining(context: context);
      if (result) {
        Navigator.pop(context);
        MyAlerts.showInfoBox(context, "New Training Uploaded Successfully.");
      }
    }
  }
}
