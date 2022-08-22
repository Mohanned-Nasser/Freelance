import 'package:catcare/util/alerts.dart';
import 'package:catcare/util/app_constants.dart';
import 'package:catcare/util/services/authentication/firestore_storage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';

class VaccineModel {
  String? vaccineId;
  String? vaccineType;
  String? vaccineName;
  String? vaccineUsage;
  String? vaccineAge;
  double? vaccinePrice;
  String? vaccineImgUrl;

  VaccineModel(
      {this.vaccineId,
        this.vaccineName,
        this.vaccineType,
        this.vaccineAge,
        this.vaccineUsage,
        this.vaccinePrice,
        this.vaccineImgUrl});

  VaccineModel.fromJson(Map<String, dynamic> json) {
    vaccineId = json['vaccineId'];
    vaccineName=json['vaccineName'];
    vaccineAge=json['vaccineAge'];
    vaccineType = json['vaccineType'];
    vaccineUsage = json['vaccineUsage'];
    vaccinePrice = json['vaccinePrice'];
    vaccineImgUrl = json['vaccineImgUrl'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['vaccineName']=this.vaccineName;
    data['vaccineId'] = this.vaccineId;
    data['vaccineAge']=this.vaccineAge;
    data['vaccineType'] = this.vaccineType;
    data['vaccineUsage'] = this.vaccineUsage;
    data['vaccinePrice'] = this.vaccinePrice;
    data['vaccineImgUrl'] = this.vaccineImgUrl;
    data['timestamp']=Timestamp.now();
    return data;
  }

 static CollectionReference vaccines=FirebaseFirestore.instance.collection('vaccines');
  static CollectionReference bookedVaccines=FirebaseFirestore.instance.collection('booked Vaccines');


   Future<bool> uploadVaccine({required context}) async {
     try {
       vaccineId = vaccines
           .doc()
           .id;
       await vaccines.doc(vaccineId).set(toJson());
       return true;
     }catch(e){
       Navigator.pop(context);
       MyAlerts.showInfoBox(context,e.toString());
       return false;
     }
  }

  static Future<bool> bookVaccine({required context,required VaccineModel vaccine,required date}) async {
    try {
      String bookedVaccineId = bookedVaccines.doc().id;
      await bookedVaccines.doc(bookedVaccineId).set({
        'vaccineId':vaccine.vaccineId,
        'bookedBy':MyConstant.currentUserID,
        'date':Timestamp.fromDate(date),
        'timestamp':Timestamp.now()
      });
      return true;
    }catch(e){
      Navigator.pop(context);
      MyAlerts.showInfoBox(context,e.toString());
      return false;
    }
  }

  Future<bool> deleteVaccine({required context,String? vaccineId}) async {
     MyAlerts.showAlertDialog(context, "Delete", "DELETE", "Do you really want to delete it?",() async {
       try {
         await vaccines.doc(vaccineId).delete();
         return true;
       }catch(e){
         MyAlerts.showInfoBox(context,e.toString());
         return false;
       }
     });
     return false;
  }
  getAllVaccines(){
       return vaccines.orderBy('timestamp',descending: true).snapshots();
  }
}
