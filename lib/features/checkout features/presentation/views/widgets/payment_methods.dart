import 'package:flutter/material.dart';
import 'package:payment/core/utils/assets.dart';
import 'package:payment/features/checkout%20features/presentation/views/widgets/payment_method_item.dart';

class PaymentMethods extends StatefulWidget {
  const PaymentMethods({super.key});

  @override
  State<PaymentMethods> createState() => _PaymentMethodsState();
}

class _PaymentMethodsState extends State<PaymentMethods> {
  final List<String> paymentMethods = const [
    Assets.assetsImagesCard,
    Assets.assetsImagesPaybal,
    Assets.assetsImagesApple
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
                  setState(() {});
                },
                child: PaymentMethodItem(
                  image: paymentMethods[index],
                  isActive: selectedIndex == index,
                ));
          }),
    );
  }
}
