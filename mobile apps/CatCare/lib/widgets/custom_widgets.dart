import 'package:cached_network_image/cached_network_image.dart';
import 'package:catcare/model/news_model.dart';
import 'package:catcare/util/app_color.dart';
import 'package:catcare/util/app_constants.dart';
import 'package:catcare/util/app_navigator.dart';
import 'package:catcare/util/asset_path.dart';
import 'package:catcare/util/format_dates.dart';
import 'package:catcare/view/user_screen/book_vaccine_screen.dart';
import 'package:catcare/view/user_screen/video_player_screen.dart';
import 'package:catcare/widgets/custom_loader.dart';
import 'package:drop_cap_text/drop_cap_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../model/appointment_model.dart';
import '../model/train_model.dart';
import '../model/vaccine_model.dart';
import '../util/app_style.dart';
import 'custom_button.dart';

Widget homeContainer({String? imgPath, String? title, action}) {
  return GestureDetector(
    onTap: () {
      action();
    },
    child: SizedBox(
      height: 149.h,
      width: 114.w,
      child: Column(
        children: [
          Container(
            height: 122.h,
            width: 114.w,
            decoration: BoxDecoration(
                color: AppColors.appSkyBlueColor,
                borderRadius: BorderRadius.circular(4.r)),
            child: Center(
              child: Image.asset(
                imgPath!,
                height: 56.h,
                width: 56.w,
              ),
            ),
          ),
          Container(
            height: 26.h,
            width: 114.w,
            decoration: BoxDecoration(
              color: AppColors.appOrangeColor,
              borderRadius: BorderRadius.circular(8.r),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  spreadRadius: 2,
                  blurRadius: 5,
                  offset: Offset(0, 3), // changes position of shadow
                ),
              ],
            ),
            child: Center(
                child: Text(
              title!,
              style: homeContainerStyle(),
            )),
          ),
        ],
      ),
    ),
  );
}

Widget vaccineContainer({VaccineModel? vaccineModel, required context}) {
  return Padding(
    padding: EdgeInsets.only(bottom: 33.h, top: 10.h),
    child: Container(
      height: 200.h,
      width: 1.sw,
      color: Colors.transparent,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Image.asset(
              //   AssetsPath.bottle,
              //   width: 112.w,
              //   height: 150.h,
              // ),
              cachedImage(
                  url: vaccineModel!.vaccineImgUrl,
                  height: 150.h,
                  width: 112.w),
              Container(
                height: 40.h,
                width: 106.w,
                child: Center(
                    child: Text(
                  '${vaccineModel.vaccineType}',
                  style: fredokaTextStyle(fontSize: 20.sp),
                )),
                decoration: BoxDecoration(
                    color: AppColors.appWhiteColor,
                    borderRadius: BorderRadius.circular(52.r)),
              )
            ],
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      'Vaccine Text: ',
                      style: epilogueTextStyle(fontWeight: FontWeight.bold),
                    ),
                    Text(
                      '${vaccineModel.vaccineName}',
                      style: epilogueTextStyle(),
                    ),
                  ],
                ),
                SizedBox(
                  height: 5.h,
                ),
                Wrap(
                  children: [
                    Text(
                      'Vaccination Age: ',
                      style: epilogueTextStyle(fontWeight: FontWeight.bold),
                    ),
                    Text(
                      '${vaccineModel.vaccineAge}',
                      style: epilogueTextStyle(),
                    ),
                  ],
                ),
                SizedBox(
                  height: 5.h,
                ),
                SizedBox(
                  width: 250.w,
                  height: 50.h,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Usage: ',
                        style: epilogueTextStyle(fontWeight: FontWeight.bold),
                      ),
                      Flexible(
                          child: Text(
                        '${vaccineModel.vaccineUsage}',
                        overflow: TextOverflow.ellipsis,
                        maxLines: 3,
                        style: epilogueTextStyle(),
                      )),
                    ],
                  ),
                ),
                Center(
                  child: customButton(
                      text: MyConstant.isAdmin?"Delete":"Book now!",
                      action: () async {
                        if(MyConstant.isAdmin){
                          await VaccineModel().deleteVaccine(context: context,vaccineId: vaccineModel.vaccineId);
                        }else {
                          AppNavigator.push(
                              context,
                              BookVaccineScreen(
                               vaccineModel: vaccineModel,
                              ));
                        }
                      }),
                ),
              ],
            ),
          ),
        ],
      ),
    ),
  );
}

