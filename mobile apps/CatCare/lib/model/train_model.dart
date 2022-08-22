import 'package:catcare/util/alerts.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class TrainModel {
  String? trainingId;
  String? title;
  String? description;
  String? videoUrl;
  String? imgUrl;

  TrainModel(
      {this.trainingId,
        this.title,
        this.description,
        this.videoUrl,
        this.imgUrl});

  TrainModel.fromJson(Map<String, dynamic> json) {
    trainingId = json['trainingId'];
    title = json['title'];
    description = json['description'];
    videoUrl = json['videoUrl'];
    imgUrl = json['imgUrl'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['trainingId'] = this.trainingId;
    data['title'] = this.title;
    data['description'] = this.description;
    data['videoUrl'] = this.videoUrl;
    data['imgUrl'] = this.imgUrl;
    data['timestamp']=Timestamp.now();
    return data;
  }

  static CollectionReference train=FirebaseFirestore.instance.collection('train');

  Future<bool> uploadTraining({required context}) async {
    try {
      trainingId = train
          .doc()
          .id;
      await train.doc(trainingId).set(toJson());
      return true;
    }catch(e){
      MyAlerts.showInfoBox(context,e.toString());
      return false;
    }
  }
  Future<bool> deleteTraining({required context,String? trainingId}) async {
    MyAlerts.showAlertDialog(context, "Delete", "DELETE", "Do you really want to delete it?",() async {
      try {
        await train.doc(trainingId).delete();
        return true;
      }catch(e){
        MyAlerts.showInfoBox(context,e.toString());
        return false;
      }
    });
    return false;
  }

  getAllTrainings(){
    return train.orderBy('timestamp',descending: true).snapshots();
  }
}
