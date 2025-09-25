import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_paypal_payment/flutter_paypal_payment.dart';
import 'package:payments/core/utils/api_keys.dart';
import 'package:payments/core/widgets/custom_button.dart';
import 'package:payments/features/checkout%20features/data/models/amount/amount.dart';
import 'package:payments/features/checkout%20features/data/models/amount/details.dart';
import 'package:payments/features/checkout%20features/data/models/item_list/item.dart';
import 'package:payments/features/checkout%20features/data/models/item_list/item_list.dart';
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
              executeStripePayment(context);
            } else if (selectedMethod == 1) {
              var transactions = getTransactions();
              // PayPal
              executePaypalPayment(context, transactions);
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

  void executeStripePayment(BuildContext context) {
    final paymentIntentInputModel = PaymentIntentInputModel(
      amount: '1000',
      currency: 'USD',
      customerID: 'cus_T5GycdzzEYSD4q',
    );
    BlocProvider.of<PaymentCubit>(
      context,
    ).makePayment(paymentIntentInputModel: paymentIntentInputModel);
  }

  void executePaypalPayment(
    BuildContext context,
    ({AmountModel amount, ItemListModel itemList}) transactions,
  ) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (BuildContext context) => PaypalCheckoutView(
          sandboxMode: true,
          clientId: ApiKeys.paypalClientId,
          secretKey: ApiKeys.paypalSecretKey,
          transactions: [
            {
              "amount": transactions.amount.toJson(),
              "description": "The payment transaction description.",

              "item_list": transactions.itemList.toJson(),
            },
          ],
          note: "Contact us for any questions on your order.",
          onSuccess: (Map params) async {
            print("onSuccess: $params");
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
  }

  ({AmountModel amount, ItemListModel itemList}) getTransactions() {
    var amount = AmountModel(
      total: "100",
      currency: 'USD',
      details: Details(shipping: "0", shippingDiscount: 0, subtotal: '100'),
    );
    var itemList = ItemListModel(
      items: [
        ItemModel(currency: 'USD', name: 'Apple', quantity: 10, price: "4"),
        ItemModel(currency: 'USD', name: 'Apple', quantity: 12, price: "5"),
      ],
    );
    return (amount: amount, itemList: itemList);
  }
}
