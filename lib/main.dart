import 'package:flutter/material.dart';
import 'package:payment/features/checkout%20features/presentation/views/my_cart.dart';

void main() {
  runApp(const CheckOutApp());
}

class CheckOutApp extends StatelessWidget {
  const CheckOutApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: MyCartView(),
    );
  }
}
