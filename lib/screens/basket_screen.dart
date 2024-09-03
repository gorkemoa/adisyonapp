import 'package:flutter/material.dart';
import '../models/product_model.dart';

class BasketScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final Map<Product, int> productQuantities = ModalRoute.of(context)!.settings.arguments as Map<Product, int>;

    final basketItems = productQuantities.entries.where((entry) => entry.value > 0).toList();

    return Scaffold(
      appBar: AppBar(
        title: Text('Sepetim', style: TextStyle(fontWeight: FontWeight.bold)),
        backgroundColor: Colors.blueAccent,
        centerTitle: true,
      ),
      body: basketItems.isEmpty
          ? Center(child: Text('Sepetinizde ürün yok.'))
          : ListView.builder(
              itemCount: basketItems.length,
              itemBuilder: (context, index) {
                final product = basketItems[index].key;
                final quantity = basketItems[index].value;

                return Card(
                  margin: EdgeInsets.symmetric(vertical: 8, horizontal: 10),
                  elevation: 4,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: ListTile(
                    contentPadding: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                    title: Text(product.name, style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                    subtitle: Text('Fiyat: ${product.priceOfBuy} x $quantity', style: TextStyle(fontSize: 14)),
                    trailing: Text('Toplam: ${product.priceOfBuy * quantity}', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                  ),
                );
              },
            ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ElevatedButton(
          onPressed: () {
            // Sepet onaylama işlemi burada yapılabilir
          },
          child: Text('Satın Al', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          style: ElevatedButton.styleFrom(
            padding: EdgeInsets.symmetric(vertical: 16),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
        ),
      ),
    );
  }
}
