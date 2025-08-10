import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:ratemybite/Models/DTOs/ProductDto.dart';

class DataService {
  final String baseUrl = 'http://10.0.2.2:8080/'; //ONLY FOR EMULATOR

  Future<ProductDto?> GetProductByName(String productName) async {
    //Assemble request endpoint
    String endpoint = '${baseUrl}products/get?name=${productName}';

    final response = await http.get(Uri.parse(endpoint));

    //If request successful return a Product else throw exception
    if (response.statusCode == 200) {
      final jsonList = jsonDecode(response.body) as List;
      return ProductDto.fromJson(jsonList.first);
    } else {
      return null;
    }
  }
}

