// lib/screens/home_page.dart
import 'package:flutter/material.dart';
import '../services/api_service.dart';
import '../models/desk_group_model.dart';
import 'table_screen.dart'; // TableScreen'i import edin

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late Future<List<DeskGroup>> deskGroups;

  @override
  void initState() {
    super.initState();
    deskGroups = ApiService().getAllDeskGroups();
  }

  void _navigateToTableScreen(int groupId) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => TableScreen(groupId: groupId),
      ),
    );
  }

  IconData _getIconForDeskGroup(String name) {
    switch (name.toLowerCase()) {
      case 'salon':
        return Icons.meeting_room; // Salon ikonu
      case 'teras':
        return Icons.deck; // Teras ikonu
      case 'bahçe':
        return Icons.park; // Bahçe ikonu
      default:
        return Icons.home; // Varsayılan ikon
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Adisyon Uygulaması'),
        backgroundColor: Colors.blueAccent, // AppBar rengini mavi yap
      ),
      body: FutureBuilder<List<DeskGroup>>(
        future: deskGroups,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Bir hata oluştu: ${snapshot.error}'));
          } else if (snapshot.hasData) {
            return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                final deskGroup = snapshot.data![index];
                return Card(
                  margin: EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
                  elevation: 5,
                  child: ListTile(
                    contentPadding: EdgeInsets.all(16.0),
                    leading: Icon(
                      _getIconForDeskGroup(deskGroup.name),
                      color: Colors.blueAccent,
                    ),
                    title: Text(
                      deskGroup.name,
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    tileColor: Colors.lightBlue[50], // Arka plan rengini açık mavi yap
                    onTap: () => _navigateToTableScreen(deskGroup.id),
                  ),
                );
              },
            );
          } else {
            return Center(child: Text('Masa grubu bulunamadı'));
          }
        },
      ),
    );
  }
}
