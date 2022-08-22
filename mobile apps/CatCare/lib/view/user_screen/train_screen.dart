import 'package:catcare/model/train_model.dart';
import 'package:catcare/util/app_constants.dart';
import 'package:catcare/util/app_navigator.dart';
import 'package:catcare/view/admin/add_training.dart';
import 'package:catcare/widgets/custom_button.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../util/app_color.dart';
import '../../util/app_style.dart';
import '../../util/asset_path.dart';
import '../../widgets/custom_appbar.dart';
import '../../widgets/custom_widgets.dart';
import '../drawer_screen.dart';

class TrainScreen extends StatefulWidget {
  const TrainScreen({Key? key}) : super(key: key);

  @override
  _TrainScreenState createState() => _TrainScreenState();
}

class _TrainScreenState extends State<TrainScreen> {
  GlobalKey<ScaffoldState> _key = GlobalKey(); // add this
  bool isAdmin=MyConstant.isAdmin;
  final _stream=TrainModel().getAllTrainings();
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
              title: "TRAIN",
              drawerAction: () {
                _key.currentState!.openEndDrawer();
              }),
          body: Stack(
            children: [
              StreamBuilder<QuerySnapshot>(
                  stream: _stream,
                  builder: (context, snapshot) {

                    if (!snapshot.hasData) {
                      return Center(child: CircularProgressIndicator.adaptive());
                    }
                    if (snapshot.data!.size == 0) {
                      return Center(
                        child: Text(
                          'No training yet',
                          style: fredokaTextStyle(),
                        ),
                      );
                    }
                    var allDocs = snapshot.data!.docs;
                    List<TrainModel> trains = [];
                    for (var doc in allDocs) {
                      var model = TrainModel.fromJson(
                          doc.data() as Map<String, dynamic>);
                      trains.add(model);
                    }
                  return ListView.builder(
                    itemCount: trains.length,
                    itemBuilder: (context, index) {
                      return trainContainer(context: context,trainModel: trains[index]);
                    },
                  );
                }
              ),
              Visibility(
                visible: isAdmin,
                child: Padding(
                  padding: EdgeInsets.all(18.h),
                  child: Align(
                    alignment: Alignment.bottomCenter,
                    child: customButton(text: "Add Training", action: () {
                      AppNavigator.push(context, AddTrainingScreen());
                    }),
                  ),
                ),
              )
            ],
          )),
    ));
  }
}
