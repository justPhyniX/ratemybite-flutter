import 'package:flutter/material.dart';
import 'package:ratemybite/data_service.dart';
import 'package:ratemybite/Models/DTOs/ProductDto.dart';
import 'package:ratemybite/pages/product_info.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:permission_handler/permission_handler.dart';

class MyBarcodeScanner extends StatefulWidget {
  const MyBarcodeScanner({super.key});

  @override
  State<MyBarcodeScanner> createState() => _MyBarcodeScannerState();
}

class _MyBarcodeScannerState extends State<MyBarcodeScanner> {
  //BarcodeViewController? controller;
  bool _hasPermission = false;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _checkCameraPermission();
  }

  Future<void> _checkCameraPermission() async {
    final status = await Permission.camera.status;
    if (status.isGranted) {
      setState(() {
        _hasPermission = true;
        _isLoading = false;
      });
    } else {
      final result = await Permission.camera.request();
      setState(() {
        _hasPermission = result.isGranted;
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final dataService = DataService();  //handles the api calls

    if (_isLoading) {
      return const SizedBox(
        width: 370,
        height: 500,
        child: Center(
          child: CircularProgressIndicator(),
        ),
      );
    }

    if (!_hasPermission) {
      return SizedBox(
        width: 370,
        height: 500,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(
                Icons.camera_alt_outlined,
                size: 64,
                color: Colors.grey,
              ),
              const SizedBox(height: 16),
              const Text(
                'Camera permission is required\nto scan barcodes',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 16),
              ),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: _checkCameraPermission,
                child: const Text('Grant Permission'),
              ),
            ],
          ),
        ),
      );
    }

    return SizedBox(
      width: 370,
      height: 500,
      child: MobileScanner(
        onDetect: (barcodeCapture) async {
          String? barcode = barcodeCapture.barcodes.first.rawValue;
          print('Barcode found! $barcode');

          ProductDto? product = await dataService.GetProductByBarcode(barcode ??= '0');
          if (product != null) {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => ProductInfo(awaitingProduct: Future.value(product))),
            );
          } else {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: const Text("Product not found. Would you like to add a new product?"),
                duration: const Duration(seconds: 5),
                action: SnackBarAction(
                  label: 'Add Product',
                  textColor: Theme.of(context).colorScheme.primary,
                  onPressed: () {
                    // TODO: Navigate to add product form
                    // Navigator.push(context, MaterialPageRoute(builder: (context) => AddProduct()));
                  },
                ),
              ),
            );
          }
        },
      ),
    );
  }
}
