import 'package:flutter/material.dart';
import 'package:ratemybite/DataService.dart';
import 'package:ratemybite/Models/DTOs/ProductDto.dart';
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
      padding: const EdgeInsets.all(20.0),
      child: Align(
        alignment: Alignment.topCenter,
        child: SearchAnchor(
          builder: (BuildContext context, SearchController controller) {
            return SearchBar(
              controller: controller,
              padding: const WidgetStatePropertyAll<EdgeInsets>(
                EdgeInsets.symmetric(horizontal: 16.0),
              ),
              onTap: () { },
              onSubmitted: (productName) {
                Future<ProductDto?>? product = dataService.GetProductByName(productName);   //get the desired product

                if(product != null)
                {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => ProductInfo(awaitingProduct: product,))
                  );
                }
                
              },
              leading: const Icon(Icons.search),
              hintText: "Search",
              //hintStyle: ,
            );
          }, suggestionsBuilder: (BuildContext context, SearchController controller) { return []; },
        )
      )
    );
  }
}
