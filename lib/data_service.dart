import 'dart:convert';
import 'package:http/http.dart' as http;

class DataService {
  static String foodName = '';
  static String companyName = '';

  Future<Map<String, String>> fetchData() async {
    final response = await http.get(Uri.parse('http://10.0.2.2:8080/products/get/1'));

    if(response.statusCode == 200) {
      final data = jsonDecode(response.body);

      return {
        "foodName": data["name"],
        "companyName": data["company"]["name"]
      };
    } else {
      print('Error fetching data: ${response.statusCode}');
      return {
        "foodName": "Error",
        "companyName": "Failed to load"
      };
    }
  }
}