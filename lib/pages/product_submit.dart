import 'package:flutter/material.dart';

class ProductSubmit extends StatelessWidget {
  const ProductSubmit({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(20),
          child: Center(
            child: SingleChildScrollView(
              child: Column(
                children: [

                  //Add Image
                  Container(
                    decoration: ShapeDecoration(
                      color: Theme.of(context).colorScheme.primaryContainer,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadiusGeometry.circular(7)
                      )
                    ),
                    child: Image(
                      image: AssetImage(
                        'lib/assets/icons/product/Add Image Icon.png'
                      )
                    ),
                  ),

                  //Barcode Number
                  Container(
                    
                  ),

                  //Product Name
                  Container(

                  ),

                  //Brand
                  Container(

                  ),

                  //Ingredients Drop Down with Search Bar
                  Container(

                  ),

                  //Category Drop Down
                  Container(

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