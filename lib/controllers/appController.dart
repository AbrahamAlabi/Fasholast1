import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class AppController extends GetxController{
  static AppController instance = Get.find();// find an instance
  var isLoginWidgetDisplayed = true.obs;


  changeDIsplayedAuthWidget(){
    isLoginWidgetDisplayed.value = !isLoginWidgetDisplayed.value;
  }

}