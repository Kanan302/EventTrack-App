import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile_scanner/mobile_scanner.dart';

import '../../../../../../generated/l10n/app_localizations.dart';
import '../../../../../../shared/theme/app_colors.dart';
import '../../../../../cubits/events/scan_event/scan_event_cubit.dart';

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

        context.read<ScanEventCubit>().scanEvent(context, code);

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
          icon: const Icon(Icons.arrow_back_ios_new_outlined),
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

          BlocBuilder<ScanEventCubit, ScanEventState>(
            builder: (context, state) {
              if (state is ScanEventLoading) {
                return CircularProgressIndicator();
              } else if (state is ScanEventSuccess) {
                return _buildMessageBox(
                  AppLocalizations.of(context).attendanceConfirmed,
                  AppColors.lavenderBlue,
                );
              } else if (state is ScanEventFailure) {
                return _buildMessageBox(state.errorMessage, AppColors.red);
              }
              return const SizedBox.shrink();
            },
          ),

          // Scan edilmiş kodun göstərilməsi
          // if (scannedCode != null)
          //   Positioned(
          //     left: 10,
          //     bottom: 80,
          //     child: Container(
          //       decoration: BoxDecoration(
          //         color: Colors.black.withOpacity(0.6),
          //         borderRadius: BorderRadius.circular(12),
          //       ),
          //       padding: const EdgeInsets.all(12),
          //       child: Text(
          //         '${AppLocalizations.of(context).code} $scannedCode',
          //         style: const TextStyle(color: AppColors.white),
          //       ),
          //     ),
          //   ),
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

  Widget _buildMessageBox(String message, Color color) {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Padding(
        padding: const EdgeInsets.only(bottom: 20.0),
        child: Positioned(
          left: 10,
          bottom: 10,
          child: Opacity(
            opacity: 0.85,
            child: Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: color,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Text(
                message,
                style: const TextStyle(color: AppColors.white),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
