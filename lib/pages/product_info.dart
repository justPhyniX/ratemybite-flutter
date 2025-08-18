import 'package:flutter/material.dart';
import 'package:ratemybite/Models/DTOs/ProductDto.dart';

class ProductInfo extends StatelessWidget {
  final Future<ProductDto?> awaitingProduct;

  const ProductInfo({super.key, required this.awaitingProduct});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 30), //whole page padding
          child: Center(
            child: SingleChildScrollView(
              child: FutureBuilder(
                future: awaitingProduct,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return CircularProgressIndicator(); //shows loading spinner
                  } else if (snapshot.hasError || !snapshot.hasData) {
                    return Text("Error fetching data");
                  } else {
                    final product = snapshot.data!;
                    return Column(
                      children: [
                        Row(
                          children: [
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    product.productTitle,
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20,
                                    ),
                                  ),
                                  Text(
                                    product.brand,
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              alignment: Alignment.centerRight,
                              padding: EdgeInsets.all(10),
                              decoration: ShapeDecoration(
                                color: Theme.of(context).colorScheme.primaryContainer,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(7),
                                ),
                              ),
                              child: Image(
                                image: AssetImage(
                                  (() {
                                    switch (product.rating) {
                                      case 'A':
                                        return 'lib/assets/icons/ratings/A.png';
                                      case 'B':
                                        return 'lib/assets/icons/ratings/B.png';
                                      case 'C':
                                        return 'lib/assets/icons/ratings/C.png';
                                      case 'D':
                                        return 'lib/assets/icons/ratings/D.png';
                                      case 'E':
                                        return 'lib/assets/icons/ratings/E.png';
                                      default:
                                        return '';
                                    }
                                  })(),
                                ),
                              ),
                            ),
                          ],
                        ),
                        //product image
                        Container(
                          padding: EdgeInsets.symmetric(vertical: 20),
                          decoration: ShapeDecoration(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          child: Image.network(
                            product.productImage,
                            errorBuilder: (context, error, stackTrace) {
                              return Icon(Icons.broken_image, size: 100);
                            },
                          ),
                        ),
                        Divider(
                          color: Theme.of(context).colorScheme.primaryContainer,
                          thickness: 3,
                        ),
                        //ingredient info
                        Container(
                          padding: EdgeInsets.symmetric(vertical: 5),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Column(
                                children: [
                                  Container(
                                    padding: EdgeInsets.all(5),
                                    width: double.infinity,
                                    child: Text("Ingredients"),
                                  ),
                                  Container(
                                    padding: EdgeInsets.symmetric(
                                      vertical: 15,
                                      horizontal: 20,
                                    ),
                                    width: double.infinity,
                                    decoration: ShapeDecoration(
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(7),
                                      ),
                                      color: Theme.of(context).colorScheme.primaryContainer,
                                    ),
                                    child: RichText(
                                      text: TextSpan(
                                        text: product.ingredients.map((ingredient) => ingredient.name).join(', '),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              Column(
                                children: [
                                  Container(
                                    padding: EdgeInsets.all(5),
                                    width: double.infinity,
                                    child: Text("Allergens"),
                                  ),
                                  Container(
                                    padding: EdgeInsets.symmetric(
                                      vertical: 15,
                                      horizontal: 20,
                                    ),
                                    width: double.infinity,
                                    decoration: ShapeDecoration(
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(7),
                                      ),
                                      color: Theme.of(context).colorScheme.primaryContainer,
                                    ),
                                    child: RichText(
                                      text: TextSpan(
                                        text: (() {
                                          final allergenNames = product.ingredients
                                              .where((ingredient) => ingredient.allergen)
                                              .map((ingredient) => ingredient.name)
                                              .toList();
                                          return allergenNames.isEmpty
                                              ? "No allergens"
                                              : allergenNames.join(', ');
                                        })(),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              Column(
                                children: [
                                  Container(
                                    padding: EdgeInsets.all(5),
                                    width: double.infinity,
                                    child: Text("You Should Know"),
                                  ),
                                  Container(
                                    padding: EdgeInsets.symmetric(
                                      vertical: 15,
                                      horizontal: 20,
                                    ),
                                    width: double.infinity,
                                    decoration: ShapeDecoration(
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(7),
                                      ),
                                      color: Theme.of(context).colorScheme.primaryContainer,
                                    ),
                                    child: RichText(
                                      text: TextSpan(
                                        text: product.ingredients
                                            .map((ingredient) => '- ${ingredient.name}: ${ingredient.description}')
                                            .join('\n'),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    );
                  }
                },
              ),
            ),
          ),
        ),
      ),
    );
  }
}
