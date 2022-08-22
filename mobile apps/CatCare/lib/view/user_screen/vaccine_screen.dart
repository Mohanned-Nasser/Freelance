import 'package:catcare/model/vaccine_model.dart';
import 'package:catcare/util/app_constants.dart';
import 'package:catcare/util/app_navigator.dart';
import 'package:catcare/view/admin/add_vaccine_screen.dart';
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

class VaccineScreen extends StatefulWidget {
  const VaccineScreen({Key? key}) : super(key: key);

  @override
  _vaccineScreenState createState() => _vaccineScreenState();
}

class _vaccineScreenState extends State<VaccineScreen> {
  GlobalKey<ScaffoldState> _key = GlobalKey(); // add this
  bool isAdmin = MyConstant.isAdmin;
  final _stream=VaccineModel().getAllVaccines();

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
              title: "VACCINE",
              drawerAction: () {
                _key.currentState!.openEndDrawer();
              }),
          body: Padding(
            padding: EdgeInsets.only(top: 15.h),
            child: Stack(
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
                          'No vaccine yet',
                          style: fredokaTextStyle(),
                        ),
                      );
                    }
                    var allDocs = snapshot.data!.docs;
                    List<VaccineModel> vaccines = [];
                    for (var doc in allDocs) {
                      var model = VaccineModel.fromJson(
                          doc.data() as Map<String, dynamic>);
                      vaccines.add(model);
                    }
                    return ListView.builder(
                      itemCount: vaccines.length,
                      itemBuilder: (context, index) {
                        return vaccineContainer(context: context,vaccineModel: vaccines[index]);
                      },
                    );
                  }
                ),
                Visibility(
                  visible: MyConstant.isAdmin,
                  child: Padding(
                    padding:  EdgeInsets.all(8.h),
                    child: Align(
                        alignment: Alignment.bottomCenter,
                        child: customButton(text: "Add Vaccine", action: () {
                          AppNavigator.push(context, AddVaccineScreen());
                        })),
                  ),
                ),
              ],
            ),
          )),
    ));
  }
}
