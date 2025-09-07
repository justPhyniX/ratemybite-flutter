import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:ratemybite/Models/DTOs/ProductDto.dart';
import 'package:ratemybite/data_service.dart';
import 'package:ratemybite/pages/product_info.dart';

class HistoryItem extends StatefulWidget {
  final ProductDto product;
  final DataService dataService;

  const HistoryItem({
    super.key,
    required this.product,
    required this.dataService
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
        padding: const EdgeInsets.symmetric(
          horizontal: 10,
          vertical: 16
        ),
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
            Checkbox(
              shape: CircleBorder(),
              checkColor: Colors.black,
              value: isChecked,
              onChanged: (bool? value) {
                setState(() {
                  isChecked = value ?? false;
                });
              },
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
            SizedBox(
              width: 10,
            ),
            //Product Title And Brand
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.product.productTitle,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 15,
                    ),
                  ),
                  Text(
                    widget.product.brand,
                    style: TextStyle(
                      fontSize: 12,
                    ),
                  ),
                ],
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
            Container(
              child: IconButton(
                onPressed: () {
                  print('Delete History Item Button Pressed!!!');
                },
                icon: ImageIcon(
                  AssetImage(
                    'lib/assets/icons/product/delete_icon.png'
                  )
                ),
              ),
            ),


          ],
        ),
        ),
      );
  }
}