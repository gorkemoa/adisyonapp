import 'package:adisyon_app/models/branch_model.dart';

class Category {
  final int id;
  final String name;
  final DateTime createdDate;
  final String categoryCode;
  final String? description;  // Null olabilir
  final String imagePath;
  final int branchID;
  final Branch? branch;  // Null olabilir

  Category({
    required this.id,
    required this.name,
    required this.createdDate,
    required this.categoryCode,
    this.description,
    required this.imagePath,
    required this.branchID,
    this.branch,
  });

  factory Category.fromJson(Map<String, dynamic> json) {
    return Category(
      id: json['id'],
      name: json['name'],
      createdDate: DateTime.parse(json['createdDate']),
      categoryCode: json['categoryCode'],
      description: json['description'],
      imagePath: json['imagePath'],
      branchID: json['branchID'],
      branch: json['branch'] != null ? Branch.fromJson(json['branch']) : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'createdDate': createdDate.toIso8601String(),
      'categoryCode': categoryCode,
      'description': description,
      'imagePath': imagePath,
      'branchID': branchID,
      'branch': branch?.toJson(),
    };
  }
}
