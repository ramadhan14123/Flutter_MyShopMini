import 'package:flutter/material.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/typography/app_typography.dart';

class SizeChip extends StatelessWidget {
  final String label;
  final bool selected;
  final bool disabled;
  final VoidCallback onTap;

  const SizeChip({
    super.key,
    required this.label,
    required this.selected,
    required this.disabled,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final baseColor = disabled ? AppColors.surfaceMuted.withOpacity(0.3) : (selected ? AppColors.accentPink : AppColors.surfaceElevated);
    final textColor = disabled ? AppColors.textSecondary.withOpacity(0.5) : (selected ? AppColors.textPrimary : AppColors.textSecondary);
    final borderColor = disabled ? AppColors.surfaceMuted.withOpacity(0.3) : (selected ? AppColors.accentPink : AppColors.surfaceMuted.withOpacity(0.4));
    return InkWell(
      onTap: disabled ? null : onTap,
      borderRadius: BorderRadius.circular(8),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 10),
        decoration: BoxDecoration(
          color: baseColor,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: borderColor, width: 1),
        ),
        child: Text(label, style: AppTypography.bodySmall.copyWith(color: textColor, fontWeight: FontWeight.w600)),
      ),
    );
  }
}
