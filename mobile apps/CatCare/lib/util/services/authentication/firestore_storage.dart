import 'dart:io';

import 'package:catcare/util/alerts.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:path/path.dart';

class FirestoreService{


  static FirebaseStorage storage=FirebaseStorage.instance;

 static Future<bool> deleteFromStorage(context,url) async {
    try{
      await storage.refFromURL(url).delete();
      Navigator.pop(context);
      return true;
    }catch(e){
      Navigator.pop(context);
      MyAlerts.showInfoBox(context,e.toString());
      return false;
    }
  }

  // upload images to storage and let links
  static Future<String?> uploadImageToFirestore({required folderName,required File img,required context}) async{
    String imgUrl='';
    try{
      var ref=storage.ref().child('${folderName}/${basename(img.path)}');
      await ref.putFile(img).whenComplete(() async {
        await ref.getDownloadURL().then((value){
          print("Image url $value");
          imgUrl=value;
        });
      });
      Navigator.pop(context);
      return imgUrl;
    }catch(e){
      Navigator.pop(context);
      MyAlerts.showInfoBox(context,e.toString());
      return "null";
    }
  }
}