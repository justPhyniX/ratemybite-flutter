import 'package:flutter/material.dart';
import 'package:ratemybite/DataService.dart';
import 'package:ratemybite/Models/DTOs/ProductDto.dart';
import 'package:ratemybite/pages/product_info.dart';
import 'package:simple_barcode_scanner/simple_barcode_scanner.dart';
import 'package:permission_handler/permission_handler.dart';

String? result;

class MyBarcodeScanner extends StatefulWidget {
  const MyBarcodeScanner({super.key});

  @override
  State<MyBarcodeScanner> createState() => _MyBarcodeScannerState();
}

class _MyBarcodeScannerState extends State<MyBarcodeScanner> {
  BarcodeViewController? controller;
  bool _hasPermission = false;
  bool _isLoading = true;
  bool _isProcessing = false;

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

    return Stack(
      children: [
        SizedBox(
          width: 370,
          height: 500,
          child: SimpleBarcodeScanner(
            lineColor: "#ff6666",
            scanFormat: ScanFormat.ONLY_BARCODE,
            onScanned: (barcodeNumber) async {
              if (_isProcessing) return;
              
              setState(() {
                _isProcessing = true;
              });
              
              // Add debug print to see if scanning is working
              print("Barcode scanned: $barcodeNumber");
              
              try {
                if (barcodeNumber.isNotEmpty) {
                  ProductDto? product = await dataService.GetProductByBarcode(barcodeNumber);

                  if (mounted) {
                    if (product != null) {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ProductInfo(
                            awaitingProduct: Future.value(product),
                          ),
                        ),
                      );
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text("Product not found for barcode: $barcodeNumber"),
                          duration: const Duration(seconds: 3),
                        ),
                      );
                    }
                  }
                } else {
                  if (mounted) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text("Invalid barcode detected"),
                        duration: Duration(seconds: 2),
                      ),
                    );
                  }
                }
              } catch (e) {
                print("Error processing barcode: $e");
                if (mounted) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text("Error scanning barcode: $e"),
                      duration: const Duration(seconds: 3),
                    ),
                  );
                }
              } finally {
                // Reset processing flag after a delay
                Future.delayed(const Duration(seconds: 3), () {
                  if (mounted) {
                    setState(() {
                      _isProcessing = false;
                    });
                  }
                });
              }
            },
            onBarcodeViewCreated: (BarcodeViewController barcodeController) {
              controller = barcodeController;
            },
          ),
        ),
        if (_isProcessing)
          Container(
            width: 370,
            height: 500,
            color: Colors.black54,
            child: const Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircularProgressIndicator(color: Colors.white),
                  SizedBox(height: 16),
                  Text(
                    'Processing barcode...',
                    style: TextStyle(color: Colors.white, fontSize: 16),
                  ),
                ],
              ),
            ),
          ),
        // Add instructions overlay
        Positioned(
          top: 20,
          left: 0,
          right: 0,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: const Text(
              'Point camera at barcode',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.white,
                fontSize: 16,
                backgroundColor: Colors.black54,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
