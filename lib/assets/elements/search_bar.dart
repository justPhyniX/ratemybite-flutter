import 'package:flutter/material.dart';
import 'package:ratemybite/data_service.dart';
import 'package:ratemybite/Models/DTOs/ProductDto.dart';
import 'package:ratemybite/pages/add_product.dart';
import 'package:ratemybite/pages/product_info.dart';

class MySearchBar extends StatefulWidget {
  const MySearchBar({super.key});

  @override
  State<MySearchBar> createState() => _MySearchBarState();
}

class _MySearchBarState extends State<MySearchBar> {
  @override
  Widget build(BuildContext context) {
    final dataService = DataService();  //handles the api calls
    
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20.0),
      child: Align(
        alignment: Alignment.topCenter,
        child: SearchAnchor(
          builder: (BuildContext context, SearchController controller) {
            Future<void> performSearch(String productName) async {
              if(productName.isNotEmpty) {
                ProductDto? product = await dataService.GetProductByName(productName);   //get the desired product

                if(product != null)
                {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => ProductInfo(awaitingProduct: Future.value(product),))
                  );
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: const Text(
                        "Product not found. Would you like to add a new product?",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      duration: const Duration(seconds: 8),
                      action: SnackBarAction(
                        label: 'Add Product',
                        textColor: Colors.white,
                        backgroundColor: Theme.of(context).colorScheme.primary,
                        onPressed: () {
                          Navigator.push(context, MaterialPageRoute(builder: (context) => AddProduct()));
                        },
                      ),
                    )
                  );
                }
              }
            }

            return SearchBar(
              controller: controller,
              padding: const WidgetStatePropertyAll<EdgeInsets>(
                EdgeInsets.symmetric(horizontal: 16.0),
              ),
              onTap: () { },
              onSubmitted: performSearch,
              textInputAction: TextInputAction.search,
              leading: const Icon(Icons.search),
              hintText: "Search Product Name",
              hintStyle: WidgetStateProperty.all(
                const TextStyle(
                  color: Color.fromARGB(100, 255, 255, 255),
                ),
              ),
              backgroundColor: WidgetStateProperty.all(
                Theme.of(context).colorScheme.primaryContainer,
              ),
              shadowColor: WidgetStateProperty.all(Colors.black.withAlpha(0)),
              shape: WidgetStateProperty.all(
                RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(7.0),
                ),
              ),
            );
          }, suggestionsBuilder: (BuildContext context, SearchController controller) { return []; },
          isFullScreen: false,
        )
      )
    );
  }
}
