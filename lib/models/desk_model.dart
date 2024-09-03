// desk_model.dart
class Desk {
  final int deskGroupID;
  final int openStatusID;
  final int id;
  final String name;
  final DateTime createdDate;

  Desk({
    required this.deskGroupID,
    required this.openStatusID,
    required this.id,
    required this.name,
    required this.createdDate,
  });

  factory Desk.fromJson(Map<String, dynamic> json) {
    return Desk(
      deskGroupID: json['deskGroupID'] ?? 0,
      openStatusID: json['openStatusID'] ?? 0,
      id: json['id'] ?? 0,
      name: json['name'] ?? '',
      createdDate: DateTime.parse(json['createdDate'] ?? DateTime.now().toIso8601String()),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'deskGroupID': deskGroupID,
      'openStatusID': openStatusID,
      'id': id,
      'name': name,
      'createdDate': createdDate.toIso8601String(),
    };
  }
}
