class PaymentIntentInputModel {
  final String amount;
  final String currency;
  final String customerID;
  PaymentIntentInputModel({
    required this.amount,
    required this.currency,
    required this.customerID,
  });
  toJson() {
    return {'amount': amount, 'currency': currency, 'customer': customerID};
  }
}
