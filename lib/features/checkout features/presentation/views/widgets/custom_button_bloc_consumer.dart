import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:payments/core/widgets/custom_button.dart';
import 'package:payments/features/checkout%20features/presentation/views/thank_you.dart';

import '../../../data/models/payment_intent_input_model.dart';
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
              final paymentIntentInputModel = PaymentIntentInputModel(
                amount: '1000',
                currency: 'USD',
                customerID: 'cus_T5GycdzzEYSD4q',
              );
              BlocProvider.of<PaymentCubit>(
                context,
              ).makePayment(paymentIntentInputModel: paymentIntentInputModel);
            } else if (selectedMethod == 1) {
              // PayPal
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('PayPal not implemented yet')),
              );
            } else if (selectedMethod == 2) {
              // Apple Pay
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Apple Pay not implemented yet')),
              );
            }
          },
          isLoading: state is PaymentLoading,
          title: 'Continue',
        );
      },
    );
  }
}
