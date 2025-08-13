import 'package:flutter/material.dart';
import 'package:ratemybite/DataService.dart';
import 'package:ratemybite/Models/DTOs/ProductDto.dart';
import 'package:ratemybite/pages/product_info.dart';
import 'package:simple_barcode_scanner/simple_barcode_scanner.dart';

String? result;

class MyBarcodeScanner extends StatefulWidget {
  const MyBarcodeScanner({super.key});

  @override
  State<MyBarcodeScanner> createState() => _MyBarcodeScannerState();
}

class _MyBarcodeScannerState extends State<MyBarcodeScanner> {
  set controller(BarcodeViewController controller) {}

  @override
  Widget build(BuildContext context) {
    final dataService = DataService();  //handles the api calls

    return SizedBox(
      width: 370,
      height: 500,
      child: SimpleBarcodeScanner(
        scaleHeight: 250,
        scaleWidth: 600,
        onScanned: (barcodeNumber) async {
          ProductDto? product = await dataService.GetProductByBarcode(barcodeNumber);

          if(product != null) {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => ProductInfo(awaitingProduct: Future.value(product),))
            );
          } else {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text("Product not found"))
            );
          }
        },
        continuous: false,
        onBarcodeViewCreated: (BarcodeViewController controller) {
          this.controller = controller;
        },
        scanFormat: ScanFormat.ONLY_BARCODE,
      ),
    );
  }
}
