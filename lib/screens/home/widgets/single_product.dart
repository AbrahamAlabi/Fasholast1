import 'package:fasholast1/constants/controllers.dart';
import 'package:flutter/material.dart';
import 'package:fasholast1/models/product.dart';
import 'package:fasholast1/widgets/custom_text.dart';

class SingleProductWidget extends StatelessWidget {
  final ProductModel product;

  const SingleProductWidget({Key key, this.product}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: Colors.blueGrey,
          borderRadius: BorderRadius.circular(15),
          boxShadow: [
            BoxShadow(
                color: Colors.grey.withOpacity(.5),
                offset: Offset(3, 2),
                blurRadius: 7)
          ]),
      child: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ClipRRect(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(15),
                    topRight: Radius.circular(15),
                  ),
                  child: Image.network(
                    product.image,
                    width: double.infinity,
                  )),
            ),
            CustomText(
              text:product.name ==null?'cloths': product.name,
              size: 18,
              weight: FontWeight.bold,
            ),


            SizedBox(
              height: 5,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 8.0),
                  child: CustomText(
                    text: "\$${product.price}",
                    size: 22,
                    weight: FontWeight.bold,
                  ),
                ),
                SizedBox(
                  width: 30,
                ),
                IconButton(
                    icon: Icon(Icons.add_shopping_cart),
                    onPressed: () {
                      cartController.addProductToCart(product);
                    })
              ],
            ),
          ],
        ),
      ),
    );
  }
}
