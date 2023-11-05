

import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:localsaveimage/controller/sqlhelper.dart';
import 'package:permission_handler/permission_handler.dart';

class mydata extends ChangeNotifier
{

 requestPermission()async
  {
    var cameraPermission=Permission.camera;
    bool isGranted=await cameraPermission.isGranted;
   


    print(isGranted);
    if(isGranted)
      {
return;
      }
    else
      {
        await Permission.camera.request();
      }

  }



   List MypicCodes=[];
   List<Uint8List> mypic=[];
fetchData()async
{
  mypic=[];
  MypicCodes=[];
  print("fetching data");
  List<Map> res =await sqlHelper().selectDb("SELECT * FROM Mypic;");
  print("my data");
  print(res);
  res.forEach((element) {
    element.forEach((key, value) {
      MypicCodes.add(value);
     });
  },);
  print("my data");
  print(MypicCodes.length);
  
  MypicCodes.forEach((element) {
    mypic.add(base64Decode(element));
   });
   notifyListeners();
}
Future<void> saveData(String data)async
{
 var res = await sqlHelper().insertDb("INSERT INTO mypic VALUES (?);",data);
 fetchData();
 notifyListeners();
}
}