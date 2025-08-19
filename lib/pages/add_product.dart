import 'package:flutter/material.dart';
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
  final TextEditingController _barcodeController = TextEditingController();
  final TextEditingController _productNameController = TextEditingController();
  final TextEditingController _brandController = TextEditingController();

  @override
  void dispose() {
    _barcodeController.dispose();
    _productNameController.dispose();
    _brandController.dispose();
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
                  // Barcode number
                  TextFormField(
                    controller: _barcodeController,
                    decoration: InputDecoration(
                      labelText: 'Barcode Number',
                      labelStyle: TextStyle(color: Colors.white.withAlpha(125)),
                      floatingLabelStyle: TextStyle(color: Colors.white),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(7),
                      ),
                      filled: true,
                      fillColor: Theme.of(context).colorScheme.primaryContainer,
                    ),
                  ),
                  SizedBox(height: 20),
                  // Product name
                  TextFormField(
                    controller: _productNameController,
                    decoration: InputDecoration(
                      labelText: 'Product Name',
                      labelStyle: TextStyle(color: Colors.white.withAlpha(125)),
                      floatingLabelStyle: TextStyle(color: Colors.white),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(7),
                      ),
                      filled: true,
                      fillColor: Theme.of(context).colorScheme.primaryContainer,
                    ),
                  ),
                  SizedBox(height: 20),
                  // Brand
                  TextFormField(
                    controller: _brandController,
                    decoration: InputDecoration(
                      labelText: 'Brand',
                      labelStyle: TextStyle(color: Colors.white.withAlpha(125)),
                      floatingLabelStyle: TextStyle(color: Colors.white),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(7),
                      ),
                      filled: true,
                      fillColor: Theme.of(context).colorScheme.primaryContainer,
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
