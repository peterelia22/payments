import 'package:flutter/material.dart';
import 'package:payments/core/widgets/custom_button.dart';

import 'payment_methods.dart';

class CustomModalBottomSheet extends StatelessWidget {
  const CustomModalBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.all(16),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(height: 16),
          PaymentMethods(),
          SizedBox(height: 32),
          CustomButton(title: 'Continue'),
        ],
      ),
    );
  }
}
