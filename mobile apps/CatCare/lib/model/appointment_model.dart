import 'package:catcare/util/alerts.dart';
import 'package:catcare/util/app_constants.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class AppointmentModel {
  String? appointmentId;
  String? appointmentName;
  Timestamp? appointmentDate;
  String? appointmentStatus;
  String? appointmentBookedBy;

  AppointmentModel(
      {this.appointmentId,
        this.appointmentDate,
        this.appointmentName,
        this.appointmentStatus,
        this.appointmentBookedBy});

  AppointmentModel.fromJson(Map<String, dynamic> json) {
    appointmentId = json['appointmentId'];
    appointmentDate = json['appointmentDate'];
    appointmentName=json['appointmentName'];
    appointmentStatus = json['appointmentStatus'];
    appointmentBookedBy = json['appointmentBookedBy'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['appointmentId'] = this.appointmentId;
    data['appointmentName']=this.appointmentName;
    data['appointmentDate'] = this.appointmentDate;
    data['appointmentStatus'] = this.appointmentStatus;
    data['appointmentBookedBy'] = this.appointmentBookedBy;
    data['timestamp']=Timestamp.now();
    return data;
  }

  static CollectionReference appointment=FirebaseFirestore.instance.collection('appointments');

  Future<bool> bookAppointment({required context}) async {
    try {
      appointmentId = appointment
          .doc()
          .id;
      await appointment.doc(appointmentId).set(toJson());
      return true;
    }catch(e){
      Navigator.pop(context);
      MyAlerts.showInfoBox(context,e.toString());
      return false;
    }
  }
  Future<bool> deleteAppointment({required context,String? appointmentId}) async {
    try {
      await appointment.doc(appointmentId).delete();
      return true;
    }catch(e){
      MyAlerts.showInfoBox(context,e.toString());
      return false;
    }
  }
  Future<bool> updateAppointmentStatus({required context,String? appointmentId,String? status}) async {
    try {
      await appointment.doc(appointmentId).update({
        'appointmentStatus':status
      });
      return true;
    }catch(e){
      MyAlerts.showInfoBox(context,e.toString());
      return false;
    }
  }
  getAllAppointments(){
    return appointment.orderBy('appointmentDate',descending: false).snapshots();
  }getMyAppointments(){
    return appointment.orderBy('appointmentDate',descending: false).where('appointmentBookedBy',isEqualTo: MyConstant.currentUserID).snapshots();
  }
}
