import 'package:flutter/material.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/spacing/app_spacing.dart';
import '../../core/theme/typography/app_typography.dart';

/// Widget item individual bottom navigation bar dengan animasi elegant
/// 
/// Features:
/// - Icon berubah solid saat aktif
/// - Background berubah dengan transisi smooth
/// - Label dengan opacity animation
/// - Badge support untuk notifikasi
class BottomNavBarItem extends StatefulWidget {
  /// Icon yang ditampilkan
  final IconData icon;

  /// Label untuk item
  final String label;

  /// Apakah item ini sedang aktif
  final bool isActive;

  /// Callback saat item di-tap
  final VoidCallback onTap;

  /// Badge count (opsional)
  final int? badgeCount;

  const BottomNavBarItem({
    required this.icon,
    required this.label,
    required this.isActive,
    required this.onTap,
    this.badgeCount,
    super.key,
  });

  @override
  State<BottomNavBarItem> createState() => _BottomNavBarItemState();
}

class _BottomNavBarItemState extends State<BottomNavBarItem>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _scaleAnimation;
  late Animation<double> _opacityAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 600),
      vsync: this,
    );

    _scaleAnimation = Tween<double>(begin: 0.8, end: 1.0).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.elasticOut),
    );

    _opacityAnimation = Tween<double>(begin: 0.6, end: 1.0).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeInOut),
    );

    if (widget.isActive) {
      _animationController.forward();
    }
  }

  @override
  void didUpdateWidget(BottomNavBarItem oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.isActive && !oldWidget.isActive) {
      _animationController.forward();
    } else if (!widget.isActive && oldWidget.isActive) {
      _animationController.reverse();
    }
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GestureDetector(
        onTap: widget.onTap,
        child: Stack(
          alignment: Alignment.center,
          children: [
            // Background container dengan animasi
            AnimatedContainer(
              duration: const Duration(milliseconds: 400),
              curve: Curves.easeInOut,
              decoration: BoxDecoration(
                color: widget.isActive
                    ? AppColors.surfaceBase.withValues(alpha: 0.4)
                    : Colors.transparent,
                borderRadius: BorderRadius.circular(12),
              ),
              padding: const EdgeInsets.symmetric(
                horizontal: AppSpacing.md,
                vertical: AppSpacing.md,
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // Icon dengan animasi
                  ScaleTransition(
                    scale: _scaleAnimation,
                    child: Opacity(
                      opacity: _opacityAnimation.value,
                      child: Icon(
                        widget.icon,
                        size: 24,
                        color: widget.isActive
                            ? AppColors.accentOrange
                            : AppColors.textSecondary,
                      ),
                    ),
                  ),
                  const SizedBox(height: AppSpacing.xs),
                  // Label dengan transisi opacity
                  AnimatedOpacity(
                    opacity: widget.isActive ? 1.0 : 0.7,
                    duration: const Duration(milliseconds: 300),
                    child: Text(
                      widget.label,
                      style: AppTypography.labelSmall.copyWith(
                        color: widget.isActive
                            ? AppColors.textPrimary
                            : AppColors.textSecondary,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
            ),
            // Badge untuk notifikasi (e.g. keranjang)
            if (widget.badgeCount != null && widget.badgeCount! > 0)
              Positioned(
                top: 4,
                right: 4,
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 6,
                    vertical: 2,
                  ),
                  decoration: BoxDecoration(
                    color: AppColors.accentPink,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    widget.badgeCount.toString(),
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 10,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
