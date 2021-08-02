import 'package:fasholast1/constants/controllers.dart';
import 'package:fasholast1/controllers/products_coontroller.dart';
import 'package:flutter/material.dart';
import 'package:fasholast1/models/product.dart';
import 'package:fasholast1/screens/home/widgets/single_product.dart';
import 'package:get/get.dart';

class ProductsWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GridView.count(
        crossAxisCount: 2,
        childAspectRatio: .63,
        padding: const EdgeInsets.all(10),
        mainAxisSpacing: 4.0,
        crossAxisSpacing: 10,
        children: prodController.products.map((ProductModel product) {
          return SingleProductWidget(
            product: product,
          );
        }).toList());
  }
}