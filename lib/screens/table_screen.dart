import 'package:flutter/material.dart';
import '../models/desk_group_model.dart';
import '../models/category_model.dart';
import '../services/api_service.dart';
import 'product_screen.dart';

class TableScreen extends StatefulWidget {
  final int groupId;

  const TableScreen({Key? key, required this.groupId}) : super(key: key);

  @override
  _TableScreenState createState() => _TableScreenState();
}

class _TableScreenState extends State<TableScreen> {
  late Future<List<DeskGroup>> tables;
  late Future<List<Category>> categories;

  @override
  void initState() {
    super.initState();
    tables = ApiService().getTablesByDeskGroup(widget.groupId);
    categories = ApiService().getCategories(); // Kategorileri al
  }

  void _navigateToProductScreen(DeskGroup deskGroup) async {
    final categoryList = await categories;

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ProductScreen(
          groupId: deskGroup.id,
          categories: categoryList, // Kategorileri geçir
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Masa Listesi'),
        backgroundColor: Colors.blueAccent,
        centerTitle: true,
      ),
      body: FutureBuilder<List<DeskGroup>>(
        future: tables,
        builder: (context, tableSnapshot) {
          if (tableSnapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (tableSnapshot.hasError) {
            return Center(child: Text('Bir hata oluştu: ${tableSnapshot.error}'));
          } else if (tableSnapshot.hasData) {
            return GridView.builder(
              padding: EdgeInsets.all(16.0),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 16,
                mainAxisSpacing: 16,
                childAspectRatio: 1.1,
              ),
              itemCount: tableSnapshot.data!.length,
              itemBuilder: (context, index) {
                final deskGroup = tableSnapshot.data![index];
                return GestureDetector(
                  onTap: () {
                    _navigateToProductScreen(deskGroup);
                  },
                  child: Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    elevation: 6,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.table_restaurant, size: 50, color: Colors.blueAccent),
                        SizedBox(height: 10),
                        Text(deskGroup.name, style: TextStyle(fontSize: 22)),
                      ],
                    ),
                  ),
                );
              },
            );
          } else {
            return Center(child: Text('Masa bulunamadı'));
          }
        },
      ),
    );
  }
}
