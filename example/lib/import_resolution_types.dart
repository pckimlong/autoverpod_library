extension type OrgId._(String value) {
  factory OrgId.fromValue(String value) => OrgId._(value);
  String toJson() => value;
  String call() => value;
}

extension type CustomerId._(String value) {
  factory CustomerId.fromValue(String value) => CustomerId._(value);
  String toJson() => value;
  String call() => value;
}

enum PaymentChannel { cash, card, bankTransfer }
