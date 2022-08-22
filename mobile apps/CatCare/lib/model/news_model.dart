import 'package:catcare/util/alerts.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class NewsModel {
  String? newsId;
  String? title;
  String? description;
  String? imgUrl;

  NewsModel({this.newsId, this.title, this.description, this.imgUrl});

  NewsModel.fromJson(Map<String, dynamic> json) {
    newsId = json['newsId'];
    title = json['title'];
    description = json['description'];
    imgUrl = json['imgUrl'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['newsId'] = this.newsId;
    data['title'] = this.title;
    data['description'] = this.description;
    data['imgUrl'] = this.imgUrl;
    data['timestamp']=Timestamp.now();
    return data;
  }


  static CollectionReference news=FirebaseFirestore.instance.collection('news');

  Future<bool> uploadNews({required context}) async {
    try {
      newsId = news
          .doc()
          .id;
      await news.doc(newsId).set(toJson());
      return true;
    }catch(e){
      MyAlerts.showInfoBox(context,e.toString());
      return false;
    }
  }
  Future<bool> deleteNews({required context,String? newsId}) async {
    MyAlerts.showAlertDialog(context, "Delete", "DELETE", "Do you really want to delete it?",() async {
      try {
        await news.doc(newsId).delete();
        return true;
      }catch(e){
        MyAlerts.showInfoBox(context,e.toString());
        return false;
      }
    });
    return false;
  }

  getAllNews(){
    return news.orderBy('timestamp',descending: true).snapshots();
  }
}
