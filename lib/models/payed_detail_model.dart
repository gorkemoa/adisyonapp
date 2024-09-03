class PayedDetail {
  final int id;
  final int branchID;
  final int userID;
  final int basketID;
  final String basket;
  final double payedAmount;
  final int bankID;
  final String basketDetailIDs;
  final DateTime createdDate;

  PayedDetail({
    required this.id,
    required this.branchID,
    required this.userID,
    required this.basketID,
    required this.basket,
    required this.payedAmount,
    required this.bankID,
    required this.basketDetailIDs,
    required this.createdDate,
  });

  factory PayedDetail.fromJson(Map<String, dynamic> json) {
    return PayedDetail(
      id: json['id'],
      branchID: json['branchID'],
      userID: json['userID'],
      basketID: json['basketID'],
      basket: json['basket'],
      payedAmount: json['payedAmount'].toDouble(),
      bankID: json['bankID'],
      basketDetailIDs: json['basketDetailIDs'],
      createdDate: DateTime.parse(json['createdDate']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'branchID': branchID,
      'userID': userID,
      'basketID': basketID,
      'basket': basket,
      'payedAmount': payedAmount,
      'bankID': bankID,
      'basketDetailIDs': basketDetailIDs,
      'createdDate': createdDate.toIso8601String(),
    };
  }
}
