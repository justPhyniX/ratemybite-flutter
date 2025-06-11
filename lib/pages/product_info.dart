import 'package:flutter/material.dart';

void main() {
  runApp(
    MaterialApp(
      theme: ThemeData(
        fontFamily: 'Nunito',
      ),
      home: ProductInfo(),
  ));

}

class ProductInfo extends StatelessWidget {
  const ProductInfo({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 30), //whole page padding
          child: Center(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Product Title",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 20,
                              ),
                            ),
                            Text(
                              "Brand",
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
                              borderRadius: BorderRadius.circular(7)
                          ),
                        ),
                        child: Image(
                            image: AssetImage('lib/assets/icons/ratings/A.png')
                        ),
                      ),

                      ],
                    ),

                    //product image
                    Container(
                      padding: EdgeInsets.symmetric(vertical: 20),
                      decoration: ShapeDecoration(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10)
                        ),
                      ),
                      child: Image(
                        image: AssetImage(
                            'lib/assets/icons/ratings/Product Image.png'
                        ),
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
                        spacing: 10,
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
                                    horizontal: 20
                                ),
                                width: double.infinity,
                                decoration: ShapeDecoration(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(7),
                                  ),
                                  color: Theme.of(context).colorScheme.secondary,
                                ),
                                child: RichText(
                                  text: TextSpan(
                                      text: "Ingredient, Ingredient, Ingredient, "
                                          "Ingredient, Ingredient, Ingredient"
                                  ),
                                ),
                              ),
                            ]
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
                                    horizontal: 20
                                ),
                                width: double.infinity,
                                decoration: ShapeDecoration(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(7),
                                  ),
                                  color: Theme.of(context).colorScheme.secondary,
                                ),
                                child: RichText(
                                  text: TextSpan(
                                      text: "Soy, Gluten"
                                  ),
                                ),
                              ),
                            ]
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
                                    horizontal: 20
                                ),
                                width: double.infinity,
                                decoration: ShapeDecoration(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(7),
                                  ),
                                  color: Theme.of(context).colorScheme.secondary,
                                ),
                                child: RichText(
                                  text: TextSpan(
                                      text: "Lorem ipsum dolor sit amet "
                                          "consectetur. Donec pellentesque lacus "
                                          "nisl eu diam cras pretium tristique."
                                  ),
                                ),
                              ),
                            ]
                          ),


                        ],
                      ),
                    ),
                  ]
              ),
            ),
          ),
        ),
      ),
    );
  }
}
