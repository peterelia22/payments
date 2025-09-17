import 'package:dartz/dartz.dart';
import 'package:payments/core/errors/failure.dart';

import '../../data/models/payment_intent_input_model.dart';

abstract class CheckoutRepo {
  Future<Either<Failure, void>> makePayment({
    required PaymentIntentInputModel paymentIntentInputModel,
  });
}
