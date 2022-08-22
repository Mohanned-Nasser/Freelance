import 'package:catcare/util/alerts.dart';
import 'package:catcare/util/app_constants.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class CatModel {
  String? catId;
  String? name;
  String? gender;
  double? weight;
  Timestamp? dateOfBirth;
  Timestamp? vaccineDate;
  Timestamp? nextVaccineDate;
  String? imgUrl;

  CatModel(
      {this.catId,
        this.name,
        this.gender,
        this.weight,
        this.dateOfBirth,
        this.vaccineDate,
        this.nextVaccineDate,
        this.imgUrl});

  CatModel.fromJson(Map<String, dynamic> json) {
    catId = json['catId'];
    name = json['name'];
    gender = json['gender'];
    weight = json['weight'];
    dateOfBirth = json['dateOfBirth'];
    vaccineDate = json['vaccineDate'];
    nextVaccineDate = json['nextVaccineDate'];
    imgUrl = json['imgUrl'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['catId'] = this.catId;
    data['name'] = this.name;
    data['gender'] = this.gender;
    data['weight'] = this.weight;
    data['dateOfBirth'] = this.dateOfBirth;
    data['vaccineDate'] = this.vaccineDate;
    data['nextVaccineDate'] = this.nextVaccineDate;
    data['imgUrl'] = this.imgUrl;
    data['timestamp']=Timestamp.now();
    return data;
  }
  static CollectionReference users=FirebaseFirestore.instance.collection('users');

   Future<bool> updateCatProfile({context}) async {
     try {
       catId=MyConstant.currentUserID;
       await users.doc(MyConstant.currentUserID).collection('cat').doc(
           MyConstant.currentUserID).set(toJson());
       return true;
     }catch(e){
       MyAlerts.showInfoBox(context,e.toString());
       return false;
     }
  }

  static  getCatInfo() async {
     DocumentSnapshot documentSnapshot=await users.doc(MyConstant.currentUserID).collection('cat').doc(MyConstant.currentUserID).get();
     if(documentSnapshot.exists){
       MyConstant.currentCatModel=CatModel.fromJson(documentSnapshot.data() as  Map<String, dynamic>);
     }else{
       print("Documeent not exits");
       MyConstant.currentCatModel=null;
     }
  }
}
