import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:pay_with_paymob/pay_with_paymob.dart';
import 'package:payments/core/utils/api_keys.dart';

import '../../features/checkout features/presentation/views/thank_you.dart';

initalizePaymobPayment() async {
  PaymentData.initialize(
    apiKey: ApiKeys.paymobApiKey,
    iframeId: "956706",
    integrationCardId: "5266565",
    integrationMobileWalletId: "5266567",

    style: Style(
      primaryColor: Colors.red, // Default: Colors.blue
      scaffoldColor: Colors.white, // Default: Colors.white
      appBarBackgroundColor: Colors.blue, // Default: Colors.blue
      appBarForegroundColor: Colors.white, // Default: Colors.white
      textStyle: TextStyle(), // Default: TextStyle()
      buttonStyle:
          ElevatedButton.styleFrom(), // Default: ElevatedButton.styleFrom()
      circleProgressColor: Colors.blue, // Default: Colors.blue
      unselectedColor: Colors.grey, // Default: Colors.grey
    ),
  );
}

void executePaymobPayment(BuildContext context) {
  Navigator.push(
    context,
    MaterialPageRoute(
      builder: (context) => PaymentView(
        onPaymentSuccess: () {
          log('Payment Success');
          Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(
              builder: (context) {
                return ThankYou();
              },
            ),
            (route) {
              if (route.settings.name == '/') {
                return true;
              } else {
                return false;
              }
            },
          );
        },
        onPaymentError: () {
          // Handle payment failure
        },
        price: 100, // Required: Total price (e.g., 100 for 100 EGP)
      ),
    ),
  );
}
