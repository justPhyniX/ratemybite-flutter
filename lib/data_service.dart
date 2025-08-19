import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:ratemybite/Models/DTOs/ProductDto.dart';

class DataService {
  // Private constructor
  DataService._privateConstructor();
  
  // Single instance
  static final DataService _instance = DataService._privateConstructor();
  
  // Factory constructor to return the same instance
  factory DataService() {
    return _instance;
  }
  
  //final String baseUrl = 'http://10.0.2.2:8080/'; // FOR EMULATOR
  //final String baseUrl = 'http://192.168.2.6:8080/'; // FOR PHYSICAL DEVICE AT HOME
  final String baseUrl = 'http://10.17.32.105:8080/'; // FOR PHYSICAL DEVICE AT WORK

  Future<ProductDto?> GetProductByName(String productName) async {
    //Assemble request endpoint
    String endpoint = '${baseUrl}products/get?name=$productName';

    final response = await http.get(Uri.parse(endpoint));

    //If request successful return a Product
    if (response.statusCode == 200) {
      try {
        final jsonList = jsonDecode(response.body) as List;
        return ProductDto.fromJson(jsonList.first);
      } catch (e) {
        return null;
      }
    } else {
      return null;
    }
  }

  Future<ProductDto?> GetProductByBarcode(String barcode) async {
    //Assemble request endpoint
    String endpoint = '${baseUrl}products/get?barcode=$barcode';

    final response = await http.get(Uri.parse(endpoint));

    //If request successful return a Product
    if (response.statusCode == 200) {
      final jsonList = jsonDecode(response.body) as List;
      return ProductDto.fromJson(jsonList.first);
    } else {
      return null;
    }
  }

  Future<List<String>> GetIngredients() async {
    //Assemble request endpoint
    String endpoint = '${baseUrl}ingredients/all';

    final response = await http.get(Uri.parse(endpoint));

    //If request successful return list of ingredient names
    
  }
}

