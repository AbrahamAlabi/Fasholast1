//relates to user cart
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:fasholast1/constants/pp_constant.dart';
import 'package:fasholast1/constants/controllers.dart';
import 'package:uuid/uuid.dart';
import 'package:fasholast1/models/user.dart';
import 'package:fasholast1/models/cart_item.dart';
import 'package:fasholast1/models/product.dart';

class CartController extends GetxController {
  static CartController instance = Get.find(); // get the registar conroller
  RxDouble totalCartPrice = 0.0.obs;

  @override
  void onReady() {
    super.onReady();
    ever(authController.userModel,
        // every time theres a change. it will call CCTP method
        changeCartTotalPrice);
  }

  void addProductToCart(ProductModel product) {
    try {
      if (_isItemAlreadyAdded(product)) {
        Get.snackbar("Check your cart", "${product.name} is already added");
      } else {
        String itemId = Uuid().toString();
        authController.updateUserData({
          "cart": FieldValue.arrayUnion([ //union operation, your adding values into the cart
            { //adding map
              "id": itemId,
              "productId": product.id,
              "name": product.name,
              "quantity": 1,
              "price": product.price,
              "image": product.image,
              "cost": product.price
            }
          ])
        });
        Get.snackbar("Item added", "${product.name} was added to your cart");
      }
    } catch (e) {
      Get.snackbar("Error", "Item cannot be added ");
      debugPrint(e.toString());// for me to see whats happing
    }
  }

  void removeCitem(CartItem cartItem) {
    try {
      authController.updateUserData({
        "cart": FieldValue.arrayRemove([cartItem.toJson()])//helps remove maps
        //converts item into map
      });
    } catch (e) {
      Get.snackbar("Error", "Cannot remove this item");
      debugPrint(e.message);
    }
  }

  changeCartTotalPrice(UserModel userModel) {
    totalCartPrice.value = 0.0;//property of userModel
    if (userModel.cart.isNotEmpty) {
      userModel.cart.forEach((cartItem) {
        totalCartPrice += cartItem.cost;
      });
    }
  }

  bool _isItemAlreadyAdded(ProductModel product) => //returns a boolen
  authController.userModel.value.cart
      .where((item) =>
  item.productId == product.id) //checking item if any item is matching
      .isNotEmpty;


  void decreaseQuantity(CartItem item) {
    if (item.quantity == 1) {
      removeCitem(item);
    } else {
      removeCitem(item);
      item.quantity--;
      authController.updateUserData({
        "cart": FieldValue.arrayUnion([item.toJson()])
      });
    }
  }
  void increaseQuantity(CartItem item){
    removeCitem(item);
    item.quantity++;
    logger.i({"quantity": item.quantity});// logger prints the quantity in the console
    authController.updateUserData({
      "cart": FieldValue.arrayUnion([item.toJson()])
    });
  }
}