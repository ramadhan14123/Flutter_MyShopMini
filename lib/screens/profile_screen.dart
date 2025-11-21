import 'package:flutter/material.dart';
import '../widgets/header/app_header.dart';
import '../core/theme/app_colors.dart';
import '../core/theme/spacing/app_spacing.dart';
import '../core/theme/typography/app_typography.dart';
import '../core/theme/icons/app_icons.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundMain,
      appBar: AppHeader(
        title: 'Profile',
        titleOnRight: false,
      ),
      body: Container(
        decoration: const BoxDecoration(gradient: AppGradients.backgroundGradient),
        child: Padding(
          padding: const EdgeInsets.all(AppSpacing.lg),
          child: ListView(
            children: [
              // Profile Header
              Center(
                child: Column(
                  children: [
                    CircleAvatar(
                      radius: 50,
                      backgroundColor: AppColors.accentBlue,
                      child: const Icon(
                        AppIcons.user,
                        size: 50,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(height: AppSpacing.md),
                    Text(
                      'John Doe',
                      style: AppTypography.headingMedium,
                    ),
                    const SizedBox(height: AppSpacing.xs),
                    Text(
                      'john@example.com',
                      style: AppTypography.bodySmall.copyWith(
                        color: AppColors.textSecondary,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: AppSpacing.xl),
              // Profile Menu
              _buildMenuItem(
                icon: AppIcons.user,
                title: 'Edit Profile',
                onTap: () {},
              ),
              _buildMenuItem(
                icon: AppIcons.cart,
                title: 'My Orders',
                onTap: () {},
              ),
              _buildMenuItem(
                icon: AppIcons.heart,
                title: 'Wishlist',
                onTap: () {},
              ),
              const SizedBox(height: AppSpacing.lg),
              // Logout Button
              Container(
                decoration: BoxDecoration(
                  color: AppColors.accentPink.withValues(alpha: 0.2),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Material(
                  color: Colors.transparent,
                  child: InkWell(
                    onTap: () {},
                    borderRadius: BorderRadius.circular(12),
                    child: Padding(
                      padding: const EdgeInsets.all(AppSpacing.md),
                      child: Center(
                        child: Text(
                          'Logout',
                          style: AppTypography.labelLarge.copyWith(
                            color: AppColors.accentPink,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildMenuItem({
    required IconData icon,
    required String title,
    required VoidCallback onTap,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: AppSpacing.md),
      decoration: BoxDecoration(
        color: AppColors.surfaceBase,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(12),
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: AppSpacing.md,
              vertical: AppSpacing.sm,
            ),
            child: Row(
              children: [
                Icon(
                  icon,
                  color: AppColors.accentOrange,
                  size: 20,
                ),
                const SizedBox(width: AppSpacing.md),
                Expanded(
                  child: Text(
                    title,
                    style: AppTypography.bodyMedium,
                  ),
                ),
                const Icon(
                  Icons.arrow_forward_ios,
                  size: 16,
                  color: AppColors.textSecondary,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
