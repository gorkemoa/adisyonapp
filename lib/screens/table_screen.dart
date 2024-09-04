import 'package:adisyon_app/models/basket_model.dart';
import 'package:flutter/material.dart';
import '../models/desk_model.dart'; // desk_group_model yerine desk_model
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
  late Future<List<Desk>> tables;
  late Future<List<Category>> categories;

  @override
  void initState() {
    super.initState();
    tables = ApiService().getTablesByDeskGroups(widget.groupId); // Bu API çağrısının dönen modelin Desk olması gerektiğini unutmayın
    categories = ApiService().getCategories(); // Kategorileri al
  }

  Future<int> _getBranchIDFromUserInput() async {
    return 1;
  }

  Future<int> _getCashierIDFromSession() async {
    return 1;
  }

  Future<int> _getUserIDFromSession() async {
    return 1;
  }

  void _navigateToProductScreen(Desk desk) async {
    final categoryList = await categories;

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ProductScreen(
          groupId: desk.deskGroupID, // Desk'in deskGroupID'sini kullan
          categories: categoryList,
        ),
      ),
    );
  }

  Future<void> _activateDesk(Desk desk) async {
    try {
      final int branchID = await _getBranchIDFromUserInput();
      final int cashierID = await _getCashierIDFromSession();
      final int userID = await _getUserIDFromSession();

      // Sepet (basket) oluşturma
      final response = await ApiService().createBasket({
        "BranchID": branchID,
        "DeskID": desk.id, // Statik erişim yerine nesne üzerinden erişim
        "CashierID": cashierID,
        "Description": "Açıklama",
        "Name": "ORMANİÇİ CAFE",
        "OpenStatusID": desk.openStatusID, // Statik erişim yerine nesne üzerinden erişim
        "UserID": userID,
        "FatirsNo": ""
      });

      if (response != null) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Masa ${desk.name} aktif hale getirildi ve yeni bir sepet oluşturuldu!')),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Sepet oluşturulurken bir hata oluştu: $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Masa Listesi'),
        backgroundColor: Colors.blueAccent,
        centerTitle: true,
      ),
      body: FutureBuilder<List<Desk>>(
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
                final desk = tableSnapshot.data![index];
                return GestureDetector(
                  onTap: () {
                    _navigateToProductScreen(desk);
                  },
                  onLongPress: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('${desk.name} için işlemler'),
                        action: SnackBarAction(
                          label: 'Masayı Aktif Et',
                          onPressed: () {
                            _activateDesk(desk); // `Basket` yerine `desk` nesnesi gönderiliyor
                          },
                        ),
                      ),
                    );
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
                        Text(desk.name, style: TextStyle(fontSize: 22)),
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
