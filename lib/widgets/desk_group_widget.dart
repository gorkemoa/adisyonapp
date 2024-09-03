import 'package:flutter/material.dart';
import '../models/desk_group_model.dart';

class DeskGroupWidget extends StatelessWidget {
  final DeskGroup deskGroup;
  final VoidCallback onTap; // Eklenen onTap parametresi

  const DeskGroupWidget({
    Key? key,
    required this.deskGroup,
    required this.onTap, // Parametrenin tanımı
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        title: Text(deskGroup.name),
        onTap: onTap, // onTap işlevini kullanma
      ),
    );
  }
}
