import 'package:flutter/material.dart';

import '../../../../shared/constants/app_texts.dart';

class TrendingTab extends StatelessWidget {
  const TrendingTab({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(AppTexts.topEvents)),
      body: SafeArea(child: Center(child: Text('trending tab'))),
    );
  }
}
