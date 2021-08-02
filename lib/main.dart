import 'package:fasholast1/controllers/cart_Controller.dart';
import 'package:flutter/material.dart';
import 'package:fasholast1/screens/authentication/auth.dart';
import 'package:fasholast1/screens/home/home.dart';
import 'package:get/get.dart';
import 'package:fasholast1/screens/splash/splash.dart';
import 'constants/firebase.dart';
import 'controllers/appController.dart';
import 'controllers/authController.dart';
import 'controllers/payments_Controller.dart';
import 'controllers/products_coontroller.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initialization.then((value) {
    Get.put(AppController()); //registering controllers in the main
    Get.put(AuthController()); //registering controllers
    Get.put(ProdController()); //registering controllers
    Get.put(CartController()); //registering controllers
    Get.put(PaymentsController()); //registering controllers
  });
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: SplashScreen(),
    );
  }
}
