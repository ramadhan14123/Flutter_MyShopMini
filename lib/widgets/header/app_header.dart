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
  final bool includeStatusBar; // tambahkan opsi untuk safe area atas

  const AppHeader({
    super.key,
    required this.title,
    this.titleOnRight = false,
    this.leftActions = const [],
    this.rightActions = const [],
    this.height = 64,
    this.padding = const EdgeInsets.symmetric(horizontal: AppSpacing.lg, vertical: AppSpacing.sm),
    this.customTitle,
    this.includeStatusBar = true,
  });

  @override
  Size get preferredSize => Size.fromHeight(height + (includeStatusBar ? _statusBarHeight : 0));

  double get _statusBarHeight {
    // Mengambil viewPadding.top langsung dari platform dispatcher (works for notch)
    final views = WidgetsBinding.instance.platformDispatcher.views;
    if (views.isNotEmpty) {
      return views.first.viewPadding.top;
    }
    return 0;
  }

  @override
  Widget build(BuildContext context) {
    final Widget titleWidget = customTitle ?? Text(
        title,
        style: AppTypography.headingMedium.copyWith(color: AppColors.textPrimary),
      );
    final topInset = includeStatusBar ? MediaQuery.of(context).padding.top : 0.0;
    // Gabungkan padding asli dengan padding status bar agar konten turun aman
    final resolvedPadding = padding.add(EdgeInsets.only(top: topInset));

    return Container(
      padding: resolvedPadding,
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
