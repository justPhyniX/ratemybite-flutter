import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:ratemybite/Models/DTOs/ProductDto.dart';
import 'package:ratemybite/data_service.dart';

class ProductInfo extends StatelessWidget {
  final ProductDto product;
  final DataService dataService;

  const ProductInfo({
    super.key,
    required this.product,
    required this.dataService,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30), // whole page padding
          child: Center(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(
                    width: double.infinity,
                    height: 20,
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              product.productTitle,
                              style: const TextStyle(
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
                        padding: const EdgeInsets.all(10),
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
                    padding: const EdgeInsets.symmetric(vertical: 20),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(7),
                      child: FutureBuilder<String>(
                        future: dataService.GetImageUrl(product.productImage),
                        builder: (context, imageSnapshot) {
                          if (imageSnapshot.connectionState == ConnectionState.waiting) {
                            return const CircularProgressIndicator();
                          } else if (imageSnapshot.hasError || !imageSnapshot.hasData) {
                            return const Icon(Icons.broken_image, size: double.infinity);
                          } else {
                            return SizedBox(
                              width: double.infinity,
                              height: MediaQuery.of(context).size.width - 60,
                              child: Image.network(
                                imageSnapshot.data!,
                                fit: BoxFit.cover,
                                loadingBuilder: (context, child, loadingProgress) {
                                  if (loadingProgress == null) return child;
                                  return const Center(child: CircularProgressIndicator());
                                },
                                errorBuilder: (context, error, stackTrace) =>
                                    const Icon(Icons.broken_image, size: 60),
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
                    padding: const EdgeInsets.symmetric(vertical: 5),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Column(
                          children: [
                            Container(
                              padding: const EdgeInsets.all(5),
                              width: double.infinity,
                              child: const Text("Ingredients"),
                            ),
                            Container(
                              padding: const EdgeInsets.symmetric(
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
                              child: DefaultTextStyle(
                                style: TextStyle(color: Colors.white),
                                child: RichText(
                                  text: TextSpan(
                                    children: [
                                      for (int i = 0; i < product.ingredients.length; i++)
                                        TextSpan(
                                          text: product.ingredients[i].name +
                                              (i != product.ingredients.length - 1 ? ', ' : ''),
                                          style: TextStyle(
                                            color: product.ingredients[i].allergen
                                                ? Colors.white // or another color for allergens
                                                : product.ingredients[i].points <= 33
                                                    ? Colors.red
                                                    : product.ingredients[i].points <= 66
                                                        ? Colors.orange
                                                        : Colors.white,
                                            fontWeight: product.ingredients[i].allergen
                                                ? FontWeight.bold
                                                : FontWeight.normal,
                                            fontSize: 16,
                                          ),
                                        ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 10),
                        Column(
                          children: [
                            Container(
                              padding: const EdgeInsets.all(5),
                              width: double.infinity,
                              child: const Text("Allergens"),
                            ),
                            Container(
                              padding: const EdgeInsets.symmetric(
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
                        const SizedBox(height: 10),
                        Column(
                          children: [
                            Container(
                              padding: const EdgeInsets.all(5),
                              width: double.infinity,
                              child: const Text("You Should Know"),
                            ),
                            Container(
                              padding: const EdgeInsets.symmetric(
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
                  SizedBox(
                    width: double.infinity,
                    height: 20,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
