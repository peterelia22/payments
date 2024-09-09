import 'package:flutter/material.dart';
import 'package:payment/core/utils/assets.dart';
import 'package:payment/features/checkout%20features/presentation/views/payment_details.dart';

import 'package:payment/features/checkout%20features/presentation/views/widgets/order_info_item.dart';
import 'package:payment/features/checkout%20features/presentation/views/widgets/total_price.dart';

import '../../../../../core/widgets/custom_button.dart';

class MyCartViewBody extends StatelessWidget {
  const MyCartViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        children: [
          const SizedBox(
            height: 18,
          ),
          Expanded(child: Image.asset(Assets.assetsImagesBasket)),
          const SizedBox(
            height: 25,
          ),
          const OrderInfoItem(title: 'Order Subtotal', amount: '\$ 42.97'),
          const SizedBox(
            height: 3,
          ),
          const OrderInfoItem(title: 'Discount', amount: '\$ 0'),
          const SizedBox(
            height: 3,
          ),
          const OrderInfoItem(title: 'Shipping', amount: '\$ 8'),
          const Divider(
            height: 34,
            thickness: 2,
            color: Color(0xffC7C7C7),
          ),
          const TotalPrice(title: 'Total', amount: '\$50.97'),
          const SizedBox(
            height: 15,
          ),
          CustomButton(
            title: 'Complete Payment',
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) {
                return const PaymentDetailsView();
              }));
            },
          ),
          const SizedBox(
            height: 12,
          )
        ],
      ),
    );
  }
}
