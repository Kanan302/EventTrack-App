import 'package:ascca_app/shared/utils/app_texts.dart';
import 'package:flutter/material.dart';

class AboutPage extends StatelessWidget {
  const AboutPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(AppTexts.about)),
      body: SafeArea(child: Center(child: Text('about page'))),
    );
  }
}
