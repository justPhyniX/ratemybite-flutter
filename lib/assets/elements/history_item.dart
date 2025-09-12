import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:ratemybite/Models/DTOs/ProductDto.dart';
import 'package:ratemybite/data_service.dart';
import 'package:ratemybite/pages/product_info.dart';

class HistoryItem extends StatefulWidget {
  final ProductDto product;
  final DataService dataService;
  final VoidCallback deleteProduct;

  const HistoryItem({
    super.key,
    required this.product,
    required this.dataService,
    required this.deleteProduct
  });

  @override
  State<HistoryItem> createState() => _HistoryItemState();
}

class _HistoryItemState extends State<HistoryItem> {
  bool isChecked = false;

  @override
  Widget build(BuildContext context) {
    return Container(
        width: double.infinity,
        height: 95,
        decoration: ShapeDecoration(
          color: isChecked
          ? Theme.of(context).colorScheme.onPrimaryContainer
          : Theme.of(context).colorScheme.primaryContainer,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        child: InkWell(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => ProductInfo(product: widget.product, dataService: widget.dataService,)),
            );
          },
          child: Row(
          children: [
            //Selector Checkbox
            SizedBox(
              height: double.infinity,
              child: Align(
                alignment: Alignment.topCenter,
                child: Checkbox(
                  shape: CircleBorder(),
                  checkColor: const Color.fromARGB(255, 255, 255, 255),
                  value: isChecked,
                  onChanged: (bool? value) {
                    setState(() {
                      isChecked = value ?? false;
                    });
                  },
                ),
              ),
            ),

            //Product Image
            ClipRRect(
              borderRadius: BorderRadius.circular(5),
              child: FutureBuilder<String>(
                future: widget.dataService.GetImageUrl(widget.product.productImage),
                builder: (context, imageSnapshot) {
                  if (imageSnapshot.connectionState == ConnectionState.waiting) {
                    return const CircularProgressIndicator();
                  } else if (imageSnapshot.hasError || !imageSnapshot.hasData) {
                    return const Icon(Icons.broken_image, size: double.infinity);
                  } else {
                    return SizedBox(
                      width: 60,
                      height: 60,
                      child: Image.network(
                        imageSnapshot.data!,
                        fit: BoxFit.cover,
                        loadingBuilder: (context, child, loadingProgress) {
                          if (loadingProgress == null) return child;
                          return const Center(child: CircularProgressIndicator());
                        },
                        errorBuilder: (context, error, stackTrace) =>
                            const Icon(Icons.broken_image, size: 30),
                      ),
                    );
                  }
                },
              ),
            ),

            //Product Title And Brand
            Expanded(
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 10, vertical: 15),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      widget.product.productTitle,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    Text(
                      widget.product.brand,
                      style: TextStyle(
                        fontSize: 12,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
            ),

            //Rating
            ClipRRect(
              child: SvgPicture.asset(
                (() {
                  switch (widget.product.rating) {
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

            //Delete Icon
            SizedBox(
              height: double.infinity,
              child: Align(
                alignment: Alignment.topCenter,
                child: IconButton(
                  onPressed: () {
                    widget.deleteProduct();
                  },
                  icon: ImageIcon(
                    size: 20,
                    AssetImage(
                      'lib/assets/icons/product/delete_icon.png'
                    )
                  ),
                ),
              ),
            ),
          ],
        ),
        ),
      );
  }
}