import 'package:flutter/material.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/spacing/app_spacing.dart';
import '../../core/navigation/bottom_nav_item.dart';
import 'bottom_nav_bar_item.dart';

/// Bottom Navigation Bar yang fully customizable dan reusable
/// 
/// Fitur:
/// - Item dapat di-customize per page
/// - Icon akan menjadi solid/aktif dengan animasi elegant
/// - Mendukung badge untuk notifikasi (e.g. keranjang)
/// - Transisi smooth dengan curve elegan
/// - Modern minimalist design dengan dark theme
/// 
/// Penggunaan:
/// ```dart
/// AppBottomNavBar(
///   items: [
///     BottomNavItem(icon: Icons.home, label: 'Home', route: '/home'),
///     BottomNavItem(icon: Icons.explore, label: 'Explore', route: '/explore'),
///     // ...
///   ],
///   currentRoute: '/home',
///   onNavigate: (route) {
///     Navigator.pushNamed(context, route);
///   },
/// )
/// ```
class AppBottomNavBar extends StatelessWidget {
  /// List item navigation
  final List<BottomNavItem> items;

  /// Route yang saat ini aktif
  final String currentRoute;

  /// Callback saat item di-tap
  final Function(String route) onNavigate;

  /// Callback untuk update badge count (opsional)
  final Map<String, int>? badgeCounts;

  /// Custom padding (default: all 0)
  final EdgeInsets? padding;

  /// Custom height (default: auto)
  final double? height;

  /// Background color (default: surfaceBase dengan opacity)
  final Color? backgroundColor;

  /// Border radius di atas bar (default: 24)
  final double borderRadius;

  /// Shadow elevation (default: 8)
  final double elevation;

  const AppBottomNavBar({
    required this.items,
    required this.currentRoute,
    required this.onNavigate,
    this.badgeCounts,
    this.padding,
    this.height,
    this.backgroundColor,
    this.borderRadius = 24,
    this.elevation = 8,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: backgroundColor ??
            AppColors.surfaceBase.withValues(alpha: 0.6),
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(borderRadius),
          topRight: Radius.circular(borderRadius),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.3),
            blurRadius: elevation,
            offset: Offset(0, -elevation / 2),
          ),
        ],
      ),
      child: Padding(
        padding: padding ??
            const EdgeInsets.symmetric(
              horizontal: AppSpacing.lg,
              vertical: AppSpacing.md,
            ),
        child: SizedBox(
          height: height,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: List.generate(
              items.length,
              (index) => BottomNavBarItem(
                icon: items[index].icon,
                label: items[index].label,
                isActive: items[index].route == currentRoute,
                onTap: () => onNavigate(items[index].route),
                badgeCount: badgeCounts != null
                    ? badgeCounts![items[index].route]
                    : items[index].badgeCount,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
