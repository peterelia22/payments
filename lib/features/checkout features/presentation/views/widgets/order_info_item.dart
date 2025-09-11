import 'package:flutter/material.dart';
import 'package:payments/core/utils/styles.dart';

class OrderInfoItem extends StatelessWidget {
  final String title, amount;

  const OrderInfoItem({super.key, required this.title, required this.amount});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(title, style: AppStyles.style18),
        Text(amount, style: AppStyles.style18),
      ],
    );
  }
}
