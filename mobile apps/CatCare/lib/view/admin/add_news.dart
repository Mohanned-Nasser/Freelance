import 'dart:io';

import 'package:catcare/model/news_model.dart';
import 'package:catcare/util/alerts.dart';
import 'package:catcare/util/app_color.dart';
import 'package:catcare/util/services/authentication/firestore_storage.dart';
import 'package:catcare/view/drawer_screen.dart';
import 'package:catcare/widgets/custom_appbar.dart';
import 'package:catcare/widgets/custom_button.dart';
import 'package:catcare/widgets/custom_textfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';

import '../../util/app_style.dart';
import '../../widgets/custom_loader.dart';

class AddNewsScreen extends StatefulWidget {
  const AddNewsScreen({Key? key}) : super(key: key);

  @override
  _AddNewsScreenState createState() => _AddNewsScreenState();
}

class _AddNewsScreenState extends State<AddNewsScreen> {
  GlobalKey<ScaffoldState> _key = GlobalKey(); // add this

  final txtTitle = TextEditingController();
  final txtDescription = TextEditingController();

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
                  title: "ADD NEWS",
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
                      addNews();
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


  String? title, description, imgUrl;

  getValues() {
    title = txtTitle.text;
    description = txtDescription.text;
  }

  isEmpty() {
    if (title!.isEmpty ||
        description!.isEmpty ||
        _image == null) {
      return true;
    } else {
      return false;
    }
  }

  addNews() async {
    getValues();
    if (isEmpty()) {
      MyAlerts.showInfoBox(context, "Please fill all details");
    } else {
      customLoadingIndicator(context, text: "Uploading Image...");
      imgUrl = await FirestoreService.uploadImageToFirestore(
          folderName: "NewsImages", img: _image!, context: context);
      customLoadingIndicator(context, text: "Uploading Training...");
      NewsModel newsModel = NewsModel(
        title: title,
        description: description,
        imgUrl: imgUrl,
      );
      bool result = await newsModel.uploadNews(context: context);
      if (result) {
        Navigator.pop(context);
        MyAlerts.showInfoBox(context, "New News Uploaded Successfully.");
      }
    }
  }
}

