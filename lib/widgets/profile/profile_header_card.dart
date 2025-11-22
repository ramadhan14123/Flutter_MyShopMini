import 'package:flutter/material.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/spacing/app_spacing.dart';
import '../../core/theme/typography/app_typography.dart';
import '../../core/theme/icons/app_icons.dart';

class ProfileHeaderCard extends StatelessWidget {
  final String name;
  final String email;
  final String? imageAsset;
  final VoidCallback? onEditProfile;

  const ProfileHeaderCard({
    super.key,
    required this.name,
    required this.email,
    this.imageAsset,
    this.onEditProfile,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(AppSpacing.lg),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            AppColors.accentBlue.withOpacity(0.15),
            AppColors.accentPink.withOpacity(0.1),
          ],
        ),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: AppColors.surfaceMuted.withOpacity(0.3),
          width: 1,
        ),
      ),
      child: Column(
        children: [
          // Avatar with gradient border
          Container(
            padding: const EdgeInsets.all(4),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              gradient: LinearGradient(
                colors: [
                  AppColors.accentBlue,
                  AppColors.accentPink,
                ],
              ),
            ),
            child: Container(
              padding: const EdgeInsets.all(3),
              decoration: const BoxDecoration(
                color: AppColors.surfaceBase,
                shape: BoxShape.circle,
              ),
              child: CircleAvatar(
                radius: 45,
                backgroundColor: AppColors.surfaceElevated,
                backgroundImage: imageAsset != null 
                    ? AssetImage(imageAsset!) 
                    : null,
                child: imageAsset == null
                    ? const Icon(
                        AppIcons.user,
                        size: 45,
                        color: AppColors.accentBlue,
                      )
                    : null,
              ),
            ),
          ),
          const SizedBox(height: AppSpacing.md),
          Text(
            name,
            style: AppTypography.headingMedium.copyWith(
              color: AppColors.textPrimary,
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(height: AppSpacing.xs),
          Text(
            email,
            style: AppTypography.bodyMedium.copyWith(
              color: AppColors.textSecondary,
            ),
          ),
          const SizedBox(height: AppSpacing.md),
          // Edit Profile Button
          TextButton.icon(
            onPressed: onEditProfile,
            icon: Icon(
              AppIcons.edit,
              size: 16,
              color: AppColors.accentBlue,
            ),
            label: Text(
              'Edit Profile',
              style: AppTypography.bodySmall.copyWith(
                color: AppColors.accentBlue,
                fontWeight: FontWeight.w600,
              ),
            ),
            style: TextButton.styleFrom(
              backgroundColor: AppColors.accentBlue.withOpacity(0.1),
              padding: const EdgeInsets.symmetric(
                horizontal: 16,
                vertical: 8,
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
