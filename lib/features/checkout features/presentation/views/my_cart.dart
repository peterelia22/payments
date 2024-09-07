import 'package:flutter/material.dart';
import 'package:payment/core/utils/styles.dart';
import 'package:payment/features/checkout%20features/presentation/views/widgets/my_cart_view_body.dart';

import '../../../../core/widgets/cusotm_app_bar.dart';

class MyCartView extends StatelessWidget {
  const MyCartView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: BuildAppBar(title: 'My Cart'),
      body: const MyCartViewBody(),
    );
  }
}
