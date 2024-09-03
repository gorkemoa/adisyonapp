// basket_detail_model.dart
import 'package:adisyon_app/models/product_model.dart';

class BasketDetail {
  final int id;
  final int basketID;
  final int productID;
  final Product product;
  final int quantity;
  final int payedQuantity;
  final double price;
  final double priceOfSell;
  final DateTime createdDate;

  BasketDetail({
    required this.id,
    required this.basketID,
    required this.productID,
    required this.product,
    required this.quantity,
    required this.payedQuantity,
    required this.price,
    required this.priceOfSell,
    required this.createdDate,
  });

  factory BasketDetail.fromJson(Map<String, dynamic> json) {
    return BasketDetail(
      id: json['id'] ?? 0,
      basketID: json['basketID'] ?? 0,
      productID: json['productID'] ?? 0,
      product: Product.fromJson(json['product'] ?? {}),
      quantity: json['quantity'] ?? 0,
      payedQuantity: json['payedQuantity'] ?? 0,
      price: json['price']?.toDouble() ?? 0.0,
      priceOfSell: json['priceOfSell']?.toDouble() ?? 0.0,
      createdDate: DateTime.parse(json['createdDate'] ?? DateTime.now().toIso8601String()),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'basketID': basketID,
      'productID': productID,
      'product': product.toJson(),
      'quantity': quantity,
      'payedQuantity': payedQuantity,
      'price': price,
      'priceOfSell': priceOfSell,
      'createdDate': createdDate.toIso8601String(),
    };
  }
}
