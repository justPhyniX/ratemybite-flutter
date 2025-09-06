import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:ratemybite/data_service.dart';
import 'package:ratemybite/Models/DTOs/ProductDto.dart';
import 'package:ratemybite/pages/add_product.dart';
import 'package:ratemybite/pages/product_info.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:permission_handler/permission_handler.dart';

class MyBarcodeScanner extends StatefulWidget {
  const MyBarcodeScanner({super.key});

  @override
  State<MyBarcodeScanner> createState() => _MyBarcodeScannerState();
}

class _MyBarcodeScannerState extends State<MyBarcodeScanner> {
  final MobileScannerController controller = MobileScannerController(
    detectionSpeed: DetectionSpeed.noDuplicates,
    facing: CameraFacing.back,
  );
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
        width: double.infinity,
        height: 500,
        child: Center(
          child: CircularProgressIndicator(),
        ),
      );
    }

    if (!_hasPermission) {
      return SizedBox(
        width: double.infinity,
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
              )
            ],
          ),
        ),
      );
    }

    return SizedBox(
      width: double.infinity,
      height: 500,
      child: Stack(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(7.0),
            child: MobileScanner(
              controller: controller,
              onDetect: (barcodeCapture) async {
                String? barcode = barcodeCapture.barcodes.first.rawValue;
                log('Barcode successfully scanned:  $barcode'); // Logs barcode number in console for debugging

                ProductDto? product = await dataService.GetProductByBarcode(barcode ??= '0');
                if (product != null) {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => ProductInfo(product: product, dataService: dataService)),
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
                          Navigator.push(context, MaterialPageRoute(builder: (context) => AddProduct()));
                        },
                      ),
                    ),
                  );
                }
              },
            ),
          ),
          // Scan barcode hint
          Positioned(
            bottom: 80,
            left: 20,
            right: 20,
            child: Center(
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                decoration: BoxDecoration(
                  color: const Color.fromARGB(100, 0, 0, 0),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: const Text(
                  'Scan Product Barcode',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
