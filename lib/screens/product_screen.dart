import 'package:flutter/material.dart';
import '../models/category_model.dart';
import '../models/product_model.dart';
import '../services/api_service.dart';

class ProductScreen extends StatefulWidget {
  final int groupId;
  final List<Category> categories;

  const ProductScreen({Key? key, required this.groupId, required this.categories}) : super(key: key);

  @override
  _ProductScreenState createState() => _ProductScreenState();
}

class _ProductScreenState extends State<ProductScreen> {
  late Map<Category, List<Product>> categorizedProducts = {}; // Kategoriler ve ürünlerini saklayan map
  late Category? expandedCategory; // Şu anda genişletilmiş olan kategori
  String searchQuery = '';
  Map<Product, int> productQuantities = {}; // Ürünlerin miktarlarını saklamak için
  bool isLoading = true; // Yükleme durumu için değişken

  @override
  void initState() {
    super.initState();
    _loadProducts();
  }

  Future<void> _loadProducts() async {
    Map<Category, List<Product>> productsMap = {};
    for (var category in widget.categories) {
      final categoryProducts = await ApiService().getAllProductsByCategory(category.id);
      productsMap[category] = categoryProducts;
      // Ürünlerin miktarlarını başlangıçta 0 olarak ayarla
      for (var product in categoryProducts) {
        productQuantities[product] = 0;
      }
    }
    setState(() {
      categorizedProducts = productsMap;
      isLoading = false; // Yükleme tamamlandı
    });
  }

  void _filterProducts(String query) {
    setState(() {
      searchQuery = query;
    });
  }

  void _increaseQuantity(Product product) {
    setState(() {
      productQuantities[product] = (productQuantities[product] ?? 0) + 1;
    });
  }

  void _decreaseQuantity(Product product) {
    setState(() {
      if ((productQuantities[product] ?? 0) > 0) {
        productQuantities[product] = (productQuantities[product] ?? 0) - 1;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return Scaffold(
        appBar: AppBar(
          title: Text('Ürünler', style: TextStyle(fontWeight: FontWeight.bold)),
          backgroundColor: Colors.blueAccent,
          centerTitle: true,
          actions: [
            IconButton(
              icon: Icon(Icons.shopping_cart),
              onPressed: () {
                Navigator.pushNamed(
                  context,
                  '/basket',
                  arguments: productQuantities,
                );
              },
            ),
          ],
        ),
        body: Center(child: CircularProgressIndicator()), // Yükleniyor göstergesi
      );
    }

    // Arama sorgusuna göre filtreleme yap
    final filteredProducts = categorizedProducts.values.expand((products) => products).where((product) {
      return product.name.toLowerCase().contains(searchQuery.toLowerCase());
    }).toList();

    final filteredCategories = categorizedProducts.keys.where((category) {
      return categorizedProducts[category]!.any((product) => product.name.toLowerCase().contains(searchQuery.toLowerCase()));
    }).toList();

    return Scaffold(
      appBar: AppBar(
        title: Text('Ürünler', style: TextStyle(fontWeight: FontWeight.bold)),
        backgroundColor: Colors.blueAccent,
        centerTitle: true,
        actions: [
          IconButton(
            icon: Icon(Icons.shopping_cart),
            onPressed: () {
              Navigator.pushNamed(
                context,
                '/basket',
                arguments: productQuantities,
              );
            },
          ),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextField(
              decoration: InputDecoration(
                labelText: 'Ürün Ara',
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              onChanged: _filterProducts,
            ),
          ),
          Expanded(
            child: filteredCategories.isEmpty
                ? Center(child: Text('Ürün bulunamadı'))
                : ListView.builder(
                    itemCount: filteredCategories.length,
                    itemBuilder: (context, index) {
                      final category = filteredCategories[index];
                      final products = categorizedProducts[category] ?? [];

                      return Card(
                        color: Colors.redAccent[100],
                        margin: EdgeInsets.symmetric(vertical: 8, horizontal: 10),
                        elevation: 4,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: ExpansionTile(
                          title: Text(category.name, style: TextStyle(fontWeight: FontWeight.bold)),
                          onExpansionChanged: (expanded) {
                            setState(() {
                              if (expanded) {
                                expandedCategory = category;
                              } else if (expandedCategory == category) {
                                expandedCategory = null;
                              }
                            });
                          },
                          children: products.map((product) {
                            return ListTile(
                              contentPadding: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                              title: Text(product.name, style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                              subtitle: Text('Fiyat: ${product.priceOfBuy}', style: TextStyle(fontSize: 14)),
                              trailing: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  IconButton(
                                    icon: Icon(Icons.remove_circle, color: Colors.redAccent),
                                    onPressed: () => _decreaseQuantity(product),
                                  ),
                                  Text('${productQuantities[product] ?? 0}', style: TextStyle(fontSize: 16)),
                                  IconButton(
                                    icon: Icon(Icons.add_circle, color: Colors.green),
                                    onPressed: () => _increaseQuantity(product),
                                  ),
                                ],
                              ),
                            );
                          }).toList(),
                        ),
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }
}
