import 'package:catcare/util/alerts.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ClinicModel {
  String? clinicId;
  String? aboutUs;
  String? address;
  String? hours;
  String? phone;
  String? imgUrl;

  ClinicModel(
      {this.clinicId,
        this.aboutUs,
        this.address,
        this.hours,
        this.phone,
        this.imgUrl});

  ClinicModel.fromJson(Map<String, dynamic> json) {
    clinicId = json['clinicId'];
    aboutUs = json['aboutUs'];
    address = json['address'];
    hours = json['hours'];
    phone = json['phone'];
    imgUrl = json['imgUrl'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['clinicId'] = this.clinicId;
    data['aboutUs'] = this.aboutUs;
    data['address'] = this.address;
    data['hours'] = this.hours;
    data['phone'] = this.phone;
    data['imgUrl'] = this.imgUrl;
    data['timestamp']=Timestamp.now();
    return data;
  }
  static CollectionReference clinic=FirebaseFirestore.instance.collection('clinic');

  Future<bool> updateClinicInfo({required context}) async {
    try {
      clinicId='clinic123';
      await clinic.doc('clinic123').set(toJson());
      return true;
    }catch(e){
      MyAlerts.showInfoBox(context,e.toString());
      return false;
    }
  }

  getClinicInfo(){
    return clinic.snapshots();
  }
}
