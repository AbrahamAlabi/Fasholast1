import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:fasholast1/constants/asset_paths.dart';
import 'package:fasholast1/controllers/appController.dart';
import 'package:fasholast1/screens/authentication/widgets/bottom_text.dart';
import 'package:fasholast1/screens/authentication/widgets/login.dart';
import 'package:fasholast1/screens/authentication/widgets/registration.dart';

class AuthenticationScreen extends StatelessWidget {
  final AppController appController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey,
      body: Obx(() => SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(height: MediaQuery.of(context).size.width / 3),
            Image.asset(logo, width: 200,),
            SizedBox(height: MediaQuery.of(context).size.width / 5),

            Visibility(
                visible: appController.isLoginWidgetDisplayed.value,
                child: LoginWidget()),
            Visibility(
                visible: ! appController.isLoginWidgetDisplayed.value,
                child: RegistrationWidget()),
            SizedBox(
              height: 30,
            ),
            Visibility(
              visible: appController.isLoginWidgetDisplayed.value,
              child: BottomTextWidget(
                onTap: () {
                  appController.changeDIsplayedAuthWidget();
                },
                sent: "Don\'t have an account?",
                click: "Create account!",
              ),
            ),
            Visibility(
              visible: !appController.isLoginWidgetDisplayed.value,
              child: BottomTextWidget(
                onTap: () {
                  appController.changeDIsplayedAuthWidget();
                },
                sent: " have an account?",
                click: "Sign IN ",
              ),
            ),
          ],
        ),
      ),)
    );
  }
}
