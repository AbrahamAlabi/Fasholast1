import 'package:flutter/material.dart';
import 'package:get/get.dart';

showLoading(){
  Get.defaultDialog(// Alert dialog
    title: "Pls hold...",
    content: CircularProgressIndicator(),
    barrierDismissible: false
  );
}

dismissLoadingWidget(){

  Get.back();// dismisess lodading screen
}