import 'package:flutter/material.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/spacing/app_spacing.dart';
import '../../core/theme/typography/app_typography.dart';

class ProductDetailsList extends StatelessWidget {
  final Map<String, String> details;

  const ProductDetailsList({
    super.key,
    required this.details,
  });

  @override
  Widget build(BuildContext context) {
    final entries = details.entries.toList();
    return Column(
      children: [
        for (final e in entries) ...[
          Container(
            padding: const EdgeInsets.symmetric(vertical: 10),
            decoration: const BoxDecoration(
              border: Border(bottom: BorderSide(color: Color(0xFFE3E3E3), width: 0.7)),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(width: 120, child: Text(e.key, style: AppTypography.bodySmall.copyWith(color: AppColors.textSecondary))),
                const SizedBox(width: AppSpacing.md),
                Expanded(child: Text(e.value, style: AppTypography.bodySmall.copyWith(color: AppColors.textPrimary))),
              ],
            ),
          ),
        ]
      ],
    );
  }
}
