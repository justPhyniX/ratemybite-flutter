import 'package:flutter/material.dart';

class HistoryItem extends StatefulWidget {
  const HistoryItem({super.key});

  @override
  State<HistoryItem> createState() => _HistoryItemState();
}

class _HistoryItemState extends State<HistoryItem> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        /*[GO TO PRODUCT FORM]*/
      },
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(
          horizontal: 10,
          vertical: 16
        ),
        decoration: ShapeDecoration(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadiusGeometry.circular(10),
          ),
        ),
        child: Row(
          children: [

            //Selector Checkbox
            Container(
              child: Checkbox(
                shape: CircleBorder(),
                value: isChecked,
                onChanged: /*[CHECKBOX FUNCTION]*/,
              ),
            ),

            //Product Image
            ImageIcon(),

            //Product Title And Brand
            Container(),

            //Rating
            ImageIcon(),

            //Delete Icon
            Container(
              child: IconButton(
                onPressed: /*[DELETE FUNCTION]*/,
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