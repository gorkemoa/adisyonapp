import 'package:adisyon_app/models/branch_model.dart';
import 'package:adisyon_app/models/category_model.dart';

class Product {
  final int id;
  final String name;
  final DateTime createdDate;
  final String qrCode;
  final String stockCode;
  final String imagePath;
  final double priceOfBuy;
  final double priceOfSell;
  final double unitsInStock; // Not: JSON yanıtında double olarak döner
  final bool isPart;
  final bool isActive;
  final int queNo;
  final int productUnitID;
  // final ProductUnit? productUnit; // JSON yanıtında yok
  final int categoryID;
  final Category? category; // Nullable yapıldı
  final int branchID;
  final Branch? branch; // Nullable yapıldı

  Product({
    required this.id,
    required this.name,
    required this.createdDate,
    required this.qrCode,
    required this.stockCode,
    required this.imagePath,
    required this.priceOfBuy,
    required this.priceOfSell,
    required this.unitsInStock,
    required this.isPart,
    required this.isActive,
    required this.queNo,
    required this.productUnitID,
    // required this.productUnit, // JSON yanıtında yok
    required this.categoryID,
    this.category, // Nullable
    required this.branchID,
    this.branch, // Nullable
  });
factory Product.fromJson(Map<String, dynamic> json) {
  return Product(
    id: json['id'] ?? 0,
    name: json['name'] ?? '',
    createdDate: DateTime.parse(json['createdDate'] ?? DateTime.now().toIso8601String()),
    qrCode: json['qrCode'] ?? '',
    stockCode: json['stockCode'] ?? '',
    imagePath: json['imagePath'] ?? '',
    priceOfBuy: json['priceOfBuy']?.toDouble() ?? 0.0,
    priceOfSell: json['priceOfSell']?.toDouble() ?? 0.0,
    unitsInStock: json['unitsInStock']?.toDouble() ?? 0.0,
    isPart: json['isPart'] ?? false,
    isActive: json['isActive'] ?? false,
    queNo: json['queNo'] ?? 0,
    productUnitID: json['productUnitID'] ?? 0,
    categoryID: json['categoryID'] ?? 0,
    category: json['category'] != null ? Category.fromJson(json['category']) : null,
    branchID: json['branchID'] ?? 0,
    branch: json['branch'] != null ? Branch.fromJson(json['branch']) : null,
  );
}


  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'createdDate': createdDate.toIso8601String(),
      'qrCode': qrCode,
      'stockCode': stockCode,
      'imagePath': imagePath,
      'priceOfBuy': priceOfBuy,
      'priceOfSell': priceOfSell,
      'unitsInStock': unitsInStock,
      'isPart': isPart,
      'isActive': isActive,
      'queNo': queNo,
      'productUnitID': productUnitID,
      // 'productUnit': productUnit?.toJson(), // JSON yanıtında yok
      'categoryID': categoryID,
      'category': category?.toJson(),
      'branchID': branchID,
      'branch': branch?.toJson(),
    };
  }
}
