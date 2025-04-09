import 'package:flutter/material.dart';
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
    return SizedBox(
      width: 370,
      height: 500,
      child: SimpleBarcodeScanner(
        scaleHeight: 250,
        scaleWidth: 600,
        onScanned: (code) {
          setState(() {
            result = code;
          });
        },
        continuous: true,
        onBarcodeViewCreated: (BarcodeViewController controller) {
          this.controller = controller;
        },
      ),
    );
  }
}
