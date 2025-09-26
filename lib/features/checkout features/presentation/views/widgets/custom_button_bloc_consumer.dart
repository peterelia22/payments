import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pay_with_paymob/pay_with_paymob.dart';
import 'package:payments/core/helper_functions/execute_paypal_payment.dart';
import 'package:payments/core/widgets/custom_button.dart';

import 'package:payments/features/checkout%20features/presentation/views/thank_you.dart';

import '../../../../../core/helper_functions/execute_paymob_payment.dart';
import '../../../../../core/helper_functions/execute_stripe_payment.dart';
import '../../manager/payment_cubit/payment_cubit.dart';

class CustomButtonBlocConsumer extends StatelessWidget {
  const CustomButtonBlocConsumer({super.key, required this.selectedMethod});
  final int selectedMethod;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<PaymentCubit, PaymentState>(
      listener: (context, state) {
        if (state is PaymentSuccess) {
          Navigator.of(context).pushReplacement(
            MaterialPageRoute(
              builder: (context) {
                return ThankYou();
              },
            ),
          );
        }
        if (state is PaymentFailure) {
          log(state.errorMessage);
          SnackBar snackBar = SnackBar(content: Text(state.errorMessage));
          ScaffoldMessenger.of(context).showSnackBar(snackBar);
        }
      },
      builder: (context, state) {
        return CustomButton(
          onTap: () {
            if (selectedMethod == 0) {
              // Stripe (Card)
              executeStripePayment(context);
            } else if (selectedMethod == 1) {
              var transactions = getTransactions();
              // PayPal
              executePaypalPayment(context, transactions);
            } else if (selectedMethod == 2) {
              // Wallet
              executePaymobPayment(context);
            }
          },
          isLoading: state is PaymentLoading,
          title: 'Continue',
        );
      },
    );
  }
}
