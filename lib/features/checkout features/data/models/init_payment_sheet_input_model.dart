class InitPaymentSheetInputModel {
  final String customerID;
  final String paymentIntentClientSecret;
  final String ephemeralKeySecret;
  InitPaymentSheetInputModel({
    required this.customerID,
    required this.paymentIntentClientSecret,
    required this.ephemeralKeySecret,
  });
}
