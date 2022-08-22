import 'package:catcare/model/news_model.dart';
import 'package:catcare/util/app_constants.dart';
import 'package:catcare/util/app_navigator.dart';
import 'package:catcare/view/admin/add_news.dart';
import 'package:catcare/widgets/custom_button.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../util/app_color.dart';
import '../../util/app_style.dart';
import '../../widgets/custom_appbar.dart';
import '../../widgets/custom_widgets.dart';
import '../drawer_screen.dart';

class NewsScreen extends StatefulWidget {
  const NewsScreen({Key? key}) : super(key: key);

  @override
  _NewsScreenState createState() => _NewsScreenState();
}

class _NewsScreenState extends State<NewsScreen> {
  GlobalKey<ScaffoldState> _key = GlobalKey(); // add this
bool isAdmin=MyConstant.isAdmin;
final _stream=NewsModel().getAllNews();
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
              title: "NEWS",
              drawerAction: () {
                _key.currentState!.openEndDrawer();
              }),
          body: Stack(
            children: [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.w),
                child: StreamBuilder<QuerySnapshot>(
                    stream: _stream,
                    builder: (context, snapshot) {

                      if (!snapshot.hasData) {
                        return Center(child: CircularProgressIndicator.adaptive());
                      }
                      if (snapshot.data!.size == 0) {
                        return Center(
                          child: Text(
                            'No News yet',
                            style: fredokaTextStyle(),
                          ),
                        );
                      }
                      var allDocs = snapshot.data!.docs;
                      List<NewsModel> news = [];
                      for (var doc in allDocs) {
                        var model = NewsModel.fromJson(
                            doc.data() as Map<String, dynamic>);
                        news.add(model);
                      }
                    return ListView.builder(
                      itemCount: news.length,
                      itemBuilder: (context, index) {
                        return newsContainer(newsModel:news[index],context: context);
                      },
                    );
                  }
                ),
              ),
              Visibility(
                visible: isAdmin,
                child: Padding(
                  padding: EdgeInsets.all(18.h),
                  child: Align(
                    alignment: Alignment.bottomCenter,
                    child: customButton(text: "Add News", action: () {
                      AppNavigator.push(context, AddNewsScreen());
                    }),
                  ),
                ),
              )
            ],
          )),
    ));
  }
}
