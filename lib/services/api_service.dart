import 'dart:convert';
import 'dart:io';
import 'package:adisyon_app/models/desk_model.dart';
import 'package:http/io_client.dart';
import 'package:http/http.dart' as http;  // http paketini import ediyoruz
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
    try {
      final response = await _ioClient.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(basketData),
      );

      if (response.statusCode == 200) {
        return jsonDecode(response.body);
      } else if (response.statusCode == 307) {
        // Yönlendirme URL'sini kontrol et
        final redirectUrl = response.headers['location'];
        if (redirectUrl != null) {
          final newUrl = Uri.parse(redirectUrl);
          final redirectedResponse = await _ioClient.get(newUrl);
          if (redirectedResponse.statusCode == 200) {
            return jsonDecode(redirectedResponse.body);
          } else {
            throw Exception('Yönlendirilmiş istekte hata oluştu');
          }
        } else {
          throw Exception('Yönlendirme URL\'si bulunamadı');
        }
      } else {
        throw Exception('API isteğinde hata oluştu: ${response.statusCode}');
      }
    } catch (e) {
      print('Hata: $e');
      return null;
    }
  }

  Future<void> loginUser(String userName, String password) async {
    final String url = '$baseUrl/User/Login?userName=$userName&password=$password';

    try {
      final response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        // Giriş başarılı
        var data = jsonDecode(response.body);
        print('Login successful: $data');
      } else {
        // Giriş başarısız
        print('Failed to login: ${response.statusCode}');
      }
    } catch (e) {
      print('Error occurred: $e');
    }
  }

  Future<List<Desk>> getTablesByDeskGroups(int groupID) async {
    return _getList<Desk>(
      '$baseUrl/Desk/GetAllDeskByGroup?groupID=$groupID',
      (data) => Desk.fromJson(data),
    );
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
