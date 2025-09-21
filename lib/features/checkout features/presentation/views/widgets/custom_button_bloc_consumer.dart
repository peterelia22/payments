import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_paypal_payment/flutter_paypal_payment.dart';
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
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (BuildContext context) => PaypalCheckoutView(
                    sandboxMode: true,
                    clientId: "",
                    secretKey: "",
                    transactions: const [
                      {
                        "amount": {
                          "total": "55",
                          "currency": "USD",
                          "details": {
                            "subtotal": "40",
                            "shipping": "20",
                            "shipping_discount": 0,
                          },
                        },
                        "description": "The payment transaction description.",
                        // "payment_options": {
                        //   "allowed_payment_method":
                        //       "INSTANT_FUNDING_SOURCE"
                        // },
                        "item_list": {
                          "items": [
                            {
                              "name": "Apple",
                              "quantity": 4,
                              "price": '5',
                              "currency": "USD",
                            },
                            {
                              "name": "Pineapple",
                              "quantity": 5,
                              "price": '10',
                              "currency": "USD",
                            },
                          ],

                          // shipping address is not required though
                          //   "shipping_address": {
                          //     "recipient_name": "tharwat",
                          //     "line1": "Alexandria",
                          //     "line2": "",
                          //     "city": "Alexandria",
                          //     "country_code": "EG",
                          //     "postal_code": "21505",
                          //     "phone": "+00000000",
                          //     "state": "Alexandria"
                          //  },
                        },
                      },
                    ],
                    note: "Contact us for any questions on your order.",
                    onSuccess: (Map params) async {
                      print("onSuccess: $params");
                    },
                    onError: (error) {
                      print("onError: $error");
                      Navigator.pop(context);
                    },
                    onCancel: () {
                      print('cancelled:');
                    },
                  ),
                ),
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
