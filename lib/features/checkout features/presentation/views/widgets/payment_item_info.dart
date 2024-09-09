import 'package:flutter/material.dart';
import 'package:payment/core/utils/styles.dart';

class PaymentItemInfo extends StatelessWidget {
  final String title;
  final String subtitle;
  const PaymentItemInfo(
      {super.key, required this.title, required this.subtitle});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          textAlign: TextAlign.center,
          style: AppStyles.style18,
        ),
        Text(
          subtitle,
          style: AppStyles.styleSemiBold18,
        )
      ],
    );
  }
}
