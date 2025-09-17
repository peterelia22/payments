import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:flutter/foundation.dart';
import 'package:payments/features/checkout%20features/domain/repos/checkout_repo.dart';

import '../../../data/models/payment_intent_input_model.dart';

part 'payment_state.dart';

class PaymentCubit extends Cubit<PaymentState> {
  PaymentCubit(this.checkoutRepo) : super(PaymentInitial());
  final CheckoutRepo checkoutRepo;
  Future makePayment({
    required PaymentIntentInputModel paymentIntentInputModel,
  }) async {
    emit(PaymentLoading());
    var data = await checkoutRepo.makePayment(
      paymentIntentInputModel: paymentIntentInputModel,
    );
    data.fold(
      (l) => emit(PaymentFailure(errorMessage: l.errorMessage)),
      (r) => emit(PaymentSuccess()),
    );
  }

  @override
  void onChange(Change<PaymentState> change) {
    log(change.toString());
    super.onChange(change);
  }
}
