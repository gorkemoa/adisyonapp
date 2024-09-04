import 'package:adisyon_app/models/product_model.dart';
import 'package:adisyon_app/screens/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:adisyon_app/screens/home_screen.dart';
import 'package:adisyon_app/screens/basket_screen.dart'; // Sepet ekranını içe aktarın

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Adisyon App',
      initialRoute: '/',
      routes: {
        '/': (context) => HomePage(),
        '/basket': (context) {
          final Map<Product, int> productQuantities = {}; // Burada uygun verileri sağlamalısınız
          return BasketScreen();
        }, // Sepet ekranı rotası eklendi
      },
    );
  }
}
