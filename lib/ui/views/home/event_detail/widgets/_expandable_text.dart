import 'package:ascca_app/shared/constants/app_texts.dart';
import 'package:flutter/material.dart';

import '../../../../../shared/theme/app_colors.dart';

class ExpandableText extends StatefulWidget {
  final String text;

  const ExpandableText({super.key, required this.text});

  @override
  State<ExpandableText> createState() => _ExpandableTextState();
}

class _ExpandableTextState extends State<ExpandableText>
    with SingleTickerProviderStateMixin {
  final ValueNotifier<bool> _isExpanded = ValueNotifier<bool>(false);

  bool get _isTextOverflowing {
    final textLength = widget.text.length;
    final maxTextLengthForTwoLines =
        100; // Adjust this value based on your font size and padding
    return textLength > maxTextLengthForTwoLines && !_isExpanded.value;
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<bool>(
      valueListenable: _isExpanded,
      builder: (context, isExpanded, child) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AnimatedSize(
              duration: const Duration(milliseconds: 400),
              curve: Curves.easeInOut,
              child: Text(
                widget.text,
                maxLines: isExpanded ? null : 2,
                overflow:
                    isExpanded ? TextOverflow.visible : TextOverflow.ellipsis,
                softWrap: true,
                style: const TextStyle(fontSize: 16),
              ),
            ),
            const SizedBox(height: 4),
            _isTextOverflowing
                ? GestureDetector(
                  onTap: () {
                    _isExpanded.value = !_isExpanded.value;
                  },
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        isExpanded ? AppTexts.less : AppTexts.more,
                        style: const TextStyle(
                          color: AppColors.lavenderBlue,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(width: 4),
                      Icon(
                        isExpanded ? Icons.arrow_upward : Icons.arrow_downward,
                        color: AppColors.lavenderBlue,
                        size: 18,
                      ),
                    ],
                  ),
                )
                : const SizedBox.shrink(),
          ],
        );
      },
    );
  }

  @override
  void dispose() {
    _isExpanded.dispose();
    super.dispose();
  }
}
