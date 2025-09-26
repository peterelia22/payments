import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:payments/core/helper_functions/execute_paymob_payment.dart';
import 'package:payments/core/utils/api_keys.dart';

import 'features/checkout features/presentation/views/my_cart.dart';

void main() {
  initalizePaymobPayment();
  Stripe.publishableKey = ApiKeys.stripePublishableKey;
  runApp(const CheckOutApp());
}

class CheckOutApp extends StatelessWidget {
  const CheckOutApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: MyCartView(),
    );
  }
}
