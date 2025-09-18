import 'package:flutter/material.dart';
import 'package:payments/core/utils/assets.dart';
import 'package:payments/features/checkout%20features/data/repos/checkout_repo_impl.dart';
import 'package:payments/features/checkout%20features/domain/repos/checkout_repo.dart';
import 'package:payments/features/checkout%20features/presentation/manager/payment_cubit/payment_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/widgets/custom_button.dart';
import 'custom_modal_bottom_sheet.dart';
import 'order_info_item.dart';
import 'total_price.dart';

class MyCartViewBody extends StatelessWidget {
  const MyCartViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        children: [
          const SizedBox(height: 18),
          Expanded(child: Image.asset(Assets.assetsImagesBasket)),
          const SizedBox(height: 25),
          const OrderInfoItem(title: 'Order Subtotal', amount: '\$ 42.97'),
          const SizedBox(height: 3),
          const OrderInfoItem(title: 'Discount', amount: '\$ 0'),
          const SizedBox(height: 3),
          const OrderInfoItem(title: 'Shipping', amount: '\$ 8'),
          const Divider(height: 34, thickness: 2, color: Color(0xffC7C7C7)),
          const TotalPrice(title: 'Total', amount: '\$50.97'),
          const SizedBox(height: 15),
          CustomButton(
            title: 'Complete Payment',
            onTap: () {
              showModalBottomSheet(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(25),
                ),
                context: context,
                builder: (context) {
                  return BlocProvider(
                    create: (context) => PaymentCubit(CheckoutRepoImpl()),
                    child: const CustomModalBottomSheet(),
                  );
                },
              );
            },
          ),
          const SizedBox(height: 12),
        ],
      ),
    );
  }
}
