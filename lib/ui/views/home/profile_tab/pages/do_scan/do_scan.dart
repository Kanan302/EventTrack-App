import 'package:flutter/material.dart';

class DoScanPage extends StatefulWidget {
  const DoScanPage({super.key});

  @override
  State<DoScanPage> createState() => _DoScanPageState();
}

class _DoScanPageState extends State<DoScanPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Do Scan')),
      body: SafeArea(child: Center(child: Text('do scan page'))),
    );
  }
}
