import 'package:flutter/material.dart';
import 'package:ratemybite/pages/product_info.dart';

class HistoryItem extends StatefulWidget {
  const HistoryItem({super.key});

  @override
  State<HistoryItem> createState() => _HistoryItemState();
}

class _HistoryItemState extends State<HistoryItem> {
  bool isChecked = false;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: (){
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const ProductInfo()),
        );
      },
      child: Container(
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
              child: Image(
                image: AssetImage('lib/assets/icons/ratings/Product Image.png'),
                width: 57,
                height: 57,
                fit: BoxFit.cover,
              ),
            ),

            //Product Title And Brand
            Container(
              child: Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Product Title",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                      ),
                    ),
                    Text(
                      "Brand",
                      style: TextStyle(
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
              ),
            ),

            //Rating
            ClipRRect(
              borderRadius: BorderRadius.circular(5),
              child: Image(
                image: AssetImage( 'lib/assets/icons/ratings/A.png'),
                width: 57,
                height: 57,
                fit: BoxFit.cover,
              ),
            ),

            //Delete Icon
            Container(
              child: IconButton(
                onPressed: () {
                  print('HELLOOOOOO!!!!!!!');
                },
                icon: ImageIcon(
                  AssetImage(
                    'lib/assets/icons/history/delete_icon.png'
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