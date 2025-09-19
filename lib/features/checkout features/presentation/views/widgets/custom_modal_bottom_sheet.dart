import 'package:flutter/material.dart';

import 'custom_button_bloc_consumer.dart';
import 'payment_methods.dart';

class CustomModalBottomSheet extends StatefulWidget {
  const CustomModalBottomSheet({super.key});

  @override
  State<CustomModalBottomSheet> createState() => _CustomModalBottomSheetState();
}

class _CustomModalBottomSheetState extends State<CustomModalBottomSheet> {
  int selectedMethod = 0;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(16),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(height: 16),
          PaymentMethods(
            onMethodSelected: (index) {
              setState(() {
                selectedMethod = index;
              });
            },
          ),
          SizedBox(height: 32),
          CustomButtonBlocConsumer(selectedMethod: selectedMethod),
        ],
      ),
    );
  }
}
