import 'package:flutter/material.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/spacing/app_spacing.dart';
import '../../core/theme/typography/app_typography.dart';
import 'animated_search_field.dart';

class AppHeader extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final bool titleOnRight;
  final List<Widget> leftActions; 
  final List<Widget> rightActions;
  final double height;
  final EdgeInsetsGeometry padding;
  final Widget? customTitle; 

  const AppHeader({
    super.key,
    required this.title,
    this.titleOnRight = false,
    this.leftActions = const [],
    this.rightActions = const [],
    this.height = 64,
    this.padding = const EdgeInsets.symmetric(horizontal: AppSpacing.lg, vertical: AppSpacing.sm),
    this.customTitle,
  });

  @override
  Size get preferredSize => Size.fromHeight(height);

  @override
  Widget build(BuildContext context) {
    final Widget titleWidget = customTitle ?? Text(
        title,
        style: AppTypography.headingMedium.copyWith(color: AppColors.textPrimary),
      );
    return Container(
      padding: padding,
      decoration: const BoxDecoration(
        color: AppColors.backgroundDeep,
        border: Border(bottom: BorderSide(color: AppColors.surfaceMuted, width: 0.7)),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          if (!titleOnRight) titleWidget,
          if (!titleOnRight) const SizedBox(width: AppSpacing.md),
          if (!titleOnRight)
            Expanded(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: _wrapActions(leftActions + rightActions),
              ),
            ),
          if (titleOnRight)
            Expanded(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: _wrapActions(leftActions),
              ),
            ),
          if (titleOnRight) const SizedBox(width: AppSpacing.md),
          if (titleOnRight) titleWidget,
          if (titleOnRight && rightActions.isNotEmpty) const SizedBox(width: AppSpacing.md),
          if (titleOnRight && rightActions.isNotEmpty)
            Row(children: _wrapActions(rightActions)),
        ],
      ),
    );
  }
}

List<Widget> _wrapActions(List<Widget> actions) {
  if (actions.isEmpty) return [];
  final List<Widget> out = [];
  for (var i = 0; i < actions.length; i++) {
    final w = actions[i];
    if (w is AnimatedSearchField) {
      out.add(Expanded(child: w));
    } else {
      out.add(w);
    }
    if (i != actions.length - 1) {
      out.add(const SizedBox(width: AppSpacing.md));
    }
  }
  return out;
}
