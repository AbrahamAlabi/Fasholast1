import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:stripe_payment/stripe_payment.dart';
import 'package:fasholast1/constants/pp_constant.dart';
import 'package:fasholast1/constants/controllers.dart';
import 'package:fasholast1/constants/firebase.dart';
import 'package:fasholast1/models/payments.dart';
import 'package:fasholast1/screens/payments/paymentss.dart';
import 'package:fasholast1/utils/loading/showLoading.dart';
import 'package:fasholast1/widgets/custom_text.dart';
import 'package:dio/dio.dart';
import 'package:uuid/uuid.dart';

class PaymentsController extends GetxController {
  static PaymentsController instance = Get.find();
  String collection = "payments";
  String url =
      'https://us-central1-fashotrial1.cloudfunctions.net/createPaymentIntent'; // url link from Firebase for the payment sripe
  List<PaymentsModel> payments = [];

  @override
  void onReady() {
    super.onReady();
    StripePayment.setOptions(StripeOptions(
        publishableKey:
            "pk_live_51JIXAvFKGBQ9fEJKm2V8frgT4FKDpbakFR4Bhce377appDYagYVU85949eHjEJBIDBOuASrbHjeGiqPrLGQD8Gvt003WF2FFMP"));
  }

  Future<void> createPaymentMethod() async {
    StripePayment.setStripeAccount(null);
    PaymentMethod paymentMethod = PaymentMethod();
    paymentMethod = await StripePayment.paymentRequestWithCardForm(
      CardFormPaymentRequest(),
    ).then((PaymentMethod paymentMethod) {
      return paymentMethod;
    }).catchError((e) {
      print('Error Card: ${e.toString()}');
    });
    paymentMethod != null
        ? processPaymentAsDirectCharge(paymentMethod)
        : _showPaymentFailedAlert();
    dismissLoadingWidget();
  }

  Future<void> processPaymentAsDirectCharge(PaymentMethod paymentMethod) async {
    showLoading();
    int amount =
        (double.parse(cartController.totalCartPrice.value.toStringAsFixed(2)) *
                100)
            .toInt(); // stripes only take integers
    final response = await Dio().post(
        '$url?amount=$amount&currency=EUR&pm_id=${paymentMethod.id}'); //post method/ passes a url takes parameters- the sum & currency
    if (response.data != null && response.data != 'error') {
      final paymentIntentX = response.data;
      final status = paymentIntentX['paymentIntent']['status'];
      if (status == 'charge completed ') {
        StripePayment.completeNativePayRequest();

        _addToCollection(paymentrank: status, paymentId: paymentMethod.id);
        authController.updateUserData(
            {"cart": []}); // clears cart after payment was completed
        Get.snackbar("Success", "Payment succeeded");
      } else {
        _addToCollection(paymentrank: status, paymentId: paymentMethod.id);
      }
    } else {
      // Dont forget python script for camera !!!!
      StripePayment.cancelNativePayRequest();
      _showPaymentFailedAlert();
    }
  }

  void _showPaymentFailedAlert() {
    Get.defaultDialog(
        content: CustomText(
          text: "Payment failed, try another card",
        ),
        actions: [
          GestureDetector(
              onTap: () {
                Get.back();
              },
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: CustomText(
                  text: "Okay",
                ),
              ))
        ]);
  }

  _addToCollection({String paymentrank, String paymentId}) {
    // add payment info into database
    String id = Uuid().v1();
    firebaseFirestore.collection(collection).doc(id).set({
      "id": id,
      "clientId": authController.userModel.value.id,
      "rank": paymentrank,
      "paymentId": paymentId,
      "cart": authController.userModel.value.cartItemsToJson(),
      "sum": cartController.totalCartPrice.value.toStringAsFixed(2),
      "createdAt": DateTime.now().microsecondsSinceEpoch,
    });
  }

  getPaymentHistory() {
    showLoading();
    payments.clear();
    firebaseFirestore
        .collection(collection)
        .where("clientId", isEqualTo: authController.userModel.value.id)
        .get()
        .then((snapshot) {
      snapshot.docs.forEach((doc) {
        // list of all the coduments + run a for loop
        PaymentsModel payment = PaymentsModel.fromMap(doc.data());
        payments.add(payment); // add payment method to payment list
      });

      logger.i("length ${payments.length}");
      dismissLoadingWidget();
      Get.to(() => PaymentsScreen());
    });
  }
}
