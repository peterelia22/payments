import 'package:dio/dio.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:payments/core/services/api_service.dart';
import 'package:payments/core/utils/api_keys.dart';
import 'package:payments/features/checkout%20features/data/models/ephemeral_key_model/ephemeral_key_model.dart';
import 'package:payments/features/checkout%20features/data/models/init_payment_sheet_input_model.dart';
import 'package:payments/features/checkout%20features/data/models/payment_intent_input_model.dart';
import 'package:payments/features/checkout%20features/data/models/payment_intent_model/payment_intent_model.dart';

class StripeService {
  final ApiService apiService = ApiService();
  Future<PaymentIntentModel> createPaymentIntent(
    PaymentIntentInputModel paymentIntentInputModel,
  ) async {
    final response = await apiService.post(
      contentType: Headers.formUrlEncodedContentType,
      body: paymentIntentInputModel.toJson(),
      url: 'https://api.stripe.com/v1/payment_intents',
      token: ApiKeys.stripeSecretKey,
    );
    return PaymentIntentModel.fromJson(response.data);
  }

  Future<EphemeralKeyModel> createEphemeralKey({
    required String customerID,
  }) async {
    final response = await apiService.post(
      headers: {
        'Authorization': "Bearer ${ApiKeys.stripeSecretKey}",
        'Stripe-Version': '2024-04-10',
      },
      contentType: Headers.formUrlEncodedContentType,
      body: {'customer': customerID},
      url: 'https://api.stripe.com/v1/ephemeral_keys',
      token: ApiKeys.stripeSecretKey,
    );
    return EphemeralKeyModel.fromJson(response.data);
  }

  Future initPaymentsheet({
    required InitPaymentSheetInputModel initPaymentSheetInputModel,
  }) async {
    await Stripe.instance.initPaymentSheet(
      paymentSheetParameters: SetupPaymentSheetParameters(
        customerId: initPaymentSheetInputModel.customerID,
        customerEphemeralKeySecret:
            initPaymentSheetInputModel.ephemeralKeySecret,
        paymentIntentClientSecret:
            initPaymentSheetInputModel.paymentIntentClientSecret,
        merchantDisplayName: 'Pedro',
      ),
    );
  }

  Future presentPaymentSheet() async {
    await Stripe.instance.presentPaymentSheet();
  }

  Future makePayment({
    required PaymentIntentInputModel paymentIntentInputModel,
  }) async {
    final paymentIntentModel = await createPaymentIntent(
      paymentIntentInputModel,
    );
    final ephemeralKeyModel = await createEphemeralKey(
      customerID: paymentIntentInputModel.customerID,
    );
    var initPaymentSheetInputModel = InitPaymentSheetInputModel(
      customerID: paymentIntentInputModel.customerID,
      paymentIntentClientSecret: paymentIntentModel.clientSecret!,
      ephemeralKeySecret: ephemeralKeyModel.secret!,
    );
    await initPaymentsheet(
      initPaymentSheetInputModel: initPaymentSheetInputModel,
    );
    await presentPaymentSheet();
  }
}
