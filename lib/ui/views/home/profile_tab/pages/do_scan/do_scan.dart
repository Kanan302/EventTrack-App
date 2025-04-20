import 'dart:async';

import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart';

import '../../../../../../shared/theme/app_colors.dart';

class DoScanPage extends StatefulWidget {
  const DoScanPage({super.key});

  @override
  State<DoScanPage> createState() => _DoScanPageState();
}

class _DoScanPageState extends State<DoScanPage> {
  final MobileScannerController controller = MobileScannerController();
  StreamSubscription<BarcodeCapture>? subscription;
  String? scannedCode;
  bool isScanned = false;

  void listenToBarcodes() {
    subscription = controller.barcodes.listen((BarcodeCapture capture) {
      final barcode = capture.barcodes.first;
      final code = barcode.rawValue;

      if (code != null && !isScanned) {
        setState(() {
          scannedCode = code;
          isScanned = true;
        });
        debugPrint('scanned code is: $scannedCode');
        Future.delayed(const Duration(seconds: 2), () {
          setState(() => isScanned = false);
        });
      }
    });
  }

  @override
  void initState() {
    super.initState();
    listenToBarcodes();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => Navigator.of(context).pop(),
          icon: Icon(Icons.arrow_back_ios_new_outlined),
        ),
      ),
      body: Stack(
        children: [
          MobileScanner(controller: controller, fit: BoxFit.cover),
          Center(
            child: Container(
              width: 250,
              height: 250,
              decoration: BoxDecoration(
                border: Border.all(color: AppColors.white, width: 4),
                borderRadius: BorderRadius.circular(12),
              ),
            ),
          ),

          if (scannedCode != null)
            Positioned(
              left: 10,
              bottom: 10,
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.black.withValues(alpha: 0.6 * 255),
                  borderRadius: BorderRadius.circular(12),
                ),
                padding: const EdgeInsets.all(12),
                child: Text(
                  'Code: $scannedCode',
                  style: const TextStyle(color: AppColors.white),
                ),
              ),
            ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    subscription?.cancel();
    controller.dispose();
    super.dispose();
  }
}
