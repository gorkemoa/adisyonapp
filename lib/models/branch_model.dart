class Branch {
  final int id;
  final String name;
  final DateTime createdDate;
  final String branchCode;
  final String description;
  final String phone;
  final String address;
  final String city;
  final String region;

  Branch({
    required this.id,
    required this.name,
    required this.createdDate,
    required this.branchCode,
    required this.description,
    required this.phone,
    required this.address,
    required this.city,
    required this.region,
  });

  factory Branch.fromJson(Map<String, dynamic> json) {
    return Branch(
      id: json['id'],
      name: json['name'],
      createdDate: DateTime.parse(json['createdDate']),
      branchCode: json['branchCode'],
      description: json['description'],
      phone: json['phone'],
      address: json['address'],
      city: json['city'],
      region: json['region'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'createdDate': createdDate.toIso8601String(),
      'branchCode': branchCode,
      'description': description,
      'phone': phone,
      'address': address,
      'city': city,
      'region': region,
    };
  }
}
