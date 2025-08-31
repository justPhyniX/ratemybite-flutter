import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:ratemybite/Models/DTOs/ProductDto.dart';
import 'package:ratemybite/Models/DTOs/ProductPostDto.dart';

class DataService {
  // Single Instance Data Service
  DataService._privateConstructor();
  static final DataService _instance = DataService._privateConstructor();
  factory DataService() {
    return _instance;
  }
  
  final String baseUrl = 'http://10.0.2.2:8080/'; // FOR EMULATOR
  // final String baseUrl = 'http://192.168.2.8:8080/'; // FOR PHYSICAL DEVICE AT HOME

  Future<ProductDto?> GetProductByName(String productName) async {
    // Assemble request endpoint
    String endpoint = '${baseUrl}products/get?name=$productName';

    final response = await http.get(Uri.parse(endpoint));

    // If request successful return a Product
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

  Future<String> GetImageUrl(String imagePath) async {
    // Get the path parts
    List<String> pathParts = imagePath
        .split('\\');

    String folderName = pathParts[pathParts.length - 2];
    String imageName = pathParts.last;

    return '${baseUrl}uploads/images/$folderName/$imageName';
  }

  Future<ProductDto?> GetProductByBarcode(String barcode) async {
    // Assemble request endpoint
    String endpoint = '${baseUrl}products/get?barcode=$barcode';

    final response = await http.get(Uri.parse(endpoint));

    // If request successful return a Product
    if (response.statusCode == 200) {
      final jsonList = jsonDecode(response.body) as List;
      return ProductDto.fromJson(jsonList.first);
    } else {
      return null;
    }
  }

  Future<List<String>> GetIngredients() async {
    // Assemble request endpoint
    String endpoint = '${baseUrl}ingredients/all';

    final response = await http.get(Uri.parse(endpoint));

    // If request successful return list of ingredient names
    if (response.statusCode == 200) {
      final jsonList = jsonDecode(response.body) as List;
      return jsonList.map<String>((item) => item['name'] as String).toList();
    } else {
      return [];
    }
  }

  Future<List<int>> GetIngredientScores(List<String> ingredientNames) async{
    List<int> scores = [];
    
    for (final name in ingredientNames) {
      String endpoint = '${baseUrl}ingredients/get?name=$name';
      var response = await http.get(Uri.parse(endpoint));
  
      if (response.statusCode == 200 && response.body != 'null') {
        var jsonObject = jsonDecode(response.body) as Map<String, dynamic>;
        scores.add(jsonObject['points'] as int);
      } else {
        throw 'Something went wrong with the ingredient retrieval';
      }
    }

    return scores;
  }

  Future<List<String>> GetFoodCategories() async {
    // Assemble request endpoint
    String endpoint = '${baseUrl}foodcategories/all';

    final response = await http.get(Uri.parse(endpoint));

    // If request successful return list of category names
    if (response.statusCode == 200) {
      final jsonList = jsonDecode(response.body) as List;
      return jsonList.map<String>((item) => item['name'] as String).toList();
    } else {
      return [];
    }
  }

  Future<void> CheckCompanyNames(String companyName) async {
    // Assemble request endpoint for companies list
    String companiesEndpoint = '${baseUrl}companies/get?name=$companyName';

    // Check if company exists, if not, add it
    final response = await http.get(Uri.parse(companiesEndpoint));
    if(response.statusCode == 200 && response.body == 'null') {
      String addCompanyEndpoint = '${baseUrl}companies/add?name=$companyName';

      final postResponse = await http.post(Uri.parse(addCompanyEndpoint));
      if(postResponse.statusCode != 201) {
        throw Exception('Something went wrong with the new company addition');
      }
    }
  }

  Future<void> AddProduct(ProductPostDto newProduct, File productImage) async {
    // Assemble request endpoint for product data
    String productDataEndpoint = '${baseUrl}products/add-with-names';
    await CheckCompanyNames(newProduct.brand);

    // Send product data and get response
    final dataResponse = await http.post(
      Uri.parse(productDataEndpoint),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(newProduct.toJson()),
    );

    // If product data upload is successful try to upload product image
    if (dataResponse.statusCode == 201) {
      
      // Get product ID
      String productEndpoint = '${baseUrl}products/get?barcode=${newProduct.barcode}';
      final productResponse = await http.get(Uri.parse(productEndpoint));
      final jsonList = jsonDecode(productResponse.body) as List;
      final int productId = jsonList.first['id'] as int;

      // Add image to product with corresponding productId
      String productImageEndpoint = '${baseUrl}products/$productId/image';
      var imageRequest = http.MultipartRequest(
        'POST',
        Uri.parse(productImageEndpoint)
      );
      imageRequest.files.add(
        await http.MultipartFile.fromPath(
          'file',
          productImage.path
        )
      );
    
      var imageResponse = await imageRequest.send();

      // Check if image upload was successful
      if(imageResponse.statusCode != 200) {
        throw Exception('Something went wrong with the product image upload');
      }
    } else {
      throw Exception('Something went wrong with the product data upload');
    }
  }
}