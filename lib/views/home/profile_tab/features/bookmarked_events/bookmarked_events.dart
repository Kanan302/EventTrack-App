import 'package:ascca_app/core/utils/app_texts.dart';
import 'package:flutter/material.dart';

class BookmarkedEventsPage extends StatelessWidget {
  const BookmarkedEventsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(AppTexts.bookmarkedEvents)),
      body: SafeArea(child: Center(child: Text('bookmarked events page'))),
    );
  }
}
