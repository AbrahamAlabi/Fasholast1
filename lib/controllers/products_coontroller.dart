import 'package:fasholast1/constants/firebase.dart';
import 'package:fasholast1/models/product.dart';
import 'package:get/get.dart';
import 'dart:async';

class ProdController extends GetxController {
  // creating the controller
  static ProdController instance = Get.find(); // return the controller
  RxList<ProductModel> products =
      RxList<ProductModel>([]); // defines the list of products
  String collection = "products"; // name of collection

  @override
  void onReady() {
    // TODO: implement onReady
    super.onReady();
    products.bindStream(getAllProducts()); // binds the product to the stream //name of stream is GetAllP
  }

  Stream<List<ProductModel>>// return a stream of product model
      getAllProducts() => // created the stream that returns the product models
          firebaseFirestore
              .collection(collection)//specify the collection i want to access
              .snapshots() // access the snapshot inside collection
              .map((query) => // maps everything inside the snapshot
                  query.docs
                      .map((item) => ProductModel.fromMap(item.data())) // acess the document of the quires snapshot// maps all the documents +
                      .toList());
  // the method will allow  to listen to the product in the database & auto update if any changes in the datbase
}
