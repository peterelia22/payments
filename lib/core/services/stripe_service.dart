import 'package:payments/core/services/api_service.dart';
import 'package:payments/core/utils/api_keys.dart';
import 'package:payments/features/checkout%20features/data/models/payment_intent_input_model.dart';
import 'package:payments/features/checkout%20features/data/models/payment_intent_model/payment_intent_model.dart';

class StripeService {
  final ApiService apiService = ApiService();
  Future<PaymentIntentModel> createPaymentIntent(
    PaymentIntentInputModel paymentIntentInputModel,
  ) async {
    final response = await apiService.post(
      body: paymentIntentInputModel.toJson(),
      url: 'https://api.stripe.com/v1/payment_intents',
      token: ApiKeys.stripeSecretKey,
    );
    return PaymentIntentModel.fromJson(response.data);
  }
}
