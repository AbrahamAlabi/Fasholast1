import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fasholast1/constants/pp_constant.dart';
import 'package:fasholast1/models/cart_item.dart';
//instantiate the user model
class UserModel {
  static const ID = "id";
  static const NAME = "name";
  static const EMAIL = "email";
  static const CART = "cart";

   String id;
   String name;
   String email;
   List<CartItem> cart;

  UserModel({this.id, this.name, this.email, this.cart});

  UserModel.fromSnapshot(DocumentSnapshot snapshot) {
    name = snapshot.data()[NAME];
    email = snapshot.data()[EMAIL];
    id = snapshot.data()[ID];
    cart =_convertCartItems(snapshot.data()[CART]??[]);//cart will convert items.
    //List of Maps is converted into cartitem models
    // if cart is empty. cart is assigned to an empty list
  }
  List<CartItem> _convertCartItems(List cartFomDb) {// convert list from firebase to a list of cartItem model
    List<CartItem> _result = [];
    if (cartFomDb.length > 0) {
      cartFomDb.forEach((element) {// for each cartItem, it changes it to cartmodel

        _result.add(CartItem.fromMap(element));
      });
    }
    return _result;
  }
    List cartItemsToJson() =>cart.map((item) => item.toJson()).toList();// convert user propteries into json format
}
