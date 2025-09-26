import 'package:flutter/material.dart';
import 'package:flutter_paypal_payment/flutter_paypal_payment.dart';

import '../../features/checkout features/data/models/amount/amount.dart';
import '../../features/checkout features/data/models/amount/details.dart';
import '../../features/checkout features/data/models/item_list/item.dart';
import '../../features/checkout features/data/models/item_list/item_list.dart';
import '../../features/checkout features/presentation/views/thank_you.dart';
import '../utils/api_keys.dart';

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
          SnackBar snackBar = SnackBar(content: Text(error.toString()));
          ScaffoldMessenger.of(context).showSnackBar(snackBar);
          Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(
              builder: (context) {
                return ThankYou();
              },
            ),
            (route) {
              return false;
            },
          );
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
