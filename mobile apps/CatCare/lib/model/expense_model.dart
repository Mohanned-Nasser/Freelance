import 'package:catcare/util/alerts.dart';
import 'package:catcare/util/app_constants.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ExpenseModel {
  String? expenseId;
  String? item;
  Timestamp? expenseDate;
  double? cost;

  ExpenseModel({this.expenseId, this.item,this.expenseDate, this.cost});

  ExpenseModel.fromJson(Map<String, dynamic> json) {
    expenseId = json['expenseId'];
    item = json['item'];
    expenseDate=json['expenseDate'];
    cost = json['cost'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['expenseId'] = this.expenseId;
    data['item'] = this.item;
    data['cost'] = this.cost;
    data['expenseDate']=this.expenseDate;
    data['timestamp']=Timestamp.now();
    return data;
  }
  static CollectionReference users=FirebaseFirestore.instance.collection('users');

  Future<bool> addExpenses({required context}) async {
    try {
      expenseId = users.doc(MyConstant.currentUserID).collection('Expenses').doc().id;
      await  users.doc(MyConstant.currentUserID).collection('Expenses').doc(expenseId).set(toJson());
      return true;
    }catch(e){
      print(e.toString());
      Navigator.pop(context);
      MyAlerts.showInfoBox(context,e.toString());
      return false;
    }
  }

  static getExpenseOfMonth(DateTime cur_date){
    try {
      DateFormat inputFormat = DateFormat('yyyy-MM-dd hh:mm:ss');
      int maxDate = 31;
      if (cur_date.month == 4 || cur_date.month == 6 || cur_date.month == 9 ||
          cur_date.month == 11) {
        maxDate = 30;
      } else if (cur_date.month == 2) {
        maxDate = 28;
      }
      print("Days of this month ${maxDate}");

      return users.doc(MyConstant.currentUserID).collection('Expenses')
          .where('expenseDate', isGreaterThan: inputFormat.parse(
          "${cur_date.year}-${cur_date.month}-1 00:00:00"))
          .where('expenseDate', isLessThan: inputFormat.parse(
          "${cur_date.year}-${cur_date.month}-${maxDate} 24:00:00"))
          .snapshots();
    }catch(e){
      print(e.toString());
    }
  }

}
