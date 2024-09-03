import 'dart:convert';
import 'dart:io';
import 'package:http/io_client.dart';
import '../models/category_model.dart';
import '../models/desk_group_model.dart';
import '../models/product_model.dart';

class ApiService {
  static const String baseUrl = 'http://10.0.2.2:5143/api';

  final IOClient _ioClient;

  ApiService()
      : _ioClient = IOClient(HttpClient()
          ..badCertificateCallback = (X509Certificate cert, String host, int port) => true);

  Future<List<DeskGroup>> getAllDeskGroups() async {
    return _getList<DeskGroup>(
      '$baseUrl/Desk/GetAllDeskGroup',
      (data) => DeskGroup.fromJson(data),
    );
  }

  Future<List<DeskGroup>> getTablesByDeskGroup(int groupID) async {
    return _getList<DeskGroup>(
      '$baseUrl/Desk/GetAllDeskByGroup?groupID=$groupID',
      (data) => DeskGroup.fromJson(data),
    );
  }

  Future<List<Category>> getCategories() async {
    final response = await _ioClient.get(Uri.parse('$baseUrl/Category/GetAll'));
    if (response.statusCode == 200) {
      List<dynamic> data = json.decode(response.body);
      return data.map((item) => Category.fromJson(item)).toList();
    } else {
      throw Exception('Kategoriler alınamadı');
    }
  }

  Future<List<Product>> getAllProductsByCategory(int categoryID) async {
    final response = await _ioClient.get(Uri.parse('$baseUrl/Product/GetByCategory?categoryID=$categoryID'));
    if (response.statusCode == 200) {
      List<dynamic> data = json.decode(response.body);
      return data.map((item) => Product.fromJson(item)).toList();
    } else {
      throw Exception('Ürünler alınamadı');
    }
  }

  Future<List<Category>> getAllCategories() async {
    final response = await _ioClient.get(Uri.parse('$baseUrl/Category/GetAll'));
    if (response.statusCode == 200) {
      List<dynamic> data = json.decode(response.body);
      return data.map((item) => Category.fromJson(item)).toList();
    } else {
      throw Exception('Kategoriler alınamadı');
    }
  }

  Future<Map<String, dynamic>?> createBasket(Map<String, dynamic> basketData) async {
    final url = Uri.parse('$baseUrl/Basket/CreateBaskett');
    final response = await _ioClient.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(basketData),
    );

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      print('Error: ${response.statusCode}');
      return null;
    }
  }

  Future<List<T>> _getList<T>(String url, T Function(dynamic) fromJson) async {
    final response = await _ioClient.get(Uri.parse(url));
    if (response.statusCode == 200) {
      List<dynamic> data = json.decode(response.body);
      return data.map((item) => fromJson(item)).toList();
    } else {
      throw Exception('Veriler alınamadı');
    }
  }
}
