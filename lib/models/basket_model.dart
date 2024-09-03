// basket_model.dart
import 'basket_detail_model.dart';
import 'desk_model.dart';
import 'payed_detail_model.dart';

class Basket {
  final int id;
  final String name;
  final DateTime createdDate;
  final int branchID;
  final int userID;
  final int cashierID;
  final int openStatusID;
  final String description;
  final String fatirsNo;
  final int deskID;
  final Desk desk;
  final List<BasketDetail> basketDetails;
  final List<PayedDetail> payedDetails;
  final int totalQuantity;
  final double totalAmount;
  final double payedCash;
  final double payedCredit;
  final double payedAll;

  Basket({
    required this.id,
    required this.name,
    required this.createdDate,
    required this.branchID,
    required this.userID,
    required this.cashierID,
    required this.openStatusID,
    required this.description,
    required this.fatirsNo,
    required this.deskID,
    required this.desk,
    required this.basketDetails,
    required this.payedDetails,
    required this.totalQuantity,
    required this.totalAmount,
    required this.payedCash,
    required this.payedCredit,
    required this.payedAll,
  });

  factory Basket.fromJson(Map<String, dynamic> json) {
    return Basket(
      id: json['id'] ?? 0,
      name: json['name'] ?? '',
      createdDate: DateTime.parse(json['createdDate'] ?? DateTime.now().toIso8601String()),
      branchID: json['branchID'] ?? 0,
      userID: json['userID'] ?? 0,
      cashierID: json['cashierID'] ?? 0,
      openStatusID: json['openStatusID'] ?? 0,
      description: json['description'] ?? '',
      fatirsNo: json['fatirsNo'] ?? '',
      deskID: json['deskID'] ?? 0,
      desk: Desk.fromJson(json['desk'] ?? {}),
      basketDetails: (json['basketDetails'] as List? ?? []).map((item) => BasketDetail.fromJson(item)).toList(),
      payedDetails: (json['payedDetails'] as List? ?? []).map((item) => PayedDetail.fromJson(item)).toList(),
      totalQuantity: json['totalQuantity'] ?? 0,
      totalAmount: json['totalAmount']?.toDouble() ?? 0.0,
      payedCash: json['payedCash']?.toDouble() ?? 0.0,
      payedCredit: json['payedCredit']?.toDouble() ?? 0.0,
      payedAll: json['payedAll']?.toDouble() ?? 0.0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'createdDate': createdDate.toIso8601String(),
      'branchID': branchID,
      'userID': userID,
      'cashierID': cashierID,
      'openStatusID': openStatusID,
      'description': description,
      'fatirsNo': fatirsNo,
      'deskID': deskID,
      'desk': desk.toJson(),
      'basketDetails': basketDetails.map((item) => item.toJson()).toList(),
      'payedDetails': payedDetails.map((item) => item.toJson()).toList(),
      'totalQuantity': totalQuantity,
      'totalAmount': totalAmount,
      'payedCash': payedCash,
      'payedCredit': payedCredit,
      'payedAll': payedAll,
    };
  }
}
