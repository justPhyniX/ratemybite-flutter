import 'package:flutter/material.dart';
import 'package:ratemybite/Models/DTOs/ProductDto.dart';
import 'package:ratemybite/theme.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Rate My Bite',
      theme: darkMode,
      //darkTheme: ,    For future use
      home: const AddProduct(),
    );
  }
}

class AddProduct extends StatefulWidget {

  const AddProduct({super.key});

  @override
  State<AddProduct> createState() => _AddProductState();
}

class _AddProductState extends State<AddProduct> {
  // final ProductDto product = ProductDto();
  final TextEditingController _formItemController = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _formItemController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      appBar: AppBar(
        title: Text(
          'Add Product',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 24
          ),
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 30), //whole page padding
          child: Center(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  //barcode number
                  Container(
                    child: TextFormField(
                      controller: _formItemController,
                      decoration: InputDecoration(
                        labelText: 'Barcode Number',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(7),
                        ),
                        filled: true,
                        fillColor: Theme.of(context).colorScheme.primaryContainer,
                      ),
                    ),
                  ),
                  SizedBox(height: 20),
                  Container(
                    child: TextFormField(
                      controller: _formItemController,
                      decoration: InputDecoration(
                        labelText: 'Product Name',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(7),
                        ),
                        filled: true,
                        fillColor: Theme.of(context).colorScheme.primaryContainer,
                      ),
                    ),
                  ),
                  SizedBox(height: 20),
                  Container(
                    child: TextFormField(
                      controller: _formItemController,
                      decoration: InputDecoration(
                        labelText: 'Brand',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(7),
                        ),
                        filled: true,
                        fillColor: Theme.of(context).colorScheme.primaryContainer,
                      ),
                    ),
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
