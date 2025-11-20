import 'package:flutter/material.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/typography/app_typography.dart';
import '../../core/theme/spacing/app_spacing.dart';

class WelcomeButton extends StatefulWidget {
  final String label;
  final VoidCallback? onPressed;
  final bool loading;
  final IconData? icon;
  final bool isOutlined;

  const WelcomeButton({
    super.key,
    required this.label,
    this.onPressed,
    this.loading = false,
    this.icon,
    this.isOutlined = false,
  });

  @override
  State<WelcomeButton> createState() => _WelcomeButtonState();
}

class _WelcomeButtonState extends State<WelcomeButton> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    if (widget.isOutlined) {
      return _buildOutlinedButton();
    }
    return _buildFilledButton();
  }

  Widget _buildFilledButton() {
    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: GestureDetector(
        onTap: widget.loading ? null : widget.onPressed,
        child: Container(
          height: AppSpacing.buttonHeightLg,
          decoration: BoxDecoration(
            gradient: _isHovered
                ? LinearGradient(
                    colors: [
                      AppColors.orangeHover,
                      AppColors.pinkHover,
                    ],
                    begin: Alignment.centerLeft,
                    end: Alignment.centerRight,
                  )
                : AppGradients.buttonCta,
            borderRadius: BorderRadius.circular(AppSpacing.radiusMd),
            boxShadow: _isHovered
                ? [
                    BoxShadow(
                      color: AppColors.accentPink.withAlpha(102),
                      blurRadius: 16,
                      offset: const Offset(0, 8),
                    ),
                  ]
                : [],
          ),
          child: Center(
            child: widget.loading
                ? const SizedBox(
                    height: 20,
                    width: 20,
                    child: CircularProgressIndicator(
                      strokeWidth: 2,
                      valueColor:
                          AlwaysStoppedAnimation<Color>(AppColors.textPrimary),
                    ),
                  )
                : Row(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      if (widget.icon != null) ...[
                        Icon(
                          widget.icon,
                          color: AppColors.textPrimary,
                          size: AppSpacing.iconMd,
                        ),
                        const SizedBox(width: AppSpacing.md),
                      ],
                      Text(
                        widget.label,
                        style: AppTypography.labelLarge
                            .copyWith(color: AppColors.textPrimary),
                      ),
                    ],
                  ),
          ),
        ),
      ),
    );
  }

  Widget _buildOutlinedButton() {
    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: GestureDetector(
        onTap: widget.loading ? null : widget.onPressed,
        child: Container(
          height: AppSpacing.buttonHeightLg,
          decoration: BoxDecoration(
            border: Border.all(
              color: _isHovered ? AppColors.accentPink : AppColors.surfaceMuted,
              width: 1.5,
            ),
            borderRadius: BorderRadius.circular(AppSpacing.radiusMd),
            color: _isHovered
              ? AppColors.accentPink.withAlpha(26)
              : Colors.transparent,
          ),
          child: Center(
            child: widget.loading
                ? const SizedBox(
                    height: 20,
                    width: 20,
                    child: CircularProgressIndicator(
                      strokeWidth: 2,
                      valueColor:
                          AlwaysStoppedAnimation<Color>(AppColors.accentPink),
                    ),
                  )
                : Text(
                    widget.label,
                    style: AppTypography.labelLarge.copyWith(
                      color: _isHovered
                          ? AppColors.accentPink
                          : AppColors.textSecondary,
                    ),
                  ),
          ),
        ),
      ),
    );
  }
}
