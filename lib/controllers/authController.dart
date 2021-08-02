import 'package:fasholast1/constants/pp_constant.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:fasholast1/constants/firebase.dart';
import 'package:fasholast1/models/user.dart';
import 'package:fasholast1/screens/authentication/auth.dart';
import 'package:fasholast1/screens/home/home.dart';
import 'package:fasholast1/utils/loading/showLoading.dart';

class AuthController extends GetxController {
  static AuthController instance = Get.find();//get an instance of the controller
  Rx<User> firebaseUser;
  RxBool isLoggedIn = false.obs;// expalins that user is not logged in
  TextEditingController name = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  String usersCollection = "users";// users collection name // defined
  Rx<UserModel> userModel = UserModel().obs;
//User auth logic is located here
  @override
  void onReady() {
    super.onReady();
    firebaseUser = Rx<User>(auth.currentUser); //ininate firebase user
    firebaseUser.bindStream(auth.userChanges());// when User signs out, it sets it back to null
    ever(firebaseUser, _setInitialScreen);// when firebase user changes sets intial screen
  }

  _setInitialScreen(User user) {
    if (user == null) {// if firbebase user  is == null, send user to auth screen
      Get.offAll(() => AuthenticationScreen());// prevents the user from going back to previous screen
    } else {
      userModel.bindStream(listenToUser());
      Get.offAll(() => HomeScreen());
    }
  }

  void signIn() async {
    try {
      showLoading();
      await auth
          .signInWithEmailAndPassword(
          email: email.text.trim(), password: password.text.trim())
          .then((result) {
        _clearControllers();
      });
    } catch (e) {
      debugPrint(e.toString());
      Get.snackbar("Sign In Failed ", "Retry");
    }
  }

  void signUp() async {
    showLoading();
    try {
      await auth
          .createUserWithEmailAndPassword(
          email: email.text.trim(), password: password.text.trim())
          .then((result) {
        String _userId = result.user.uid;
        _addUserToFirestore(_userId);
        _clearControllers();
      });
    } catch (e) {
      debugPrint(e.toString());
      Get.snackbar("Sign Up Failed", "Try again");
    }
  }
  void signOut() async {
    auth.signOut();
  }

  _addUserToFirestore(String userId) {
    firebaseFirestore.collection(usersCollection).doc(userId).set(//
        {"name": name.text.trim(), "id": userId, "email": email.text.trim(),
          "cart" :[] });//making the cart empty for every user
    //create  the user inside firsetore
  }


  _clearControllers(){
    name.clear(); email.clear(); password.clear(); // clears the controller once logged out
  }
  updateUserData(Map<String, dynamic> data) {
    logger.i("UPDATED");
    firebaseFirestore
        .collection(usersCollection)
        .doc(firebaseUser.value.uid)
        .update(data);
  }

  Stream<UserModel> listenToUser() => firebaseFirestore
      .collection(usersCollection)
      .doc(firebaseUser.value.uid)
      .snapshots()
      .map((snapshot) => UserModel.fromSnapshot(snapshot));



}
