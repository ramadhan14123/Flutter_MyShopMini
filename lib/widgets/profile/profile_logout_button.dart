import 'package:flutter/material.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/spacing/app_spacing.dart';
import '../../core/theme/typography/app_typography.dart';
import '../../core/theme/icons/app_icons.dart';

class ProfileLogoutButton extends StatelessWidget {
  final VoidCallback? onLogout;

  const ProfileLogoutButton({
    super.key,
    this.onLogout,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: AppColors.accentPink.withOpacity(0.3),
          width: 1.5,
        ),
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onLogout,
          borderRadius: BorderRadius.circular(12),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  AppIcons.logOut,
                  color: AppColors.accentPink,
                  size: 20,
                ),
                const SizedBox(width: AppSpacing.sm),
                Text(
                  'Logout',
                  style: AppTypography.labelLarge.copyWith(
                    color: AppColors.accentPink,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
