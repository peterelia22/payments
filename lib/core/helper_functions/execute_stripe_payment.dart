import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../features/checkout features/data/models/payment_intent_input_model.dart';
import '../../features/checkout features/presentation/manager/payment_cubit/payment_cubit.dart';

void executeStripePayment(BuildContext context) {
  final paymentIntentInputModel = PaymentIntentInputModel(
    amount: '1000',
    currency: 'USD',
    customerID: 'cus_T5GycdzzEYSD4q',
  );
  BlocProvider.of<PaymentCubit>(
    context,
  ).makePayment(paymentIntentInputModel: paymentIntentInputModel);
}
