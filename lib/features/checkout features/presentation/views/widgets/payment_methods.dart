import 'package:flutter/material.dart';

import 'package:payments/core/utils/assets.dart';

import 'payment_method_item.dart';

class PaymentMethods extends StatefulWidget {
  const PaymentMethods({super.key, required this.onMethodSelected});
  final ValueChanged<int> onMethodSelected;

  @override
  State<PaymentMethods> createState() => _PaymentMethodsState();
}

class _PaymentMethodsState extends State<PaymentMethods> {
  final List<String> paymentMethods = const [
    Assets.assetsImagesCard,
    Assets.assetsImagesPaybal,
    Assets.assetsImagesWallet,
  ];
  int selectedIndex = 0;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 62,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: paymentMethods.length,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () {
              selectedIndex = index;
              widget.onMethodSelected(index);
              setState(() {});
            },
            child: PaymentMethodItem(
              image: paymentMethods[index],
              isActive: selectedIndex == index,
            ),
          );
        },
      ),
    );
  }
}
