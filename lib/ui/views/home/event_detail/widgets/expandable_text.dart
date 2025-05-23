import 'package:flutter/material.dart';

import '../../../../../generated/l10n/app_localizations.dart';
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

  static const maxTextLengthForTwoLines = 100;

  bool get _isTextOverflowing {
    final textLength = widget.text.length;
    return textLength > maxTextLengthForTwoLines;
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
            if (_isTextOverflowing)
              GestureDetector(
                onTap: () {
                  _isExpanded.value = !_isExpanded.value;
                },
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      isExpanded
                          ? AppLocalizations.of(context).less
                          : AppLocalizations.of(context).more,
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
              ),
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
