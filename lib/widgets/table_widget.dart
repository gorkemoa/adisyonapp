// lib/widgets/desk_group_widget.dart
import 'package:flutter/material.dart';
import '../models/desk_group_model.dart'; // DeskGroup modelini import edin

class DeskGroupWidget extends StatelessWidget {
  final DeskGroup deskGroup;
  final Function(DeskGroup) onTap; // Tıklama için callback fonksiyonu

  const DeskGroupWidget({
    Key? key,
    required this.deskGroup,
    required this.onTap, // Callback'i al
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onTap(deskGroup), // Tıklama işlemi
      child: Card(
        margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
        color: Colors.blue[100], // Arka plan rengini ayarlayın
        child: ListTile(
          contentPadding: EdgeInsets.all(15),
          title: Text(
            deskGroup.name,
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          subtitle: Text(
            'Oluşturulma Tarihi: ${deskGroup.createdDate.toLocal().toString().split(' ')[0]}', // Tarihi formatlayın
          ),
          trailing: Icon(
            Icons.group, // İkonu ayarlayın
            color: Colors.blue,
          ),
        ),
      ),
    );
  }
}
