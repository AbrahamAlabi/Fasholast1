import 'dart:io';

import 'package:fasholast1/screens/payments/paymentss.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:fasholast1/constants/controllers.dart';
import 'package:fasholast1/screens/home/widgets/products.dart';
import 'package:fasholast1/screens/home/widgets/shopping_cart.dart';
import 'package:fasholast1/widgets/custom_text.dart';
import'API.dart';

class HomeScreen extends StatelessWidget {
  File _image;
  final imagePicker =ImagePicker();

  Future getImage() async{
    final image = await imagePicker.getImage(source: ImageSource.camera);
    setState((){
      _image = File(image.path);
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.blueGrey,
          iconTheme: IconThemeData(color: Colors.black),
          title: CustomText(
            text: "Fasho Reality",
            size: 28,
            weight: FontWeight.bold,
          ),
          actions: [
            IconButton(
                icon: Icon(Icons.shopping_cart),
                onPressed: () {
                  showBarModalBottomSheet(
                    context: context,
                    builder: (context) => Container(
                      color: Colors.white,
                      child: ShoppingCart(),
                    ),
                  );
                })
          ],
          elevation: 0,
          centerTitle: true,
        ),
        backgroundColor: Colors.white,
        drawer: Drawer(
          child: ListView(
            children: [
              Obx(()=>UserAccountsDrawerHeader(
                decoration: BoxDecoration(
                  color: Colors.blueGrey
                ),
                  accountName: Text(authController.userModel.value.name ?? ""),
                  accountEmail: Text(authController.userModel.value.email ?? ""))),
              ListTile(
                onTap: () {
                  ;
                },
                leading: Icon(Icons.app_blocking_outlined),
                title: Text("Favourites"),
              ),
              ListTile(
                onTap: () {
                  paymentsController.getPaymentHistory();
                },
                leading: Icon(Icons.history),
                title: Text("History"),
              ),


              ListTile(
                onTap: () {
                  authController.signOut();
                },
                leading: Icon(Icons.exit_to_app),
                title: Text("Log out"),
              )
            ],
          ),
        ),

        floatingActionButton: FloatingActionButton(

          tooltip: 'Increment',
          child: Icon(Icons.camera_alt),
          onPressed: getImage,
        ),
        body: Container(
          color: Colors.white30,
          child: ProductsWidget(),
        ));

  }

  void setState(Null Function() param0) {}
}
