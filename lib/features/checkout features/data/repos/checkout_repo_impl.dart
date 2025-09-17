import 'package:dartz/dartz.dart';
import 'package:payments/core/errors/failure.dart';
import 'package:payments/core/services/stripe_service.dart';
import 'package:payments/features/checkout%20features/data/models/payment_intent_input_model.dart';
import 'package:payments/features/checkout%20features/domain/repos/checkout_repo.dart';

class CheckoutRepoImpl implements CheckoutRepo {
  final StripeService stripeService = StripeService();
  @override
  Future<Either<Failure, void>> makePayment({
    required PaymentIntentInputModel paymentIntentInputModel,
  }) async {
    try {
      await stripeService.makePayment(
        paymentIntentInputModel: paymentIntentInputModel,
      );
      return right(null);
    } catch (e) {
      return left(ServerFailure(errorMessage: e.toString()));
    }
  }
}
