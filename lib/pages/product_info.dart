import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:ratemybite/Models/DTOs/ProductDto.dart';
import 'package:ratemybite/data_service.dart';

class ProductInfo extends StatelessWidget {
  final Future<ProductDto?> awaitingProduct;
  final DataService dataService;

  const ProductInfo({
    super.key,
    required this.awaitingProduct,
    required this.dataService,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 30), // whole page padding
          child: Center(
            child: SingleChildScrollView(
              child: FutureBuilder(
                future: awaitingProduct,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return CircularProgressIndicator();
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
                                  Text(product.brand),
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
                              child: SvgPicture.asset(
                                (() {
                                  switch (product.rating) {
                                    case 'A':
                                      return 'lib/assets/icons/ratings/A.svg';
                                    case 'B':
                                      return 'lib/assets/icons/ratings/B.svg';
                                    case 'C':
                                      return 'lib/assets/icons/ratings/C.svg';
                                    case 'D':
                                      return 'lib/assets/icons/ratings/D.svg';
                                    case 'E':
                                      return 'lib/assets/icons/ratings/E.svg';
                                    default:
                                      return '';
                                  }
                                })(),
                              ),
                            ),
                          ],
                        ),
                        // product image
                        Container(
                          padding: EdgeInsets.symmetric(vertical: 20),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(7),
                            child: FutureBuilder<String>(
                              future: dataService.GetImageUrl(product.productImage),
                              builder: (context, imageSnapshot) {
                                if (imageSnapshot.connectionState == ConnectionState.waiting) {
                                  return CircularProgressIndicator();
                                } else if (imageSnapshot.hasError || !imageSnapshot.hasData) {
                                  return Icon(Icons.broken_image, size: double.infinity);
                                } else {
                                  return SizedBox(
                                    width: double.infinity,
                                    height: MediaQuery.of(context).size.width - 60,
                                    child: Image.network(
                                      imageSnapshot.data!,
                                      fit: BoxFit.cover,
                                      loadingBuilder: (context, child, loadingProgress) {
                                        if (loadingProgress == null) return child;
                                        return Center(child: CircularProgressIndicator());
                                      },
                                      errorBuilder: (context, error, stackTrace) =>
                                          Icon(Icons.broken_image, size: double.infinity),
                                    ),
                                  );
                                }
                              },
                            ),
                          ),
                        ),
                        Divider(
                          color: Theme.of(context).colorScheme.primaryContainer,
                          thickness: 3,
                        ),
                        // ingredient info
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
                                        children: product.ingredients.map((ingredient) {
                                          Color color = Colors.white;
                                          FontWeight fontWeight = FontWeight.normal;

                                          if (ingredient.points <= 66 && ingredient.points >= 34) {
                                            color = Colors.orange;
                                          } else if (ingredient.points <= 33) {
                                            color = Colors.red;
                                          }

                                          if (ingredient.allergen == true) {
                                            fontWeight = FontWeight.bold;
                                          }

                                          return TextSpan(
                                            text: '${ingredient.name}, ',
                                            style: TextStyle(
                                              color: color,
                                              fontWeight: fontWeight,
                                              fontSize: 16,
                                            ),
                                          );
                                        }).toList(),
                                        style: DefaultTextStyle.of(context).style,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: 10),
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
                                    child: Text(
                                      (() {
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
                                ],
                              ),
                              SizedBox(height: 10),
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
                                    child: Text(
                                      product.ingredients
                                          .map((ingredient) =>
                                              '• ${ingredient.name}: ${ingredient.description}')
                                          .join('\n'),
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
