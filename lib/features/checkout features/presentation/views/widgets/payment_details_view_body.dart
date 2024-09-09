import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:payment/core/utils/assets.dart';
import 'package:payment/core/widgets/custom_button.dart';
import 'package:payment/features/checkout%20features/presentation/views/thank_you.dart';
import 'package:payment/features/checkout%20features/presentation/views/widgets/custom_credit_card.dart';
import 'package:payment/features/checkout%20features/presentation/views/widgets/payment_methods.dart';

import 'payment_method_item.dart';

class PaymentDetailsViewBody extends StatefulWidget {
  const PaymentDetailsViewBody({super.key});

  @override
  State<PaymentDetailsViewBody> createState() => _PaymentDetailsViewBodyState();
}

class _PaymentDetailsViewBodyState extends State<PaymentDetailsViewBody> {
  GlobalKey<FormState> formKey = GlobalKey();
  AutovalidateMode autovalidateMode = AutovalidateMode.disabled;
  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        const SliverToBoxAdapter(
          child: PaymentMethods(),
        ),
        SliverToBoxAdapter(
          child: CustomCreditCard(
            autovalidateMode: autovalidateMode,
            formKey: formKey,
          ),
        ),
        SliverFillRemaining(
          hasScrollBody: false,
          child: Align(
              alignment: Alignment.bottomCenter,
              child: Padding(
                padding: EdgeInsets.only(bottom: 16, left: 16, right: 16),
                child: CustomButton(
                    onTap: () {
                      if (formKey.currentState!.validate()) {
                        formKey.currentState!.save();
                      } else {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) {
                          return const ThankYou();
                        }));
                        autovalidateMode = AutovalidateMode.always;

                        setState(() {});
                      }
                    },
                    title: 'Pay'),
              )),
        )
      ],
    );
  }
}
