class DeskGroup {
  final int branchID;
  final int id;
  final String name;
  final DateTime createdDate;

  DeskGroup({
    required this.branchID,
    required this.id,
    required this.name,
    required this.createdDate,
  });

  factory DeskGroup.fromJson(Map<String, dynamic> json) {
    final createdDate = json['createdDate'] != null
        ? DateTime.parse(json['createdDate'])
        : DateTime.now(); 

    return DeskGroup(
      branchID: json['branchID'] != null ? json['branchID'] as int : 0, // Varsayılan değer
      id: json['id'] != null ? json['id'] as int : 0, // Varsayılan değer
      name: json['name'] ?? 'Bilinmeyen', // Varsayılan değer
      createdDate: createdDate,
    );
  }
}