Widget trainContainer({TrainModel? trainModel, required context}) {
  return Padding(
    padding: EdgeInsets.only(bottom: 10.h, top: 10.h),
    child: Container(
      height: 200.h,
      width: 1.sw,
      color: Colors.transparent,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Column(
            children: [
              cachedImage(url: trainModel!.imgUrl,height: 135.h,
                width: 132.w,),
              SizedBox(
                height: 5.h,
              ),
              Container(
                height: 28.h,
                width: 122.w,
                child: Center(
                    child: Text(
                  '${trainModel.title}',
                  style: fredokaTextStyle(fontSize: 20.sp),
                )),
                decoration: BoxDecoration(
                    color: AppColors.appWhiteColor,
                    borderRadius: BorderRadius.circular(52.r)),
              )
            ],
          ),
          Container(
            height: 120.h,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 80.h,
                  width: 172.w,
                  child: Text(
                    '${trainModel.description}',
                    overflow: TextOverflow.ellipsis,
                    maxLines: 5,
                    style: epilogueTextStyle(),
                  ),
                ),
                Center(
                  child: Row(
                    children: [
                      customButton(
                          text: "Watch Video",
                          action: () {
                            print("Video url is ${trainModel.videoUrl}");
                            AppNavigator.push(
                                context,
                                VideoPlayerScreen(
                                  videoUrl: '${trainModel.videoUrl}',
                                ));
                          }),
                      Visibility(
                          visible: MyConstant.isAdmin,
                          child: IconButton(
                              onPressed: () {
                                TrainModel().deleteTraining(context: context,trainingId: trainModel.trainingId);
                              },
                              icon: Icon(
                                Icons.delete,
                                color: Colors.red,
                              )))
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    ),
  );
}


Widget newsContainer({NewsModel? newsModel,context}) {
  return Padding(
    padding: EdgeInsets.only(bottom: 32.h),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        DropCapText(
          "${newsModel!.description}",
          style: epilogueTextStyle(),
          dropCap: DropCap(
            width: 125.w,
            height: 147.h,
            child: cachedImage( width: 125.w,
              height: 147.h,url: newsModel.imgUrl)
          ),
        ),
        Visibility(
            visible: MyConstant.isAdmin,
            child: IconButton(
                onPressed: () {
                  NewsModel().deleteNews(context: context,newsId: newsModel.newsId);
                },
                icon: Icon(
                  Icons.delete,
                  color: Colors.red,
                )))
      ],
    ),
  );
}

Widget appointmentTile({AppointmentModel? appointmentModel}) {
  return Padding(
    padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 5.h),
    child: Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  '${appointmentModel!.appointmentName}',
                  style: epilogueTextStyle(fontSize: 17.sp),
                ),
                SizedBox(
                  height: 8.h,
                ),
                Text(
                  appointmentModel.appointmentStatus == "pending"
                      ? 'Pending'
                      : "Approved",
                  style: epilogueTextStyle(
                      fontSize: 12.sp,
                      color: appointmentModel.appointmentStatus == "pending"
                          ? Colors.red
                          : Colors.green),
                ),
              ],
            ),
            Text(
              '${dateFormat(appointmentModel.appointmentDate!.toDate())}',
              style: epilogueTextStyle(
                  fontSize: 12.sp,
                  color: appointmentModel.appointmentStatus == "pending"
                      ? Colors.red
                      : Colors.green),
            ),
          ],
        ),
        Divider(
          thickness: 1,
        )
      ],
    ),
  );
}

cachedImage({String? url, double? height, double? width}) {
  return Container(
    child: CachedNetworkImage(
      imageUrl: url!,
      imageBuilder: (context, imageProvider) => Padding(
        padding:  EdgeInsets.symmetric(horizontal: 10.w,vertical: 5.h),
        child: Container(
          width: width ?? 80.0,
          height: height ?? 80.0,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15.r),
            image: DecorationImage(image: imageProvider, fit: BoxFit.cover),
          ),
        ),
      ),
      progressIndicatorBuilder: (context, url, downloadProgress) =>
          CircularProgressIndicator(value: downloadProgress.progress,color: AppColors.appOrangeColor,),
      errorWidget: (context, url, error) => Icon(Icons.error),
    ),
  );
}

profileCachedImage({String? url, double? height, double? width}) {
  return CachedNetworkImage(
    imageUrl: url!,
    imageBuilder: (context, imageProvider) => Container(
      height: 150.h,
      width: 130.w,
      decoration: BoxDecoration(
        border: Border.all(color: Colors.black),
        borderRadius: BorderRadius.circular(100.r),
        image: DecorationImage(image: imageProvider, fit: BoxFit.cover),
      ),
    ),
    progressIndicatorBuilder: (context, url, downloadProgress) =>
        CircularProgressIndicator(value: downloadProgress.progress),
    errorWidget: (context, url, error) => Icon(Icons.error),
  );
}
