import 'package:fasholast1/constants/controllers.dart';
import 'package:flutter/material.dart';
import 'package:fasholast1/constants/asset_paths.dart';
import 'package:fasholast1/models/cart_item.dart';
import 'package:fasholast1/screens/home/widgets/cart_item_widget.dart';
import 'package:fasholast1/widgets/custom_btn.dart';
import 'package:fasholast1/widgets/custom_text.dart';
import 'package:get/get.dart';

class ShoppingCart extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        ListView(
          children: [
            SizedBox(
              height: 10,
            ),
            Center(
              child: CustomText(
                text: "Cart",
                size: 24,
                weight: FontWeight.bold,
              ),
            ),
            SizedBox(
              height: 5,
            ),
            Column(
              children: authController.userModel.value.cart// convert every element into item Widget
              .map((cartItemModel) => CartItemWidget (cartItem: cartItemModel,))
              .toList(),// which will return a list
          ),
        ],
        ),

        Positioned(
            bottom: 30,
            child: Container(
              width: MediaQuery.of(context).size.width,
              padding: EdgeInsets.all(8),
              child: Obx(()=> CustomButton(
                  text: "Pay (\$${cartController.totalCartPrice.value.toStringAsFixed(2)})",// since its boolean, its stopped at 2 to prevent results like"2.99999999" lol
                  onTap: () {
                paymentsController.createPaymentMethod();
              }),
            )),)
      ],
    );
  }
}
